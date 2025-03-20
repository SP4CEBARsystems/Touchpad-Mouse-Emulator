#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;#IfWinActive, Minecraft    ;turn this hotkey off when you aren't playing Minecraft
;#IfWinActive, Roblox       ;turn this hotkey off when you aren't playing Roblox
;#IfWinActive, SolidWorks   ;turn this hotkey off when you aren't using Solidworks
;#If WinActive("ahk_class Progman") || WinActive("ahk_class WorkerW")
;#If WinActive("ahk_exe notepad.exe") || WinActive("ahk_exe wordpad.exe")

;#If WinActive("Roblox") || WinActive("Minecraft") || WinActive("SolidWorks")

/::                           ;turn this hotkey off when you press "/" to chat
Suspend, On
Send /
Pause,On, 1
Return

Esc::                         ;turn this hotkey on when you press "escape" to exit chat
Suspend, Off
Send {Esc}
Pause,Off, 1
Return

AppsKey::
Suspend, Toggle
Pause,Toggle, 1
return

j::LButton
k::MButton
l::RButton

m::LButton

i::
send {WheelDown 1}
return

o::
send {WheelUp 1}
return

; $;::
; ;mouse -> scroll
; return

;to check for ";" without it becoming a comment type this:   $;::RButton