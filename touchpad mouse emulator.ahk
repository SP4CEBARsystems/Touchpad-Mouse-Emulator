#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; -----------------------------
; Global mapping state
; -----------------------------
mappingActive := true

; -----------------------------
; Suspend logic
; -----------------------------

;typing (turn this hotkey off)
~/::                           ; "/" to chat
~LWin::                        ; "left windows" to open a program
~BackSpace::                   ; "backspace" to remove text
    Suspend, On
    mappingActive := false
Return

;not typing (turn this hotkey on)
~Esc::                         ; "escape" to exit chat
~Enter::                       ; "enter" to send a chat message or select a program
    Suspend, Off
    mappingActive := true
Return

RAlt::
    Suspend, Toggle
    mappingActive := !mappingActive
Return

; -----------------------------
; Per-key latch storage
; -----------------------------
keyLatch := {}

; -----------------------------
; Mouse button mappings (latched)
; -----------------------------
*j::
    HandleMouseKey("j", "LButton")
Return

*k::
    HandleMouseKey("k", "MButton")
Return

*l::
    HandleMouseKey("l", "RButton")
Return

*m::
    HandleMouseKey("m", "LButton")
Return

; -----------------------------
; Scroll mappings (latched)
; -----------------------------
*i::
    HandleScrollKey("i", "WheelDown")
Return

*o::
    HandleScrollKey("o", "WheelUp")
Return

; -----------------------------
; Helpers
; -----------------------------
HandleMouseKey(key, mouseBtn) {
    global mappingActive, keyLatch

    if GetKeyState(key, "P") {
        ; Key down → latch state
        keyLatch[key] := mappingActive
        if (mappingActive) {
            Send, {%mouseBtn% Down}
        }
    } else {
        ; Key up → follow latched state
        if (keyLatch.HasKey(key) && keyLatch[key]) {
            Send, {%mouseBtn% Up}
        }
        keyLatch.Delete(key)
    }
}

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
