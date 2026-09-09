@echo off
goto :VERIFY_EXECUTION
:VERIFY_EXECUTION_FAILED
echo.
echo =================================================================
echo [ERROR] This script cannot be run by piping into cmd.
echo Piping breaks delayed expansion and causes variables to corrupt.
echo =================================================================
echo.
echo Please use the following PowerShell command to install correctly:
echo.
echo irm https://cipher-md.syntiox.top/install.cmd -OutFile install.cmd ; .\install.cmd
echo.
exit /b 1

:VERIFY_EXECUTION
setlocal ENABLEDELAYEDEXPANSION
title Cipher-MD Installer


set TARGET_DIR=%APPDATA%\.sh4lu-z\CIPHER MD
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"
attrib +h "%APPDATA%\.sh4lu-z"
cd /d "%TARGET_DIR%"

echo Downloading Cipher-MD...
curl -L -o Cipher-MD.zip https://github.com/sh4lu-z/Cipher-MD/archive/refs/heads/main.zip

:: 6. Smart Install - Preserve .env and optionally node_modules
if exist "Cipher-MD-main\.env" (
    echo [INFO] Backing up existing .env file...
    copy /Y "Cipher-MD-main\.env" ".env.backup" >nul
)

set "CLEAN_INSTALL=Y"
if exist "Cipher-MD-main\node_modules" (
    echo.
    echo [INFO] Existing node_modules found.
    set /p CLEAN_INSTALL="Do you want to do a clean install and re-download all modules? (Y/N): "
)

if /i "!CLEAN_INSTALL!"=="Y" (
    if exist "Cipher-MD-main" (
        echo Removing old files for a clean install...
        rmdir /s /q "Cipher-MD-main"
    )
) else (
    echo Keeping existing node_modules. Only missing/updated modules will be downloaded.
)

echo Extracting files...
tar -xf Cipher-MD.zip
del Cipher-MD.zip
cd Cipher-MD-main

if exist "..\.env.backup" (
    echo [INFO] Restoring backed up .env file...
    copy /Y "..\.env.backup" ".env" >nul
    del "..\.env.backup"
)

:: 3. Handle .env Overwrite
set "CREATE_ENV=Y"
if exist ".env" (
    echo.
    echo [WARNING] An existing .env file was found.
    set /p OVERWRITE_ENV="Do you want to overwrite it? (Y/N): "
    if /i "!OVERWRITE_ENV!" neq "Y" (
        set "CREATE_ENV=N"
        echo Skipping .env setup...
    )
)

