@echo off
title BrainGym — GitHub Setup
color 0A
cls

echo.
echo  =========================================
echo   BRAINGYM — GitHub Deployment Setup
echo  =========================================
echo.

:: ── STEP 1: Check Git is installed ──
git --version >nul 2>&1
if errorlevel 1 (
    color 0C
    echo  [ERROR] Git is not installed!
    echo.
    echo  Please install Git first:
    echo  https://git-scm.com/download/win
    echo.
    echo  After installing, run this script again.
    pause
    exit /b 1
)
echo  [OK] Git is installed
echo.

:: ── STEP 2: Get GitHub username ──
set /p GH_USER="  Enter your GitHub username: "
if "%GH_USER%"=="" (
    echo  [ERROR] Username cannot be empty.
    pause
    exit /b 1
)

:: ── STEP 3: Get repo name ──
set REPO_NAME=braingym
echo.
echo  Repository name will be: %REPO_NAME%
echo  Your app URL will be: https://%GH_USER%.github.io/%REPO_NAME%
echo.

:: ── STEP 4: Create C:\projects\braingym ──
echo  [1/6] Creating folder C:\projects\%REPO_NAME%...
if not exist "C:\projects" mkdir "C:\projects"
if not exist "C:\projects\%REPO_NAME%" mkdir "C:\projects\%REPO_NAME%"
echo  [OK] Folder created: C:\projects\%REPO_NAME%
echo.

:: ── STEP 5: Copy files ──
echo  [2/6] Copying app files...
set SCRIPT_DIR=%~dp0
copy "%SCRIPT_DIR%index.html" "C:\projects\%REPO_NAME%\index.html" >nul
copy "%SCRIPT_DIR%README.md" "C:\projects\%REPO_NAME%\README.md" >nul
copy "%SCRIPT_DIR%.gitignore" "C:\projects\%REPO_NAME%\.gitignore" >nul
echo  [OK] Files copied to C:\projects\%REPO_NAME%
echo.

:: ── STEP 6: Init Git ──
echo  [3/6] Initialising Git repository...
cd /d "C:\projects\%REPO_NAME%"
git init >nul 2>&1
git add . >nul 2>&1
git commit -m "Initial commit: BrainGym SPA" >nul 2>&1
echo  [OK] Git initialised with first commit
echo.

:: ── STEP 7: Update README with real username ──
echo  [4/6] Updating README with your GitHub URL...
powershell -Command "(Get-Content README.md) -replace 'YOUR-USERNAME', '%GH_USER%' | Set-Content README.md"
git add README.md >nul 2>&1
git commit -m "Update README with live URL" >nul 2>&1
echo  [OK] README updated
echo.

:: ── STEP 8: Set remote and push ──
echo  [5/6] Connecting to GitHub...
git remote add origin https://github.com/%GH_USER%/%REPO_NAME%.git >nul 2>&1
git branch -M main >nul 2>&1
echo.
echo  =========================================
echo   ACTION NEEDED — Do this now:
echo  =========================================
echo.
echo  1. Open: https://github.com/new
echo  2. Repository name: %REPO_NAME%
echo  3. Set to PUBLIC
echo  4. Do NOT tick "Add a README file"
echo  5. Click "Create repository"
echo  6. Come back here and press any key
echo.
echo  Opening GitHub new repo page now...
start https://github.com/new
echo.
pause

:: ── STEP 9: Push ──
echo.
echo  [6/6] Pushing to GitHub...
git push -u origin main
if errorlevel 1 (
    echo.
    echo  [!] Push failed. You may need to authenticate.
    echo  Try running: git push -u origin main
    echo  in C:\projects\%REPO_NAME% after logging in.
) else (
    echo  [OK] Pushed successfully!
)

echo.
echo  =========================================
echo   FINAL STEP — Enable GitHub Pages
echo  =========================================
echo.
echo  1. Go to your repo Settings
echo  2. Click Pages (left sidebar)
echo  3. Source: Deploy from branch
echo  4. Branch: main  /  Folder: / (root)
echo  5. Click Save
echo.
echo  Your live URL (ready in ~60 seconds):
echo  https://%GH_USER%.github.io/%REPO_NAME%
echo.
echo  Opening GitHub Pages settings now...
start https://github.com/%GH_USER%/%REPO_NAME%/settings/pages
echo.

:: ── STEP 10: Copy URL to clipboard ──
echo https://%GH_USER%.github.io/%REPO_NAME% | clip
echo  [OK] URL copied to clipboard!
echo.
echo  =========================================
echo   DONE! Share your app URL:
echo   https://%GH_USER%.github.io/%REPO_NAME%
echo  =========================================
echo.
pause
