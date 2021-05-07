; Set Brightness
; by GitHub user deanhouseholder
; https://github.com/deanhouseholder/Set-Brightness
#Persistent
#SingleInstance, Force
#NoEnv
IfEqual, A_IsCompiled, , Menu, Tray, Icon, %A_ScriptDir%\SetBrightness.ico
Bright := 100

ShowBanner(Bright)
{
	SysGet, MonPrimary, MonitorPrimary
	SysGet, Mon, Monitor, %MonPrimary%
	x = %MonLeft%
	y = % (MonBottom / 2) - 100
	w = %MonRight%
	xtext = % (MonRight / 2) - 450
	Gui, 10:Destroy
	Gui, 10:+AlwaysOnTop -Caption +Owner +LastFound +E0x20
	Gui, 10:Margin, 0, 0
	Gui, 10:Color, Black
	Gui, 10:Font, cWhite s50 bold, Arial
	Gui, 10:Add, Text, x%xtext% y60, Setting Brightness at %Bright%`%
	WinSet, Transparent, 200
	Gui, 10:Show, NoActivate x%x% y%y% h200 w%w%
	SetTimer, HideBanner, -1500
}

HideBanner()
{
	Gui, 10:Destroy
}

ChangeBrightness(Bright)
{
	if (Bright == 0) {
		Transparency := 200
	} else if (Bright == 10) {
		Transparency := 180
	} else if (Bright == 20) {
		Transparency := 160
	} else if (Bright == 30) {
		Transparency := 140
	} else if (Bright == 40) {
		Transparency := 120
	} else if (Bright == 50) {
		Transparency := 100
	} else if (Bright == 60) {
		Transparency := 80
	} else if (Bright == 70) {
		Transparency := 60
	} else if (Bright == 80) {
		Transparency := 40
	} else if (Bright == 90) {
		Transparency := 20
	} else if (Bright == 100) {
		Transparency := 0
	}
	SysGet, MonCount, MonitorCount
	Loop, %MonCount%
	{
		SysGet, Mon, Monitor, %A_Index%
		w := Abs(MonRight - MonLeft)
		b := Abs(MonBottom - MonTop)
		;MsgBox, Left: %MonLeft% -- Top: %MonTop% -- Right: %MonRight% -- Bottom %MonBottom% w: %w% -- b: %b%
		Gui, %A_Index%:+AlwaysOnTop -Caption +Owner +LastFound +E0x20
		Gui, %A_Index%:Margin, 0, 0
		Gui, %A_Index%:Color, Black
		WinSet, Transparent, %Transparency%
		Gui, %A_Index%:Show, NoActivate x%MonLeft% y%MonTop% h%b% w%w%
	}
}


F1::
	Bright := Bright - 10
	If (Bright < 0) {
		Bright = 0
	}
	ShowBanner(Bright)
	ChangeBrightness(Bright)
Return

F2::
	Bright := Bright + 10
	If (Bright > 100) {
		Bright = 100
	}
	ShowBanner(Bright)
	ChangeBrightness(Bright)
Return


; Use F1, F2, etc. keys as standard function keys via Alt key
; of course this kills the default alt+f4 but i don't use that
; other modifiers would work here too.
!F1::SendInput, {F1}
!F2::SendInput, {F2}
; !F3::SendInput, {F3}
; !F4::SendInput, {F4}
; !F5::SendInput, {F5}
; !F6::SendInput, {F6}
; !F7::SendInput, {F7}
; !F8::SendInput, {F8}
; !F9::SendInput, {F9}
; !F10::SendInput, {F10}
; !F11::SendInput, {F11}
; !F12::SendInput, {F12}
