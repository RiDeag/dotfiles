#NoTrayIcon

; EVENT_OBJECT_NAMECHANGE = 0x800C
; WINEVENT_OUTOFCONTEXT = 0x0000
hook := DllCall("SetWinEventHook", "uint", 0x800C, "uint", 0x800C
	, "uint", 0, "uint", RegisterCallback("ObjectNameChange")
	, "uint", 0, "uint", 0, "uint", 0)
OnExit, UnHook

#t::
	active := WinExist("A")+0
	WinGetTitle, title
	InputBox, newtitle, Enter new title:,,,600,100,,,,, %title% ; yay commas
	If !ErrorLevel {
		WinSetTitle, %newtitle%
		Win_%active% := newtitle
	}
return

ObjectNameChange(hWinEventHook, event, hwnd, idObject, idChild, thread, time){
	; If the object is a window (OBJID_WINDOW), is not hidden, and is not a child window,
	if (idObject=0) && WinExist("ahk_id " hwnd) && DllCall("GetAncestor","uint",hwnd,"uint",1)=DllCall("GetDesktopWindow")
		If(newtitle := Win_%hwnd%)!=""{
			WinGetTitle, title, ahk_id %hwnd%
			If(title != newtitle)
				WinSetTitle, ahk_id %hwnd%,, %newtitle%
		}
}
UnHook:
	ExitApp, DllCall("UnhookWinEvent", "uint", hook) ; Yes, this works.
Return