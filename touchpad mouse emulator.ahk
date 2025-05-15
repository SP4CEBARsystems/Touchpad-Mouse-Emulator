#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;type (turn this hotkey off)
~/::                           ; "/" to chat
~LWin::                        ; "left windows" to open a program
~BackSpace::                   ; "backspace" to remove text
    Suspend, On
    Return

;click (turn this hotkey on)
~Esc::                         ; "escape" to exit chat
~Enter::                       ; "enter" to send a chat message or select a program
    Suspend, Off
    Return

RAlt::
    Suspend, Toggle
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
