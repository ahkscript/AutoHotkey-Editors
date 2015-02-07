/*
AutoHotkey-Editors
https://github.com/ahkscript/AutoHotkey-Editors/

Installer for AutoHotkey Syntax Highlighting - Version 1.0
Requires AHK v1.1+ because of FileEncoding (has to be UTF-16)

If you must: for basic users comment line 99: FileEncoding, UTF-16 ; this line requires ahk_l
and Run this script, be sure to see the Imporant remark below or
otherwise Greenpad will probably crash while opening *.ahk files.

Tested with GreenPad version 1.08 U

GreenPad can be found here:
http://www.kmonos.net/lib/gp.en.html

AutoHotkey forum thread:
http://www.autohotkey.com/forum/topic68644.html

Instructions:

* Copy this script to your GreenPad directory, if you don't you
  will have to select the directory where you have installed 
  GreenPad when the script is started.

* It will modify GreenPad.ini and install ahk.kwd in your TYPE directory
  or you can update the keyword file.

Imporant:

* If GreenPad crashes when you open a AutoHotkey file, you will need to
  open type\ahk.kwd and choose "Save As":
  - Character Encoding: UFT-16LE
  - LineEnding: LF
  Now it should work.

TODO:
- Lines 1 - 4 for new file!

*/

SetWorkingDir, %A_ScriptDir%
GreenPadDir:=A_ScriptDir
Update=0

MsgBox, , Exit GreenPad, Exit GreenPad before installing AutoHotkey Syntax Highlighting.

IfNotExist, %A_ScriptDir%\GreenPad.exe
	{
	 FileSelectFolder, GreenPadDir, , , Select the directory where GreenPad is installed
	 If (ErrorLevel = 1)
	 	{
	 	 MsgBox, 16, Canceled, Installation canceled.
	 	 ExitApp
	 	}
	}

Loop
	{
	 IniRead, Key, %GreenPadDir%\GreenPad.ini, DocType, %A_Index%
	 If (Key = "AHK")
	 	{
	 	 IniRead, File, GreenPad.ini, AHK, Keyword, ahk.kwd
	 	 MsgBox, 20, Warning, AutoHotkey Syntax Highlighting already installed.`nDo you wish to update the AutoHotkey Syntax File: %file%
	 	 IfMsgBox, No
	 	 	ExitApp
     Update=1 ; we only have to update the keyword file
     Break
	 	}
	 If (Key = "") or (Key = "ERROR")
	 	{
	 	 Key:=A_Index
	 	 Break
	 	}	
	}

If (Update = 0)
	{
	 File=ahk.kwd
	 IniWrite, AHK        , %GreenPadDir%\GreenPad.ini, DocType, %Key%
	 Key++
	 IniWrite, %A_Space%  , %GreenPadDir%\GreenPad.ini, DocType, %Key%
	 iniwrite, .*\.ahk$   , %GreenPadDir%\GreenPad.ini, AHK, Pattern
	 IniWrite, ahk.kwd    , %GreenPadDir%\GreenPad.ini, AHK, Keyword
	 IniWrite, program.lay, %GreenPadDir%\GreenPad.ini, AHK, Layout 
  }

TrayTip, Downloading, AutoHotkey syntax files..., 5

GetAHKSyntaxFiles()

FileList=Commands,Directives,Functions,Keywords,Variables,Keys
Loop, parse, FileList, CSV
	{
	 FileRead, Read, %GreenPadDir%\%A_LoopField%.txt
	 SyntaxFile .= read "`n"
	 FileDelete, %GreenPadDir%\%A_LoopField%.txt
	 Read=
	}
StringReplace, SyntaxFile, SyntaxFile, #, ,All ; Greenpad can't use these
StringReplace, SyntaxFile, SyntaxFile, `r`n,`r,All
Sort, SyntaxFile, D`r
SyntaxFile:="0111`n/*`n*/`n;`n" SyntaxFile 

FileDelete, %GreenPadDir%\type\%file%
FileEncoding, UTF-16 ; this line requires ahk_l
FileAppend, %SyntaxFile%, %GreenPadDir%\type\%file%

MsgBox Done!

/*

Part of the AutoHotkey Editors project:
https://github.com/ahkscript/AutoHotkey-Editors/

This function downloads several text files from GH and it
removes empty lines and comments so that there is one keyword
per line.

Each "type" has its own file:
Commands, Directives, Functions, Keywords, Variables, Keys

*/
GetAHKSyntaxFiles() {
   FileDelete, tmpfile$$$.htm
   FileList:="Commands,Directives,Functions,Keywords,Variables,Keys"
   Loop, parse, FileList, CSV
     {
      URLDownloadToFile, https://raw.github.com/ahkscript/AutoHotkey-Editors/master/%A_LoopField%.txt, tmpfile$$$.txt
      FileRead, File, tmpfile$$$.txt
      File:=RegExReplace(RegExReplace(File, "`nm)^;.+\R" ), "`nm)^\n" ) ; remove empty lines and comments
      FileDelete, %A_LoopField%.txt
      FileAppend, %File%, %A_LoopField%.txt
      FileDelete, tmpfile$$$.txt
      File:=""
     }
  }