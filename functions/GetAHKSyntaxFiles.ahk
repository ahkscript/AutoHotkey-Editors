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
