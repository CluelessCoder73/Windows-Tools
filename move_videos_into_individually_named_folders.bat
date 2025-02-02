@echo off
setlocal enabledelayedexpansion

:: First confirmation dialog
choice /c yn /m "WARNING: This will move all video files in current directory to individual folders. Continue?"
if errorlevel 2 (
    echo Operation canceled
    exit /b
)

:: Second confirmation dialog
choice /c yn /m "Are you ABSOLUTELY sure?"
if errorlevel 2 (
    echo Operation canceled
    exit /b
)

:: Set supported HandBrake video formats (modify as needed)
set "extensions=*.mp4 *.mkv *.avi *.mov *.m4v *.m2ts *.mts *.ts *.wmv *.flv *.webm *.3gp *.ogv *.vob *.mpg *.mpeg *.m2v"

:: Process files
for %%f in (%extensions%) do (
    if not "%%~f"=="%~nx0" (
        if not "%%~af"=="*h*" (
            echo Processing %%f...
            mkdir "%%~nf" 2>nul
            move /Y "%%f" "%%~nf" >nul
            if errorlevel 1 (
                echo Failed to move %%f
            ) else (
                echo Moved %%f to %%~nf\
            )
        )
    )
)

:: Completion message
echo.
if errorlevel 1 (
    echo Operation completed with errors
) else (
    echo Operation completed successfully
)
pause
