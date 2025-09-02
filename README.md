# Touchpad Mouse Emulator
This allows applications that would require a mouse to use to be operable from a laptop's touchpad, these applications include most games like Minecraft and Fortnite and CAD software like SolidWorks. It is made in [AutoHotKey V1](https://www.autohotkey.com/). 

This is achieved by mapping the `j`, `k`, and `l` keys to the `left`, `middle`, and `right` mouse buttons respectively, allowing the user to press these buttons easily while controlling the touchpad with their thumb. Additionally, the `i` and `o` buttons are mapped to scrolling down and up respectively.

The `j`, `k`, and `l` keys were chosen because these are part of the touch-typing posture. A QWERTY keyboard's j key has a homing bump on it.

The `/` key is used to disable this macro (to be able to type) and the `escape` key to enable it again. Both the `/` and `escape` keys are not captured and will continue to work as expected within your application. These keys were chosen because they are used in some games to access or close the chat.

## Platform
- This project is made in AutoHotKey and therefore runs exclusively on Windows
- For Linux refer to [Auto-Touchpad-Mouse-Emulator](https://github.com/SP4CEBARsystems/Auto-Touchpad-Mouse-Emulator)

## Installation
I have provided an [executable](https://github.com/SP4CEBARsystems/Touchpad-Mouse-Emulator/blob/main/touchpad%20mouse%20emulator.exe) for this macro that you can download and run if you trust me. I have to note that most AHK macros are flagged as trojans by some security vendors on [VirusTotal](https://www.virustotal.com), [here is the VirusTotal report for this executable](https://www.virustotal.com/gui/file/61a640de9c9ea98182e44c6b7d0b42dacffd309f34918fbc3ade055e33ad2f47?nocache=1). If you don't trust me, [review the code](https://github.com/SP4CEBARsystems/Touchpad-Mouse-Emulator/blob/main/touchpad%20mouse%20emulator.ahk), [download AutoHotKey V1](https://www.autohotkey.com/download/ahk-install.exe), and [compile your own executable](https://www.autohotkey.com/docs/v1/Scripts.htm#ahk2exe-run). If you don't trust AutoHotKey check out [this report](https://safeweb.norton.com/report/show?url=autohotkey.com%2Fdownload).

## Stopping The Macro
When an AHK macro is running, you can stop it from its tray icon.

## Controls

### Mouse Emulation
| keys | action |
|---|---|
| `j` or `m` | left mouse button |
| `k` | middle mouse button |
| `l` | right mouse button |
| `i` | scroll down |
| `o` | scroll up |

### Activation
| key | action |
|---|---|
| `/`, `backspace` or `left windows key` | disable this macro to allow typing (like chatting) |
| `escape` or `enter` | enable this maco to allow mouse emulation |
| `right alt` | toggle the activation of this maco |

## Ideas
If it were possible to detect if a finger was resting on the touchpad then that could be used to enable this macro.
