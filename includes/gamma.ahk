; ==============================================================================
; WARNING DO NOT USE
; ==============================================================================

; DISABLED. It may cause issues with Windows NightLight 
; could BREAK display settings in windows.

; ideally F5 and 6 would control screen color temp.
; possible source: https://github.com/tigerlily-dev/tigerlilys-Screen-Dimmer/

; new registry path
;HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Cloud\default$windows.data.bluelightreduction.bluelightreductionstate\windows.data.bluelightreduction.bluelightreductionstate


;Disable
; F6::RegWrite, REG_BINARY, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Cloud\default$windows.data.bluelightreduction.bluelightreductionstate\windows.data.bluelightreduction.bluelightreductionstate, Data, 02000000d3f1d47c4584d40100000000434201001000d00a02c61487dad3e6d70000002088a1ea0100

;Enable
; F5::RegWrite, REG_BINARY, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Cloud\default$windows.data.bluelightreduction.bluelightreductionstate\windows.data.bluelightreduction.bluelightreductionstate, Data, 02000000d3f1d47c4584d40100000000434201001000d00a02c61487dad3e6d788a1ea0100