if "!CREATE_ENV!"=="Y" (
    echo.
    echo Please enter the following Environment Variables.
    echo ^(If a variable is not needed, just press Enter to skip it^)
    echo.

    :: Basic Validation Loop for Session ID
    :INPUT_SESSION
    set /p SESSION_ID="Your WhatsApp Session ID (Required): "
    if "!SESSION_ID!"=="" (
        echo Session ID cannot be empty.
        goto INPUT_SESSION
    )
    
    set /p PAIRING_NUMBER="Number to get pairing code (Required): "
    set /p MONGO_URL="MongoDB Database URL (Required): "
    
    echo.
    echo --- Optional Variables ---
    set /p OWNER_NUMBER="Owner's phone number (Optional): "
    set /p BOT_NAME="Bot Name: "
    set /p FOOTER="Footer Text: "
    set /p MENU_IMAGE="Menu Image URL: "
    set /p GROQ_API_KEY="Groq API Key (comma separated): "
    set /p GEMINI_API_KEY="Gemini API Key: "
    set /p FIRECRAWL_API_KEY="Firecrawl API Key: "
    set /p HF_TOKEN="HuggingFace Token: "
    set /p NASA_API_KEY="NASA API Key: "
    set /p RAPID_API_KEY="Rapid API Key: "
    set /p SYNTIOX_API_KEY="Syntiox API Key: "
    set /p VT_API_KEY="VirusTotal API Key: "
    set /p AI_CHAT_PLATFORM="AI Chat Platform (default: google): "
    set /p AI_CHAT_MODEL="AI Chat Model (default: gemini-3.1-flash-lite): "
    set /p AI_AGENT_PLATFORM="AI Agent Platform (default: google): "
    set /p AI_AGENT_MODEL="AI Agent Model (default: gemini-3.1-flash-lite): "
    echo.
    echo [Agentic Tasks - Emails, Calendar, etc.]
    set /p GOOGLE_CREDENTIALS="Google Credentials JSON (Paste single line OR Drag & Drop file here): "
    set "GC_TMP=!GOOGLE_CREDENTIALS:"=!"
    if exist "!GC_TMP!" (
        for /f "delims=" %%i in ('powershell -noprofile -command "(Get-Content -Path '!GC_TMP!' -Raw) -replace '\s+',''"') do set "GOOGLE_CREDENTIALS=%%i"
    )

    set /p GOOGLE_TOKEN="Google Token JSON (Paste single line OR Drag & Drop file here): "
    set "GT_TMP=!GOOGLE_TOKEN:"=!"
    if exist "!GT_TMP!" (
        for /f "delims=" %%i in ('powershell -noprofile -command "(Get-Content -Path '!GT_TMP!' -Raw) -replace '\s+',''"') do set "GOOGLE_TOKEN=%%i"
    )

    echo SESSION_ID="!SESSION_ID!"> .env
    echo PAIRING_NUMBER="!PAIRING_NUMBER!">> .env
    echo MONGO_URL="!MONGO_URL!">> .env
    
    if defined OWNER_NUMBER echo OWNER_NUMBER="!OWNER_NUMBER!">> .env
    if defined BOT_NAME echo BOT_NAME="!BOT_NAME!">> .env
    if defined FOOTER echo FOOTER="!FOOTER!">> .env
    if defined MENU_IMAGE echo MENU_IMAGE="!MENU_IMAGE!">> .env
    if defined GROQ_API_KEY echo GROQ_API_KEY="!GROQ_API_KEY!">> .env
    if defined GEMINI_API_KEY echo GEMINI_API_KEY="!GEMINI_API_KEY!">> .env
    if defined FIRECRAWL_API_KEY echo FIRECRAWL_API_KEY="!FIRECRAWL_API_KEY!">> .env
    if defined HF_TOKEN echo HF_TOKEN="!HF_TOKEN!">> .env
    if defined NASA_API_KEY echo NASA_API_KEY="!NASA_API_KEY!">> .env
    if defined RAPID_API_KEY echo RAPID_API_KEY="!RAPID_API_KEY!">> .env
    if defined SYNTIOX_API_KEY echo SYNTIOX_API_KEY="!SYNTIOX_API_KEY!">> .env
    if defined VT_API_KEY echo VT_API_KEY="!VT_API_KEY!">> .env
    if defined AI_CHAT_PLATFORM echo AI_CHAT_PLATFORM="!AI_CHAT_PLATFORM!">> .env
    if defined AI_CHAT_MODEL echo AI_CHAT_MODEL="!AI_CHAT_MODEL!">> .env
    if defined AI_AGENT_PLATFORM echo AI_AGENT_PLATFORM="!AI_AGENT_PLATFORM!">> .env
    if defined AI_AGENT_MODEL echo AI_AGENT_MODEL="!AI_AGENT_MODEL!">> .env
    if defined GOOGLE_CREDENTIALS echo GOOGLE_CREDENTIALS='!GOOGLE_CREDENTIALS!'>> .env
    if defined GOOGLE_TOKEN echo GOOGLE_TOKEN='!GOOGLE_TOKEN!'>> .env
)

:: 2. Check and Install Git
echo Checking for Git...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Git is not installed. Attempting to install via winget...
    winget install --id Git.Git -e --source winget --accept-package-agreements --accept-source-agreements --silent
    set "PATH=!PATH!;C:\Program Files\Git\cmd"
) else (
    echo Git is installed.
)

