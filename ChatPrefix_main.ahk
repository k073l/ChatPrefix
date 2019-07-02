#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Singleinstance force
#Persistent
DetectHiddenWindows, On

global Edit
global Aktywny

Menu, Tray, NoStandard

Gui Font, s18, Impact
Gui Add, Text, x8 y8 w107 h23 +0x200, ChatPrefix
Gui Font
Gui Add, Edit, x8 y40 w107 h21 vEdit, % "Zmień mnie!"
Gui Add, Text, x8 y64 w107 h24 +0x200, Wpisz prefix chatu
Gui Add, Text, x8 y88 w107 h23 +0x200, np. &&3
Gui Add, Button, x8 y120 w42 h23 gOdpal, % "Odpal"
Gui Add, Button, x64 y120 w42 h23 gStop, % "Stop"
Gui Add, Button, x8 y150 w98 h23 gLast, % "Ost. konfig"
Gui Show, w120 h182, ChatPrefix v. 3.1

Return




Quit:
{
CloseScript("ChatPrefix_core.exe")
ExitApp
}

GuiClose:
{
Zminimalizuj()
}
Success:=CloseScript("Case insensitive script name")
return

CloseScript(Name)
	{
	DetectHiddenWindows On
	SetTitleMatchMode RegEx
	IfWinExist, i)%Name%.* ahk_class AutoHotkey
		{
		WinClose
		WinWaitClose, i)%Name%.* ahk_class AutoHotkey, , 2
		If ErrorLevel
			return "Unable to close " . Name
		else
			return "Closed " . Name
		}
	else
		return Name . " not found"
	}
;funkcja: usuwanie procesów ahk z tła
;Creditsy do Rijul Ahuja z forum autohotkey

Stop:
{
CloseScript("ChatPrefix_core.exe")
GuiControl, Hide, Aktywny
GuiControl, Show, Edit
}

Odpal:
{
Gui, Submit, NoHide
global Edit
GuiControl, Hide, Edit
ShowActive()
FileDelete, code.txt
FileAppend, %Edit%, code.txt
Run, ChatPrefix_core.exe
Zminimalizuj()
Return
}

Last:
{
FileRead, Edit, code.txt
GuiControl, Hide, Edit
ShowActive()
Run, ChatPrefix_core.exe
Zminimalizuj()
Return
}

ShowActive()
{
Gui Add, Text, x8 y40 w107 h21 +0x80 vAktywny, Aktywny: %Edit%
GuiControlGet, Aktywny
global Aktywny
}

Zminimalizuj()
{
Gui, Submit
Menu, Tray, NoStandard,
Menu, Tray, Add, Zamknij, Quit
MsgBox  Program będzie działał jako zminimalizowany w zasobniku
}
