; ============================================================================
; Name ..........: Dylan's Keyboard Launchers
; Description ...: Skip the start menu. Launch with keys!
; Platform ......: Windows 10
; Author ........: Dylan Kinnett <dylan@nocategories.net>
; ============================================================================




DetectHiddenWindows, On
#WinActivateForce




; ==============================================================================
; LAUNCHERS
; ==============================================================================


; Terminal 
; ------------------------------------------------------------------------------

; Launch Windows Terminal with windows+backtick keys
#`:: 
  Run C:\Windows\System32\cmd.exe /c start /b wt
  WinActivate, ahk_exe cmd.exe 
return


; Browser 
; ------------------------------------------------------------------------------

; launch a new instance of chrome with windows+C
; then move chrome to monitor 1 and maximize
; #c:: 
; Run, chrome.exe -new,, Min
; WinWait, ahk_exe chrome.exe
; WinActivate, ahk_exe chrome.exe
; WinRestore, A
; SysGet, Mon1, Monitor, 1 ; Gets monitor 1 data and stores it within Mon1
; WinMove, A, , Mon1Left, 0 ; Moves it to the top left corner of Mon1
; WinMaximize, A ; Maximizes it
; return


; To Do 
; ------------------------------------------------------------------------------

; Launch Todoist with control+alt+a and make a new todoist task
; New version of todoist can FINALLY do this by itself.
; ^!a::
;   Run, C:\Users\%A_UserName%\AppData\Local\Todoist\WindowsDesktopApp\Todoist.exe
;   WinWait, ahk_exe Todoist.exe ;Waits until the specified window exists.
;   WinActivate, ahk_exe Todoist.exe ;Activate existing window (just in case)
;   WinWaitActive, ahk_exe Todoist.exe ;wait for activation...
;   Send, q
; return


; Outlook
; ------------------------------------------------------------------------------
; Launch Outlook with windows+o and with it launch google sync companion app
#o::
Run scripts\launch_outlook.bat,,Hide
return

; E-mail: Start writing a new e-mail with windows+PgUp
#PgUp::
Run "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.exe" /c ipm.note

; Notes
; ------------------------------------------------------------------------------

; open the daylog for quick notes
#n::
Run scripts\launch_note.bat,,hide
