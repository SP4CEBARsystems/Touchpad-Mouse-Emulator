#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; -----------------------------
; Global mapping state
; -----------------------------
mappingActive := true

; -----------------------------
; Per-key latch storage
; -----------------------------
keyLatch := {}
keyIsDown := {}

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
    holdTime := 1000

    if (dx != 0 or dy != 0)
    {
        lastMoveTick := A_TickCount
        if (!movementActive)
            movementActive := true
    }
    else
    {
        if (movementActive && (A_TickCount - lastMoveTick > holdTime))
            movementActive := false
    }

    lastX := x
    lastY := y
return

;===========================================
;       EXISTING SCRIPT — UNCHANGED
;===========================================

; -----------------------------
; Switching logic
; -----------------------------

;typing (turn this hotkey off)
~/::                           ; "/" to chat
~LWin::                        ; "left windows" to open a program
~BackSpace::                   ; "backspace" to remove text
    mappingActive := false
Return

;not typing (turn this hotkey on)
~Esc::                         ; "escape" to exit chat
~Enter::                       ; "enter" to send a chat message or select a program
    mappingActive := true
Return

RAlt::
    mappingActive := !mappingActive
Return

; -----------------------------
; Mouse button mappings (latched)
; -----------------------------
*j::
    HandleKeyDown("j", "LButton")
Return
*j up::
    HandleKeyUp("j", "LButton")
Return

*k::
    HandleKeyDown("k", "MButton")
Return
*k up::
    HandleKeyUp("k", "MButton")
Return

*l::
    HandleKeyDown("l", "RButton")
Return
*l up::
    HandleKeyUp("l", "RButton")
Return

*m::
    HandleKeyDown("m", "LButton")
Return
*m up::
    HandleKeyUp("m", "LButton")
Return

; -----------------------------
; Scroll mappings (latched)
; -----------------------------
*i::
    HandleKeyDown("i", "WheelDown", true, false)
Return
*i up::
    HandleKeyUp("i", "")
Return

*o::
    HandleKeyDown("o", "WheelUp", true, false)
Return
*o up::
    HandleKeyUp("o", "")
Return

; -----------------------------
; Helpers
; -----------------------------
HandleKeyDown(key, mouseBtn, isScroll:=false, isRapidSupressed:=true) {
    global mappingActive, movementActive, keyLatch, keyIsDown
    isActive := mappingActive && movementActive

    isKeyMapped := keyLatch.HasKey(key) && keyLatch[key]

    ; Suppress auto-repeat
    if (isRapidSupressed && isKeyMapped && keyIsDown.HasKey(key) && keyIsDown[key])
        return

    keyIsDown[key] := true
    keyLatch[key] := isActive

    if (isActive) {
        sendKey(mouseBtn, false, isScroll)
    } else {
        sendKey(key, false)
    }
}

HandleKeyUp(key, mouseBtn, isScroll:=false, isRapidSupressed:=true) {
    global keyLatch, keyIsDown

    isKeyMapped := keyLatch.HasKey(key) && keyLatch[key]

    ; Suppress stray Up
    if (isRapidSupressed && isKeyMapped && (!keyIsDown.HasKey(key) || !keyIsDown[key]))
        return

    keyIsDown[key] := false

    if (isKeyMapped) {
        sendKey(mouseBtn, true, isScroll)
    } else {
        sendKey(key, true)
    }
    keyLatch.Delete(key)
}

sendKey(action, isKeyUp:=false, isScroll:=false) {
    if (action = "") {
        return
    }
    suffix := getKeySuffix(isKeyUp, isScroll)
    modifiers := GetActiveModifiers()
    Send, %modifiers%{%action%%suffix%}
}

getKeySuffix(isKeyUp:=false, isScroll:=false) {
    if (isScroll) {
        return ""
    } else if (isKeyUp) {
        return " Up"
    } else {
        return " Down"
    }
}

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
