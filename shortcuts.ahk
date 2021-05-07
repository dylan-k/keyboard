; ============================================================================
; Name ..........: Dylan's Keyboard Shortcuts
; Description ...: Skipt the start menu. Launch with keys!
; Platform ......: Windows 10
; Author ........: Dylan Kinnett <dylan@nocategories.net>
; ============================================================================

DetectHiddenWindows, On
#WinActivateForce

; Launchers ===================================================================
#`:: 
  Run C:\Windows\System32\cmd.exe /c start /b wt
  WinActivate, ahk_exe cmd.exe 
return

; ; launch a new instance of chrome, move it to monitor 1 and maximize
; #c:: 
; Run, chrome.exe -new,, Min
; WinWait, ahk_exe chrome.exe
; WinActivate, ahk_exe chrome.exe
; WinRestore, A
; SysGet, Mon1, Monitor, 1 ; Gets monitor 1 data and stores it within Mon1
; WinMove, A, , Mon1Left, 0 ; Moves it to the top left corner of Mon1
; WinMaximize, A ; Maximizes it
; return

; Hotkeys =====================================================================

; control+alt+a to make a new todoist task
^!a::
  Run, C:\Users\Dylan\AppData\Local\Programs\todoist\Todoist.exe
  WinWait, ahk_exe Todoist.exe ;Waits until the specified window exists.
  WinActivate, ahk_exe Todoist.exe ;Activate existing window (just in case)
  WinWaitActive, ahk_exe Todoist.exe ;wait for activation...
  Send, q
return
