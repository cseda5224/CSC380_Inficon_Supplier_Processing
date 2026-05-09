@echo off
setlocal EnableDelayedExpansion
title Form Filler — Setup and Launch

echo.
echo  =========================================
echo   INFICON Form Filler
echo  =========================================
echo.

python --version >nul 2>&1
if errorlevel 1 (
    echo  [ERROR] Python is not installed or not in PATH.
    echo.
    echo  Please install Python 3.10 or newer from:
    echo    https://www.python.org/downloads/
    echo.
    echo.
    pause
    exit /b 1
)

for /f "tokens=2 delims= " %%v in ('python --version 2^>^&1') do set PY_VER=%%v
echo  [OK] Python %PY_VER% found.
echo.

set "VC_REG=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64"
reg query %VC_REG% /v Version >nul 2>&1

if %errorlevel% equ 0 (
    echo  [OK] Microsoft Visual C++ Redistributable installation found
    echo.
) else (
   echo  [ERROR] Microsoft Visual C++ Redistributable is not installed or not in PATH
   echo.
   echo  Please install the latest release from:
   echo     https://aka.ms/vc14/vc_redist.x64.exe
   echo.
   echo.
   pause
   exit /b 1
)

echo  Installing required libraries (this may take a few minutes on first run)...
echo  Please wait — do not close this window.
echo.

python -m pip install --upgrade pip

python -m pip install ^
    sentence-transformers ^
    pandas ^
    numpy ^
    pymupdf ^
    pypdf ^
    python-docx ^
    scikit-learn ^
    torch ^
    Pillow

if errorlevel 1 (
    echo.
    echo  [ERROR] Some packages failed to install.
    echo  Check your internet connection and try again.
    echo.
    pause
    exit /b 1
)

echo.
echo  [OK] All libraries ready.
echo.

echo  Launching Form Filler...
echo.
cd /d "%~dp0"
python app.py

if errorlevel 1 (
    echo.
    echo  [ERROR] The application exited with an error.
    echo  Press any key to close.
    pause
)

endlocal