:: 2. Check and Install FFmpeg
echo Checking for FFmpeg...
ffmpeg -version >nul 2>&1
if !errorlevel! neq 0 (
    echo [INFO] FFmpeg not found in current PATH. Checking system...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$pkg = Get-ChildItem -Path ($env:LOCALAPPDATA + '\Microsoft\WinGet\Packages') -Filter '*Gyan.FFmpeg*' -Directory -ErrorAction SilentlyContinue | Select-Object -First 1; if (-not $pkg) { Write-Host '[INFO] Downloading FFmpeg via winget...'; winget install --id Gyan.FFmpeg -e --source winget --accept-package-agreements --accept-source-agreements --silent | Out-Null; $pkg = Get-ChildItem -Path ($env:LOCALAPPDATA + '\Microsoft\WinGet\Packages') -Filter '*Gyan.FFmpeg*' -Directory -ErrorAction SilentlyContinue | Select-Object -First 1 }; if ($pkg) { $bin = (Get-ChildItem -Path $pkg.FullName -Filter 'ffmpeg.exe' -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1).DirectoryName; if ($bin) { $p = [Environment]::GetEnvironmentVariable('Path', 'User'); if ($p -notmatch [regex]::Escape($bin)) { $newPath = if ($p -and -not $p.EndsWith(';')) { $p + ';' + $bin } else { $p + $bin }; [Environment]::SetEnvironmentVariable('Path', $newPath, 'User'); Write-Host '[INFO] Added FFmpeg to User PATH.' } else { Write-Host '[INFO] FFmpeg already in User PATH.' }; [IO.File]::WriteAllText($env:TEMP + '\ffmpeg_bin.txt', $bin) } }"
    
    if exist "%TEMP%\ffmpeg_bin.txt" (
        set /p FOUND_FFMPEG=<"%TEMP%\ffmpeg_bin.txt"
        del "%TEMP%\ffmpeg_bin.txt"
        if defined FOUND_FFMPEG (
            set "PATH=!PATH!;!FOUND_FFMPEG!"
            echo [INFO] Updated current session PATH with: !FOUND_FFMPEG!
        )
    )
) else (
    echo FFmpeg is installed and ready.
)

echo Checking for Node.js...
node -v >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js is not installed. Attempting to install via winget...
    winget -v >nul 2>&1
    if !errorlevel! equ 0 (
        echo winget found. Installing Node.js ^(this may take a minute^)...
        winget install OpenJS.NodeJS -e --accept-package-agreements --accept-source-agreements --silent
        if exist "C:\Program Files\nodejs\node.exe" (
            set "PATH=!PATH!;C:\Program Files\nodejs"
        )
    ) else (
        echo winget not found. Cannot auto-install Node.js.
    )
)

node -v >nul 2>&1
if %errorlevel% equ 0 (
    echo Node.js is available. Using Node.js...
    echo Installing dependencies...
    call npm install
    
    :: 5. npm install error handling
    if !errorlevel! neq 0 (
        echo [ERROR] npm install failed. Please check your internet connection and try again.
        pause
        exit /b 1
    )

    echo Setting up global commands...
    
    :: Global Commands
    set BIN_PATH=%APPDATA%\.sh4lu-z\bin
    if not exist "!BIN_PATH!" mkdir "!BIN_PATH!"
    
    echo @echo off > "!BIN_PATH!\cipher-md.bat"
    echo cd /d "%CD%" >> "!BIN_PATH!\cipher-md.bat"
    echo node start.js >> "!BIN_PATH!\cipher-md.bat"
    
    echo @echo off > "!BIN_PATH!\cipher-env.bat"
    echo notepad "%CD%\.env" >> "!BIN_PATH!\cipher-env.bat"
    
    :: Add to PATH safely using PowerShell to prevent corruption (max 1024 chars bug in setx)
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$p = [Environment]::GetEnvironmentVariable('Path', 'User'); if ($p -notmatch [regex]::Escape('%APPDATA%\.sh4lu-z\bin')) { $newPath = $p; if ($newPath -and -not $newPath.EndsWith(';')) { $newPath += ';' }; $newPath += '%APPDATA%\.sh4lu-z\bin'; [Environment]::SetEnvironmentVariable('Path', $newPath, 'User') }"
    set "PATH=!PATH!;%APPDATA%\.sh4lu-z\bin"

    :: Desktop Shortcuts
    set DESKTOP_PATH=%USERPROFILE%\Desktop\Cipher MD
    if not exist "!DESKTOP_PATH!" mkdir "!DESKTOP_PATH!"
    
    set BOTRUN_PATH=!DESKTOP_PATH!\cipher-md.bat
    echo @echo off > "!BOTRUN_PATH!"
    echo cipher-md >> "!BOTRUN_PATH!"

    set EDIT_ENV_PATH=!DESKTOP_PATH!\cipher-env.bat
    echo @echo off > "!EDIT_ENV_PATH!"
    echo cipher-env >> "!EDIT_ENV_PATH!"

    :: AI Agent Integration
    if exist "skills" (
        xcopy /E /I /Y "skills" "!DESKTOP_PATH!\skills" >nul
    )
    copy /Y "*.md" "!DESKTOP_PATH!\" >nul

    echo Setup complete! Starting the bot...
    node start.js
    pause
    exit /b 0
)

