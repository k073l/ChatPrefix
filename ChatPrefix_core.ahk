#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Singleinstance force
#Persistent
#NoTrayIcon

;Tylko jeśli mc jest odpalone
#IfWinActive Minecraft 1. ahk_exe javaw.exe

;Zmienne, blokady nie ruszać
blokada=0
FileRead, kod, code.txt

Loop{
;Blokuje, jeśli wykryje / do komend
If (GetKeyState("/", "P")){
blokada = 1
}
;Odblokuj, kiedy enter wciśnięty
If (GetKeyState("Enter", "P")){
blokada = 0
}
If (GetKeyState("Esc", "P")){
blokada = 0
}
}

;kiedy wciśnięte t to
t::
;jeśli blokada aktywna nie rób nic
If (blokada = 1){
Send t
}
If (blokada = 0){
Send t ;jeśli nieaktywna wpisz kod i zablokuj
Sleep 40
Send %kod%
blokada = 1
}

Return ;powróć do sprawdzania