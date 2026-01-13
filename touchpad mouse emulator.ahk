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
    global mappingActive, keyLatch, keyIsDown
    isActive := mappingActive
    isKeyDown := keyIsDown.HasKey(key) && keyIsDown[key]
    isKeyMapped := keyLatch.HasKey(key) && keyLatch[key]

    ; Suppress auto-repeat
    if (isRapidSupressed && isKeyMapped && isKeyDown)
        return

    if (!isKeyDown) {
        keyLatch[key] := isActive
        isKeyMapped := isActive
    }
    keyIsDown[key] := true

    if (isKeyMapped) {
        sendKey(mouseBtn, false, isScroll)
    } else {
        sendKey(key, false)
    }
}

HandleKeyUp(key, mouseBtn, isScroll:=false, isRapidSupressed:=true) {
    global keyLatch, keyIsDown

    isKeyMapped := keyLatch.HasKey(key) && keyLatch[key]
    isKeyDown := keyIsDown.HasKey(key) && keyIsDown[key]

    ; Suppress stray Up
    if (isRapidSupressed && isKeyMapped && !isKeyDown)
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