echo Node.js could not be installed. Checking for Docker...
docker -v >nul 2>&1
if %errorlevel% equ 0 (
    echo Docker is installed. Using Docker...
    echo Building Docker image...
    docker build -t cipher-md .
    
    echo Starting Docker container...
    docker rm -f cipher-md >nul 2>&1
    docker run -d --name cipher-md --env-file .env cipher-md

    echo Setting up global commands...
    
    :: Global Commands
    set BIN_PATH=%APPDATA%\.sh4lu-z\bin
    if not exist "!BIN_PATH!" mkdir "!BIN_PATH!"
    
    echo @echo off > "!BIN_PATH!\cipher-md.bat"
    echo docker start cipher-md >> "!BIN_PATH!\cipher-md.bat"
    
    echo @echo off > "!BIN_PATH!\cipher-env.bat"
    echo notepad "%CD%\.env" >> "!BIN_PATH!\cipher-env.bat"
    echo echo After saving, please restart the Docker container to apply changes. >> "!BIN_PATH!\cipher-env.bat"
    echo pause >> "!BIN_PATH!\cipher-env.bat"
    
    :: 4. Add Docker Stop and Restart Commands
    echo @echo off > "!BIN_PATH!\cipher-stop.bat"
    echo docker stop cipher-md >> "!BIN_PATH!\cipher-stop.bat"
    
    echo @echo off > "!BIN_PATH!\cipher-restart.bat"
    echo docker restart cipher-md >> "!BIN_PATH!\cipher-restart.bat"

    :: Add to PATH safely using PowerShell to prevent corruption (max 1024 chars bug in setx)
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$p = [Environment]::GetEnvironmentVariable('Path', 'User'); if ($p -notmatch [regex]::Escape('%APPDATA%\.sh4lu-z\bin')) { $newPath = $p; if ($newPath -and -not $newPath.EndsWith(';')) { $newPath += ';' }; $newPath += '%APPDATA%\.sh4lu-z\bin'; [Environment]::SetEnvironmentVariable('Path', $newPath, 'User') }"
    set "PATH=!PATH!;%APPDATA%\.sh4lu-z\bin"

    :: Desktop Shortcuts
    set DESKTOP_PATH=%USERPROFILE%\Desktop\Cipher MD
    if not exist "!DESKTOP_PATH!" mkdir "!DESKTOP_PATH!"
    
    set BOTRUN_PATH=!DESKTOP_PATH!\cipher-md.bat
    echo @echo off > "!BOTRUN_PATH!"
    echo cipher-md >> "!BOTRUN_PATH!"

    set EDIT_ENV_PATH=!DESKTOP_PATH!\cipher-env.bat
    echo @echo off > "!EDIT_ENV_PATH!"
    echo cipher-env >> "!EDIT_ENV_PATH!"

    set BOTSTOP_PATH=!DESKTOP_PATH!\cipher-stop.bat
    echo @echo off > "!BOTSTOP_PATH!"
    echo cipher-stop >> "!BOTSTOP_PATH!"
    
    set BOTRESTART_PATH=!DESKTOP_PATH!\cipher-restart.bat
    echo @echo off > "!BOTRESTART_PATH!"
    echo cipher-restart >> "!BOTRESTART_PATH!"



    echo Setup complete! Bot is running in Docker.
    pause
    exit /b 0
)

echo Error: Neither Node.js nor Docker is installed. Please install one of them to run the bot.
pause
exit /b 1
