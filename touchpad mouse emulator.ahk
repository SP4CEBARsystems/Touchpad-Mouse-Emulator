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

    isKeyMapped := keyLatch.HasKey(key) && keyLatch[key]

    ; Suppress auto-repeat
    if (isRapidSupressed && isKeyMapped && keyIsDown.HasKey(key) && keyIsDown[key])
        return

    keyIsDown[key] := true
    keyLatch[key] := mappingActive

    if (mappingActive) {
        if (mouseBtn != "") {
            suffix := isScroll ? "" : "Down"
            Send, {%mouseBtn% %suffix%}
        }
    } else {
        Send, {%key% Down}
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
        if (mouseBtn != "") {
            suffix := isScroll ? "" : "Up"
            Send, {%mouseBtn% %suffix%}
        }
    } else {
        Send, {%key% Up}
    }
    keyLatch.Delete(key)
}

; TODO oop method get is key active

HandleScrollKey(key, wheelDir) {
    global mappingActive, keyLatch

    if GetKeyState(key, "P") {
        keyLatch[key] := mappingActive
        if (mappingActive) {
            Send, % GetActiveModifiers() . "{" . wheelDir . "}"
        }
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
