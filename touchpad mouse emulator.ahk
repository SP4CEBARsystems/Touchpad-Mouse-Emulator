#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

~/::                           ;turn this hotkey off when you press "/" to chat
Suspend, On
Return

~LWin::                           ;turn this hotkey off when you press "/" to chat
Suspend, On
Return

~Esc::                         ;turn this hotkey on when you press "escape" to exit chat
Suspend, Off
Return

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
