@echo off
title BrainGym — Push Update
color 0B
cls

echo.
echo  =========================================
echo   BRAINGYM — Push Update to GitHub
echo  =========================================
echo.

cd /d "C:\projects\braingym"

:: Check for changes
git status --short
echo.

set /p MSG="  Describe your update (e.g. 'Added new game'): "
if "%MSG%"=="" set MSG=Update app

echo.
echo  [1/3] Staging changes...
git add .
echo  [2/3] Committing...
git commit -m "%MSG%"
echo  [3/3] Pushing to GitHub...
git push

echo.
echo  =========================================
echo   DONE! Site will update in ~60 seconds.
echo  =========================================
echo.
pause
