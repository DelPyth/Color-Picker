#NoEnv
#SingleInstance Force

Gui, -MinimizeBox
Gui, Add, Progress, x0 y-5 w75 h75 +C0x969696 vProg, 100
Gui, Add, Text, x80 y5 w50 h15, Separator
Gui, Add, Text, x80 y30 w50 h15, RGBA
Gui, Add, Text, x80 y55 w50 h15, HEX
Gui, Add, Edit, x135 y25 w110 h20 vOut gSet, 150, 150, 150, 255
Gui, Add, Edit, x135 y50 w110 h20 vHex gSet, 0xFF969696
Gui, Add, Edit, x135 y0 w110 h20 Limit1 vSep gSet, % ", "
Gui, Add, Edit, x5 y300 w45 h20 +Number Center ReadOnly vR gSet, 150
Gui, Add, Edit, x70 y300 w45 h20 +Number Center ReadOnly vG gSet, 150
Gui, Add, Edit, x130 y300 w45 h20 +Number Center ReadOnly vB gSet, 150
Gui, Add, Edit, x190 y300 w45 h20 +Number Center ReadOnly vA gSet, 255
Gui, Add, Slider, x5 y100 w50 h200 +Vertical +0x20 +Tooltip +0x200 +Vertical +Center +Range0-255 -Tabstop AltSubmit vRS gSet, 150
Gui, Add, Slider, x70 y100 w50 h200 +Vertical +0x20 +Tooltip +0x200 +Vertical +Center +Range0-255 -Tabstop AltSubmit vGS gSet, 150
Gui, Add, Slider, x130 y100 w50 h200 +Vertical +0x20 +Tooltip +0x200 +Vertical +Center +Range0-255 -Tabstop AltSubmit vBS gSet, 150
Gui, Add, Slider, x190 y100 w50 h200 +Vertical +0x20 +Tooltip +0x200 +Vertical +Center +Range0-255 -Tabstop AltSubmit vAS gSet, 255
Gui, Add, Button, x5 y330 w75 h23, Copy
Gui, Add, Button, x165 y330 w75 h23, Close
Gui, Font, s18
Gui, Add, Text, x5 y325 w240 h10 0x10
Gui, Add, Text, x10 y75 w30 h25 Center, R
Gui, Add, Text, x75 y75 w30 h25 Center, G
Gui, Add, Text, x135 y75 w30 h25 Center, B
Gui, Add, Text, x195 y75 w30 h25 Center, A
Gui, Show, w245 h355, % "Color Picker"
Return

GuiEscape:
GuiClose:
ExitApp

Set:
	Get("All")
	Sep := Sep ? Sep : " "
	Set("R", RS)
	Set("G", GS)
	Set("B", BS)
	Set("A", AS)
	Set("RS", R, "+Range0-255")
	Set("GS", G, "+Range0-255")
	Set("BS", B, "+Range0-255")
	Set("AS", A, "+Range0-255")
	Set("Hex", RGB(R, G, B, A))
	Set("Out", R Sep G Sep B Sep A)
	Set("Prog",, "+C" RGB(R, G, B))
Return

ButtonCopy:
Get("All")
Clipboard := Hex "`n" Out
MsgBox, 0x40
	, % "Copied Down"
	, % "The following was saved to the clipboard for later use:`n"
	. Hex "`n"
	. Out
	, 5
Return

ButtonClose:
ExitApp
Return

RGB(R, G, B, A := 00) {
	SetFormat, Integer, Hex
	Return, (A << 24) | (R << 16) | (G << 8) | B
}

Get(Control, Option := "") {
	If (Control = "All")
		Gui, Submit, NoHide
	GuiControlGet, Out, %Control%, %Option%
	Return Out
}

Set(Control, Data := "", AddOpt := "") {
	GuiControl, %AddOpt%, %Control%, % Data
}

Combine(Sep := "", Items*) {
	For Index, Var In Items
		Out .= Var Sep
	Return Out
}
