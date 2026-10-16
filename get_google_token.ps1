$ErrorActionPreference = 'Stop'

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "   Cipher-MD Google Token Generator      " -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

$credPaths = @("credentials.json", "..\credentials.json", "..\..\credentials.json")
$credFile = $null

foreach ($path in $credPaths) {
    if (Test-Path $path) {
        $credFile = $path
        break
    }
}

if (-not $credFile) {
    Write-Host "[ERROR] Could not find 'credentials.json'." -ForegroundColor Red
    Write-Host "Please put 'credentials.json' in this folder and try again." -ForegroundColor Red
    Pause
    exit
}

Write-Host "[OK] Found credentials at: $credFile" -ForegroundColor Green

$json = Get-Content $credFile -Raw | ConvertFrom-Json
$installed = $json.installed
if (-not $installed) {
    $installed = $json.web
}
if (-not $installed) {
    $installed = $json
}

if (-not $installed.client_id -or -not $installed.client_secret) {
    Write-Host "[ERROR] Invalid credentials.json format." -ForegroundColor Red
    Pause
    exit
}

$clientId = $installed.client_id
$clientSecret = $installed.client_secret
$port = 51234
$redirectUri = "http://127.0.0.1:$port/"
$scope = "https://mail.google.com/ https://www.googleapis.com/auth/contacts https://www.googleapis.com/auth/calendar https://www.googleapis.com/auth/tasks"

$authUrl = "https://accounts.google.com/o/oauth2/v2/auth?client_id=$([uri]::EscapeDataString($clientId))&redirect_uri=$([uri]::EscapeDataString($redirectUri))&response_type=code&scope=$([uri]::EscapeDataString($scope))&access_type=offline&prompt=consent"

function Extract-AuthCode([string]$inputStr) {
    if ([string]::IsNullOrWhiteSpace($inputStr)) { return $null }
    if ($inputStr -match '[?&]code=([^&\s#]+)') {
        return [uri]::UnescapeDataString($matches[1])
    }
    if ($inputStr -match '^code=([^&\s#]+)') {
        return [uri]::UnescapeDataString($matches[1])
    }
    return [uri]::UnescapeDataString($inputStr.Trim())
}

Write-Host "[INFO] Opening browser for Google login..."
Write-Host "   (Browser will open automatically. Complete the login to catch the code.)" -ForegroundColor Yellow
Write-Host ""
Write-Host "Login URL:" -ForegroundColor Cyan
Write-Host $authUrl
Write-Host ""

$code = $null
$listener = $null

try {
    # Use TcpListener on 127.0.0.1 so Administrator privileges are NEVER required on Windows
    $endpoint = New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Loopback, $port)
    $listener = New-Object System.Net.Sockets.TcpListener($endpoint)
    $listener.Start()

    Start-Process $authUrl

    Write-Host "[WAIT] Waiting for authentication on port $port..." -ForegroundColor Cyan
    $client = $listener.AcceptTcpClient()
    $stream = $client.GetStream()
    $reader = New-Object System.IO.StreamReader($stream, [System.Text.Encoding]::ASCII)

    $requestLine = $reader.ReadLine()
    # Consume remaining HTTP headers
    while ($true) {
        $headerLine = $reader.ReadLine()
        if ([string]::IsNullOrEmpty($headerLine)) { break }
    }

    if ($requestLine -and ($requestLine -match 'GET\s+([^\s]+)\s+HTTP')) {
        $reqPath = $matches[1]
        if ($reqPath -match '[?&]code=([^&\s#]+)') {
            $code = [uri]::UnescapeDataString($matches[1])
        }
    }

    $isSuccess = ($null -ne $code -and $code.Length -gt 0)
    $bodyHtml = if ($isSuccess) {
        '<html><body style="font-family: Arial, sans-serif; text-align: center; padding: 50px; background: #1a1a1a; color: #fff;"><h1>Authentication Successful! &#9989;</h1><p>You can close this window now and return to the terminal.</p></body></html>'
    } else {
        '<html><body style="font-family: Arial, sans-serif; text-align: center; padding: 50px; background: #330000; color: #fff;"><h1>Authentication Failed &#10060;</h1><p>Failed to get authorization code. You can close this window.</p></body></html>'
    }

    $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($bodyHtml)
    $headerText = "HTTP/1.1 200 OK`r`nContent-Type: text/html; charset=utf-8`r`nContent-Length: $($bodyBytes.Length)`r`nConnection: close`r`n`r`n"
    $headerBytes = [System.Text.Encoding]::ASCII.GetBytes($headerText)

    $stream.Write($headerBytes, 0, $headerBytes.Length)
    $stream.Write($bodyBytes, 0, $bodyBytes.Length)
    $stream.Flush()

    $client.Close()
    $listener.Stop()
} catch {
    if ($listener) {
        try { $listener.Stop() } catch {}
    }
    try { Start-Process $authUrl } catch {}
}

if (-not $code) {
    Write-Host ""
    Write-Host "Copy the redirected URL (http://127.0.0.1:$port/?code=...) from your browser address bar:" -ForegroundColor Yellow
    $manualInput = Read-Host "Paste URL or code here"
    $code = Extract-AuthCode $manualInput
}

if ($code) {
    Write-Host "[OK] Code received! Generating token..." -ForegroundColor Green
    
    $tokenUrl = "https://oauth2.googleapis.com/token"
    $body = @{
        code = $code
        client_id = $clientId
        client_secret = $clientSecret
        redirect_uri = $redirectUri
        grant_type = "authorization_code"
    }
    
    try {
        $tokenRes = Invoke-RestMethod -Uri $tokenUrl -Method Post -Body $body
        $tokenJson = $tokenRes | ConvertTo-Json -Depth 10 -Compress
        
        $tokenPath = "token.json"
        [System.IO.File]::WriteAllText((Join-Path (Get-Location) $tokenPath), $tokenJson, (New-Object System.Text.UTF8Encoding($false)))
        
        Write-Host "--------------------------------------------------"
        Write-Host "[SUCCESS] Copy the entire string below and paste it into the 'GOOGLE_TOKEN' variable in Koyeb:" -ForegroundColor Green
        Write-Host ""
        Write-Host $tokenJson -ForegroundColor Magenta
        Write-Host ""
        Write-Host "--------------------------------------------------"
    } catch {
        Write-Host "[ERROR] Error exchanging code for token: $_" -ForegroundColor Red
    }
} else {
    Write-Host "[ERROR] Failed to get authorization code." -ForegroundColor Red
}

Write-Host "Press Enter to exit..."
Read-Host | Out-Null
