#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CoordMode, Mouse, Screen
SetBatchLines -1
SetWinDelay, 0

global lastX := ""
global lastY := ""
global lastMoveTick := 0
global movementActive := false

SetTimer, DetectMovement, 1

;=========================
;  MOUSE MOVEMENT WATCHER
;=========================
DetectMovement:
    MouseGetPos, x, y

    if (lastX = "")
    {
        lastX := x
        lastY := y
        lastMoveTick := A_TickCount
        return
    }

    dx := x - lastX
    dy := y - lastY

    if (dx != 0 or dy != 0)
    {
        lastMoveTick := A_TickCount
        if (!movementActive)
            movementActive := true
    }
    else
    {
        if (movementActive && (A_TickCount - lastMoveTick > 500))
            movementActive := false
    }

    lastX := x
    lastY := y
return

;===========================================
;       EXISTING SCRIPT — UNCHANGED
;===========================================

;typing (turn this hotkey off)
~/::                           ; "/" to chat
~LWin::                        ; "left windows" to open a program
~BackSpace::                   ; "backspace" to remove text
    Suspend, On
    Return

;not typing (turn this hotkey on)
~Esc::                         ; "escape" to exit chat
~Enter::                       ; "enter" to send a chat message or select a program
    Suspend, Off
    Return

RAlt::
    Suspend, Toggle
    Return

;===========================================
;      KEYMAP — ONLY ACTIVE WHILE MOVING
;===========================================
#If (movementActive)

j::LButton
k::MButton
l::RButton

m::LButton

*i::Send % GetActiveModifiers() . "{WheelDown}"
*o::Send % GetActiveModifiers() . "{WheelUp}"

#If  ; end conditional hotkeys

GetActiveModifiers() {
    modifiers := ""
    if GetKeyState("Ctrl", "P")
        modifiers .= "^"
    if GetKeyState("Shift", "P")
        modifiers .= "+"
    if GetKeyState("Alt", "P")
        modifiers .= "!"
    return modifiers
}