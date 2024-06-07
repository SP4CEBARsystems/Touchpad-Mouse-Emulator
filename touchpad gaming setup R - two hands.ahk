#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#IfWinActive, Minecraft    ;turn this hotkey off when you aren't playing Minecraft
;#IfWinActive, Roblox       ;turn this hotkey off when you aren't playing Roblox
;#IfWinActive, SolidWorks   ;turn this hotkey off when you aren't using Solidworks

\::                           ;turn this hotkey off when you press "/" to chat
Suspend, On
Send \
Pause,On, 1
Return

Esc::                         ;turn this hotkey on when you press "escape" to exit chat
Suspend, Off
Send {Esc}
Pause,Off, 1
Return

j::LButton
k::MButton
l::RButton

; $;::
; ;mouse -> scroll
; return

;to check for ";" without it becoming a comment type this:   $;::RButton