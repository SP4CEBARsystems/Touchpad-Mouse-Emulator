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
    HandleMouseKeyDown("j", "LButton")
Return

*j up::
    HandleMouseKeyUp("j", "LButton")
Return

; *k::
;     HandleMouseKey("k", "MButton")
; Return

; *l::
;     HandleMouseKey("l", "RButton")
; Return

; *m::
;     HandleMouseKey("m", "LButton")
; Return

; ; -----------------------------
; ; Scroll mappings (latched)
; ; -----------------------------
; *i::
;     HandleScrollKey("i", "WheelDown")
; Return

; *o::
;     HandleScrollKey("o", "WheelUp")
; Return

; -----------------------------
; Helpers
; -----------------------------
HandleMouseKeyDown(key, mouseBtn) {
    global mappingActive, keyLatch, keyIsDown

    ; Suppress auto-repeat
    if ((keyLatch.HasKey(key) && keyLatch[key]) && (keyIsDown.HasKey(key) && keyIsDown[key]))
        return

    keyIsDown[key] := true
    keyLatch[key] := mappingActive

    if (mappingActive) {
        Send, {%mouseBtn% Down}
    } else {
        Send, {%key% Down}
    }
}

HandleMouseKeyUp(key, mouseBtn) {
    global keyLatch, keyIsDown

    ; Suppress stray Up
    if ((keyLatch.HasKey(key) && keyLatch[key]) && (!keyIsDown.HasKey(key) || !keyIsDown[key]))
        return

    keyIsDown[key] := false

    if (keyLatch.HasKey(key) && keyLatch[key]) {
        Send, {%mouseBtn% Up}
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
