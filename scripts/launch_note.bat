::-----------------------------------------------------------------------------
:Daily Notes 
:: Make a file with current date (yyyy-mm-daylog.txt) as filename
:: useful for "new note" or "new journal" task
::-----------------------------------------------------------------------------
@echo off

:: get the date
set NOWYEAR=%date:~10,4%
set NOWMONTH=%date:~4,2%

:: Include format yyyy-mm in filename
set FILEROOT=%USERPROFILE%\Documents\Notes\content\work
set FILEPATH=%USERPROFILE%\Documents\Notes\content\work\log
set FILENAME=%NOWYEAR%-%NOWMONTH%_DAYLOG.md

echo "filename is %fileNAME%"
cd /d %FILEROOT% 

if exist %FILEPATH%\%FILENAME% (
  echo "file exists"
) else (
  echo "no file exists. building file..."
  echo "---" > %FILEPATH%\%FILENAME%
  echo "title: daylog" >> %FILEPATH%\%FILENAME%
  echo "---" >> %FILEPATH%\%FILENAME%
  echo "" >> %FILEPATH%\%FILENAME%
  echo "" >> %FILEPATH%\%FILENAME%
  echo "--------------------------------------------------------------------------------" >> %FILEPATH%\%FILENAME%
)


:: You could use VScode...
:: START "" "%localappdata%\Programs\Microsoft VS Code\Code.exe" --goto "H:\Notes\notes.code-workspace" %FILEPATH%%FILENAME%:6

:: ...but I use Obsidian, at least for now.
START "" obsidian://open?vault=Notes

::move nul 2>&0
EXIT
