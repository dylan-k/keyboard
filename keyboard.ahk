; =============================================================================
; Name ..........: Dylan's Keyboard
; Description ...: Mac-style media keys for windows, launcher, and more
; Platform ......: Windows 10
; Language ......: English (en-US)
; Author ........: Dylan Kinnett <dylan@nocategories.net>
; =============================================================================

; tray icon
; =============================================================================

I_Icon = keyboard.ico
IfExist, %I_Icon%
Menu, Tray, Icon, %I_Icon%
;return


;Blank Template written by GroggyOtter
#UseHook
;========================= Start Auto-Execution Section ========================
; Always run as admin
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

; Keeps script permanently running
#Persistent

; Determines how fast a script will run (affects CPU utilization).
; The value -1 means the script will run at it's max speed possible.
SetBatchLines, -1

; Avoids checking empty variables to see if they are environment variables.
; Recommended for performance and compatibility with future AutoHotkey releases.
#NoEnv

; Ensures that there is only a single instance of this script running.
#SingleInstance, Force
Process, Priority, ,High

; Makes a script unconditionally use its own folder as its working directory.
; Ensures a consistent starting directory.
SetWorkingDir %A_ScriptDir%

; sets title matching to search for "containing" instead of "exact"
SetTitleMatchMode, 2

; Recommended for new scripts due to its superior speed and reliability.
SendMode Input

DetectHiddenWindows, On
#WinActivateForce

GroupAdd, saveReload, %A_ScriptName%

return

;======================== Save Reload / Quick Stop ========================
#IfWinActive, ahk_group saveReload

; Use Control+S to save your script and reload it at the same time.
~^s::
	TrayTip, Reloading updated script, %A_ScriptName%
	SetTimer, RemoveTrayTip, 1500
	Sleep, 1750
	Reload
return

; Removes any popped up tray tips.
RemoveTrayTip:
	SetTimer, RemoveTrayTip, Off 
	TrayTip 
return 

; Hard exit that just closes the script
^Esc::
ExitApp

#UseHook 
#IfWinActive
;======================== Main Script ========================

; brightness up and down via F1 and F2
; source: https://github.com/deanhouseholder/Set-Brightness
; DISABLED. It may cause issues with Windows NightLight
; ideally F5 and 6 would control screen color temp.
; possible source: https://github.com/tigerlily-dev/tigerlilys-Screen-Dimmer/
;#Include brightness\SetBrightness.ahk
; #Include gamma.ahk  

;F1 see SetBrightness.ahk above
;F2 see SetBrightness.ahk above
F3:: Send {LWin down}{TAB down}{LWin up}{TAB up}
F4:: LWin
;F5::Monitor.SetGammaRamp(25, 25, 25)
;F6::Monitor.SetGammaRamp(100, 100, 100)
F7::Media_Prev
F8::Media_Play_Pause
F9::Media_Next
F10::Volume_Mute
F11::Volume_Down
F12::Volume_Up

; Use Function key defaults by addingthe alt key

; other modifiers would work here, to avoid that.
; !F1::SendInput, {F1}
; !F2::SendInput, {F2}
~!F3::SendInput, {F3}
~!F4::SendInput, {F4}
~!F5::SendInput, {F5}
~!F6::SendInput, {F6}
~!F7::SendInput, {F7}
~!F8::SendInput, {F8}
~!F9::SendInput, {F9}
~!F10::SendInput, {F10}
~!F11::SendInput, {F11}
~!F12::SendInput, {F12}

; use PrintScreeen key to take a snapshot, like on a mac
; Windows 10 uses WIN+SHIFT+S to open screenshot tool
; I could also set this to happen via Windows itself, using Sophia script.
; PrintScreen::Send #+s
; #Include screenshot.ahk 
; Printscreen::
; gosub, imagename
; CaptureScreen(0,false,imagesavename)
; return

; ^Printscreen::
; gosub, imagename
; CaptureScreen(2,false,imagesavename)
; return
   
; +Printscreen::
; gosub, imagename
; CaptureScreen("0,0,1680,1050",false,imagesavename)
; return

; imagename:
; setformat, float, 04.0 ; a better way to add zero padding
; count+=1.
; imagesavename=C:\Users\Dylan\Desktop\screenshot_%count%.jpg
; return




;for old-school terminals where "copy" shortcut conflicts with "stop"
; didn't choose "End" because i use that when typing.
Pause::^c 

;use control+q to quit an application
;but don't quit explorer.exe
^q::
WinGetTitle,Title,A
If Title !=
WinClose,A
Return

; row above numpad, from left to right
; VK    SC    Type  Key   
; ----------------------------------
; AD    120   a     Volume_Mute
; AE    12E   a     Volume_Down  
; AF    130   a     Volume_Up 
; B7    121   a     Launch_App2     
; https://stackoverflow.com/questions/62918955/can-autohotkey-remap-media-key-combos
; would love to use the launch key as a modifier for the others
; but this doesn't work. a bug in AutoHotKey & nobody cares.
; maybe this help?
; https://autohotkey.com/board/topic/30842-physical-state-of-media-keys-not-detected-by-getkeystate/
Volume_Mute:: Esc
Volume_Down:: Tab
Volume_Up:: BackSpace
; Launch_App2:: Shift

; application launcher shortcuts
; -----------------------------------------------------------------------------
#Include shortcuts.ahk 


;======================== Experimental ========================






;============================== Program Hotkeys ==============================
; Program Hotkeys
; keyboard shortcuts for use with specific programs

; Program 1
; -----------------------------------------------------------------------------
; Evertything between here and the next #IfWinActive will ONLY work in someProgram.exe
; This is called being "context sensitive"
; #IfWinActive, ahk_exe someProgram.exe



; #IfWinActive
;============================== ini Section ==============================
; Do not remove /* or */ from this section. Only modify if you're
; storing values to this file that need to be permanantly saved.
/*
[SavedVariables]
Key=Value
*/
;============================== GroggyOtter ==============================
;============================== End Script ==============================
