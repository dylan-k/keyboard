::-----------------------------------------------------------------------------
:Launch Outlook and Calendar Sync
:: author: @dylan-k
:: See Also: https://github.com/phw198/OutlookGoogleCalendarSync
::-----------------------------------------------------------------------------

@ECHO OFF

:: if closed, open Outlook
wmic process where "name='OUTLOOK.EXE'" get ProcessID | find /i "ProcessId" > nul || (START /max "Microsoft Outlook" /D "C:\Program Files\Microsoft Office\root\Office16\" OUTLOOK.EXE /recycle)

:: if closed, open Calendar Sync
wmic process where "name='OutlookGoogleCalendarSync.exe'" get ProcessID | find /i "ProcessId" > nul || (START "Outlook Google Calendar Sync"  /D "%USERPROFILE%\AppData\Local\OutlookGoogleCalendarSync\" OutlookGoogleCalendarSync.exe)

EXIT 
