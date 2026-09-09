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
    Write-Host "❌ Error: Could not find 'credentials.json'." -ForegroundColor Red
    Write-Host "Please put 'credentials.json' in this folder and try again." -ForegroundColor Red
    Pause
    exit
}

Write-Host "✅ Found credentials at: $credFile" -ForegroundColor Green

$json = Get-Content $credFile -Raw | ConvertFrom-Json
$installed = $json.installed
if (-not $installed) {
    $installed = $json.web
}

if (-not $installed) {
    Write-Host "❌ Error: Invalid credentials.json format." -ForegroundColor Red
    Pause
    exit
}

$clientId = $installed.client_id
$clientSecret = $installed.client_secret
$port = 51234
$redirectUri = "http://127.0.0.1:$port/"
$scope = "https://mail.google.com/ https://www.googleapis.com/auth/contacts"

$authUrl = "https://accounts.google.com/o/oauth2/v2/auth?client_id=$clientId&redirect_uri=$redirectUri&response_type=code&scope=$([uri]::EscapeDataString($scope))&access_type=offline&prompt=consent"

Write-Host "🌐 Opening browser for Google login..."
Write-Host "   (Browser will open automatically. Complete the login to catch the code.)" -ForegroundColor Yellow

# Start Local Listener
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($redirectUri)
try {
    $listener.Start()
} catch {
    Write-Host "❌ Error: Could not start local server on port 51234. Is another program using it?" -ForegroundColor Red
    Pause
    exit
}

# Open Browser
Start-Process $authUrl

Write-Host "Waiting for authentication..." -ForegroundColor Cyan

$context = $listener.GetContext()
$request = $context.Request
$response = $context.Response

$code = $null
if ($request.Url.Query.Contains("code=")) {
    $parts = $request.Url.Query.TrimStart('?').Split('&')
    foreach ($part in $parts) {
        if ($part -match "^code=(.*)") {
            $code = $matches[1]
        }
    }
}

# Send Response to Browser
$isSuccess = ($null -ne $code)
$resText = if ($isSuccess) {
    "<html><body style='font-family: Arial, sans-serif; text-align: center; padding: 50px; background: #1a1a1a; color: #fff;'><h1>Authentication Successful! ✅</h1><p>You can close this window now and return to the terminal.</p></body></html>"
} else {
    "<html><body style='font-family: Arial, sans-serif; text-align: center; padding: 50px; background: #330000; color: #fff;'><h1>Authentication Failed ❌</h1><p>Failed to get authorization code. You can close this window.</p></body></html>"
}
$buffer = [System.Text.Encoding]::UTF8.GetBytes($resText)
$response.ContentLength64 = $buffer.Length
$response.OutputStream.Write($buffer, 0, $buffer.Length)
$response.Close()
$listener.Stop()

if ($code) {
    Write-Host "✅ Code received! Generating token..." -ForegroundColor Green
    
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
        # Compress removes formatting (minified JSON)
        $tokenJson = $tokenRes | ConvertTo-Json -Depth 10 -Compress
        
        $tokenPath = "token.json"
        Set-Content -Path $tokenPath -Value $tokenJson
        
        Write-Host "--------------------------------------------------"
        Write-Host "✅ Success! Copy the entire string below and paste it into the 'GOOGLE_TOKEN' variable in Koyeb:" -ForegroundColor Green
        Write-Host ""
        Write-Host $tokenJson -ForegroundColor Magenta
        Write-Host ""
        Write-Host "--------------------------------------------------"
    } catch {
        Write-Host "❌ Error exchanging code for token: $_" -ForegroundColor Red
    }
} else {
    Write-Host "❌ Failed to get authorization code." -ForegroundColor Red
}

Write-Host "Press Enter to exit..."
Read-Host | Out-Null
