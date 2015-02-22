/*
Install AutoHotkey syntax highlighting and clip library files in EditPlus 2
Mike Griffin
Source: AHK Basic installer (extras\editors\editplus)

-------

Mod for AHK v1.1+
Download syntax files from GH and create 
- AutoHotkey.stx
before continuing installation
(- AutoHotkey.ctl discarded atm)

*/

SetBatchLines,-1 ;fastest!
title = Install EditPlus Syntax & Cliptext Files for AutoHotkey

RegRead,EditPlusDir,HKEY_CURRENT_USER,Software\ES-Computing\EditPlus 2\Install,Path
StringTrimRight,EditPlusDir,EditPlusDir,1
; Don't bother since %ProgramFiles% doesn't exist on Win95/98 and EditPlus should always
; have registry entries if it was installed properly:
;IfEqual,EditPlusDir,,SetEnv,EditPlusDir,%ProgramFiles%\EditPlus 2 ; Try a best-guess location.
IfNotExist,%EditPlusDir%
{
	MsgBox,16,%title%,EditPlus directory could not be found - It may not be installed
	Exit
}

; Prompt the user to run the script
MsgBox,36,%title%,Do you want to install EditPlus syntax and cliptext files for AutoHotkey scripts, and configure EditPlus to use them?
IfMsgBox,No,Exit
IfMsgBox,Cancel,Exit

; -------------[updated section]-------------------

GetAHKSyntaxFiles()
; we now have Commands.txt,Directives.txt,Functions.txt,Keywords.txt,Variables.txt,Keys.txt
; now we can start making AutoHotkey.stx (based on old example)

stx=
(
#TITLE=AutoHotkey
; AutoHotkey syntax file
#DELIMITER=,``=:\{}
#QUOTATION1="
#QUOTATION2=`%
#LINECOMMENT=;
#COMMENTON=/*
#COMMENTOFF=*/
#ESCAPE=``


#KEYWORD=Commands and Directives

)

FileRead, directives, Directives.txt
directives:=RegExReplace(directives,"m)^","^")
stx .= directives "`n"
FileRead, commands, Commands.txt
FileRead, variables, Variables.txt
FileRead, keywords, Keywords.txt
stx .= commands "`n`n#KEYWORD=Special Keywords`n" 
stx .= keywords "`n" variables "`n`n#KEYWORD=Key Codes`n" 
FileRead, keys, Keys.txt
keys:=RegExReplace(keys "`n","m)^(.*)$","{$1}`n$1")
keys:=RegExReplace(keys,"\x5e\s\n") ; ^
keys:=RegExReplace(keys,"\x2b\s\n") ; +
keys:=RegExReplace(keys,"\x21\s\n") ; !
keys:=RegExReplace(keys,"\x23\s\n") ; #
keys:=RegExReplace(keys,"\x60\s\n") ; `
keys:=RegExReplace(keys,"\x7e\s\n") ; ~
keys:=RegExReplace(keys,"\x24\s\n") ; $
stringreplace,keys,keys,{}`n,
stringreplace,keys,keys,{`n}`n,
stx .= keys "`n`n#`n" 

FileDelete, AutoHotkey.stx
FileAppend, %stx%, AutoHotkey.stx

; /-------------[updated section]-------------------

FileCopy,AutoHotkey.stx,%EditPlusDir%,1

if ErrorLevel <> 0
{
	MsgBox,16,%title%,Could not copy AutoHotkey.stx
	Exit
}

;FileCopy,AutoHotkey.ctl,%EditPlusDir%,1
;if ErrorLevel <> 0
;{
;	MsgBox,16,%title%,Could not copy AutoHotkey.ctl
;	Exit
;}

; Now add or update EditPlus settings
File=%EditPlusDir%\setting.ini
IniRead,X,%File%,Settings,Custom
if X = Error  ; Probably due to setting.ini not existing, which happens if EditPlus was just freshly installed.
  X = 1
Sect=Settings\Custom%X%

Loop,%X%
{
  XX=%A_Index%
  IniRead,desc,%File%,Settings\Custom%XX%,Description
  IfEqual,desc,AutoHotkey
  {
    Sect=Settings\Custom%XX%
    AlreadyConfigured=1
    Break
  }
}

; Set up the configuration
IniWrite,ahk`;aut,%File%,%Sect%,Extension
IniWrite,AutoHotkey,%File%,%Sect%,Description
;Causes an error dialog when used with a fresh installation of EditPlus: IniWrite,%A_Space%,%File%,%Sect%,File
IniWrite,4,%File%,%Sect%,Tab
IniWrite,2,%File%,%Sect%,Indent
IniWrite,80,%File%,%Sect%,Margin
IniWrite,1,%File%,%Sect%,Word Wrap
IniWrite,1,%File%,%Sect%,Auto Indent
IniWrite,0,%File%,%Sect%,Tab Indent
IniWrite,0,%File%,%Sect%,Common
IniWrite,123,%File%,%Sect%,Indent Open
IniWrite,125,%File%,%Sect%,Indent Close
IniWrite,0,%File%,%Sect%,End of Statement
; Seems unnecessary: IniWrite,%A_Space%,%File%,%Sect%,Function
IniWrite,%EditPlusDir%\AutoHotkey.stx,%File%,%Sect%,Syntax file
IniWrite,1,%File%,%Sect%,Insert Space
IniWrite,0,%File%,%Sect%,Hard break
IniWrite,0,%File%,%Sect%,Wrap at Column
IniWrite,0,%File%,%Sect%,Column Marker 1
IniWrite,0,%File%,%Sect%,Column Marker 2
IniWrite,0,%File%,%Sect%,Column Marker 3
IniWrite,0,%File%,%Sect%,Column Marker 4
IniWrite,0,%File%,%Sect%,Column Marker 5
IniWrite,16711680,%File%,%Sect%,0
IniWrite,255,%File%,%Sect%,1
IniWrite,8421376,%File%,%Sect%,2
IniWrite,32896,%File%,%Sect%,3
IniWrite,128,%File%,%Sect%,4
IniWrite,32768,%File%,%Sect%,5
IniWrite,32768,%File%,%Sect%,6
IniWrite,32768,%File%,%Sect%,7
IniWrite,32768,%File%,%Sect%,8
IniWrite,8388736,%File%,%Sect%,9
IniWrite,255,%File%,%Sect%,10
IniWrite,8388736,%File%,%Sect%,11
IniWrite,8388736,%File%,%Sect%,12
IniWrite,8388736,%File%,%Sect%,13
IniWrite,8388736,%File%,%Sect%,14
IniWrite,8388736,%File%,%Sect%,15
IniWrite,16711935,%File%,%Sect%,16

IniWrite,0,%File%,Settings,Disable Syntax

If AlreadyConfigured <> 1
{
  X++
  IniWrite,%X%,%File%,Settings,Custom
}

; Now prompt to make EditPlus the default editor for ahk files
DefaultEditor:
MsgBox,36,%title%,Do you want to make EditPlus the default editor for AutoHotkey scripts?
IfMsgBox,Yes,RegWrite,REG_SZ, HKEY_CLASSES_ROOT,AutoHotkeyScript\Shell\Edit\Command,,"%EditPlusDir%\EditPlus.exe" "`%1"

MsgBox,64,%title%,Installation complete!


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
