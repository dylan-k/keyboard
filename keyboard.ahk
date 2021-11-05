; ==============================================================================
; Name ..........: Dylan's Keyboard
; Description ...: Mac-style media keys for windows, launcher, and more
; Platform ......: Windows 10
; Language ......: English (en-US)
; Author ........: Dylan Kinnett <dylan@nocategories.net>
; ==============================================================================




; ==============================================================================
; TRAY ICON 
; ==============================================================================

I_Icon = keyboard.ico
IfExist, %I_Icon%
Menu, Tray, Icon, %I_Icon%
;return




; ==============================================================================
; Configuration
; ==============================================================================

;Blank Template written by GroggyOtter
#UseHook

; Always run as admin
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

; Keep permanently running
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
; Ensures a consistent starting directory. Helps with includes.
SetWorkingDir %A_ScriptDir%

; Lookup titles using "containing" instead of "exact"
SetTitleMatchMode, 2

; Recommended for new scripts due to its superior speed and reliability.
SendMode Input

DetectHiddenWindows, On
#WinActivateForce

GroupAdd, saveReload, %A_ScriptName%

return







; ==============================================================================
; FUNCTIONS
; ==============================================================================


; Save Reload / Quick Stop
; ------------------------------------------------------------------------------

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


; Always on Top 
; ------------------------------------------------------------------------------
; stick” any window to  foreground of desktop with a simple keyboard shortcut.
; source: https://www.labnol.org/software/tutorials/keep-window-always-on-top/5213/
; to use it, while this script is running, click a window, then do control+space
; control+space again will un-stick the window.
 ^SPACE::  Winset, Alwaysontop, , A



; ==============================================================================
; MAIN SCRIPT
; ==============================================================================


; Function Keys
; ------------------------------------------------------------------------------

; brightness up and down via F1 and F2
;#Include includes\brightness\SetBrightness.ahk
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

; Use Function key defaults by adding the alt key
; note that this breaks windows' alt+F4 to close apps
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

; customize row above numpad, from left to right
; keycodes vary among different keyboars, if they have these keys at all
; VK    SC    Type  Key   
; ----------------------------------
; AD    120   a     Volume_Mute
; AE    12E   a     Volume_Down  
; AF    130   a     Volume_Up 
; B7    121   a     Launch_App2     
; https://stackoverflow.com/questions/62918955/can-autohotkey-remap-media-key-combos
; would love to use the launch key as a modifier for the others
; but this doesn't work. a bug in AutoHotKey & nobody cares.
; maybe this helps?
; https://autohotkey.com/board/topic/30842-physical-state-of-media-keys-not-detected-by-getkeystate/

; from left to right...
Volume_Mute:: Esc
Volume_Down:: Tab
Volume_Up:: BackSpace
; Launch_App2:: Shift


; Screenshots
; ------------------------------------------------------------------------------

; Goal is for Print Screen key to take a screenshot, save it to desktop
; A modifier key should add option to grab a selection for the screenshot
; Screenshots should happen with no other input required. 
; Windows doesn't make this as simple as it shold be
; Alternatives include GreenShot and Sophic script

; Use Windows 10's WIN+SHIFT+S to open screenshot tool
; PrintScreen::Send #+s
; #Include includes\screenshot.ahk 
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
; imagesavename=C:\Users\%A_UserName%\Desktop\screenshot_%count%.jpg
; return


; Terminal Applications
; ------------------------------------------------------------------------------

; Windows Terminal is pretty smart about letting you use control+C for "copy"
; Sometimes, however, "copy" shortcut conflicts with "stop"
; didn't choose "End" for "stop" because i use that for "go to end of line".
; Use pause/break key for "stop" command, for terminals
Pause::^c 


; Global Shortcuts
; ------------------------------------------------------------------------------

;use control+q to quit any application
;but don't quit explorer.exe
^q::
WinGetTitle,Title,A
If Title !=
WinClose,A
Return


; App Launch Shortcuts
; ------------------------------------------------------------------------------
#Include includes\launchers.ahk 




; =============================================================================
; Experimental 
; =============================================================================



;============================== Program Hotkeys ==============================
; Program Hotkeys
; keyboard shortcuts for use within specific programs

; Program 1
; -----------------------------------------------------------------------------
; Lines between the #IfWinActive lines ONLY work in someProgram.exe
; i.e. they are "context sensitive"

; #IfWinActive, ahk_exe someProgram.exe
; whatever shortcut(s) go here...
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
