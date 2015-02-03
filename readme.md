# AutoHotkey Syntax Highlighting for text editors
 
A collection of links and scripts to setup [syntax highlighting](http://en.wikipedia.org/wiki/Syntax_highlighting)
for a variety of text editors. 

This GitHub repository tries to maintain current versions of Keywords, Functions, Variables, Directives, Commands and Keys that used to be included with the AutoHotkey "basic" installer. By having installation scripts download these files from this repository, they are easier to maintain, and if written properly, make it easier to update your current syntax files when new commands or keywords are added to AutoHotkey.

A simple function to download the files from GH can be found [here](functions/GetAHKSyntaxFiles.ahk), but you can of course write your own.

## Syntax files

Available files (for AutoHotkey 1.x)

* [Commands.txt](Commands.txt)
* [Directives.txt](Directives.txt)
* [Functions.txt](Functions.txt)
* [Keywords.txt](Keywords.txt)
* [Variables.txt](Variables.txt)
* [Keys.txt](Keys.txt)

Available files (for AutoHotkey 2.x)

* None as of yet

## Supported Editors

### Dedicated AutoHotkey Editors:

* [AHK Studio](http://ahkscript.org/boards/viewtopic.php?f=6&t=300) - [Forum](http://ahkscript.org/boards/viewtopic.php?f=6&t=300) - Scintilla based editor written in AHK for AHK
* [SciTE4AutoHotkey](http://fincs.ahk4.net/scite4ahk/) - [forum](http://ahkscript.org/boards/viewtopic.php?f=6&t=62)
* [QuickAHK](http://www.autohotkey.net/~jballi/QuickAHK/v2.2/QuickAHK.zip) - [forum](http://www.autohotkey.com/board/topic/33125-quickahk-v22/)

### Installation scripts:

* Coming soon

### Ready made syntax higlighting (may not be uptodate):

* [AkelPad](https://github.com/Lenchik/Akelpad-syntax-highlighting/blob/master/ahk.coder) - tested with v4.8.7 (x64) with Coder 12.4 plugin
* [Atom.io](https://github.com/nshakin/language-autohotkey) - rudimentary
* [HiEditor](http://www.winasm.net/forum/index.php?showtopic=2321)
* [Notepad++](http://ahkscript.org/boards/viewtopic.php?f=7&t=50) - v6.5.1
* [Sublime Text 2/3](https://github.com/ahkscript/SublimeAutoHotkey)
* [TextPad](http://www.textpad.com/add-ons/files/syntax/autohotkey.zip) - *last update 2004*
* [Vim](https://github.com/vim-scripts/autohotkey-ahk)

**Gone missing or to do**

* ConTEXT
* Crimson Editor
* EditPlus
* Emacs
* EmEditor
* jEdit
* MED
* PSPad
* TextPad
* UltraEdit

### Editors with "built-in" AutoHotkey syntax highlighting:

* [EverEdit](http://www.everedit.net)
* [notepad2-mod](http://xhmikosr.github.io/notepad2-mod/)

### Other

* [CodeQuickTester](http://ahkscript.org/boards/viewtopic.php?f=6&t=6113) - The quick code tester/editor
* [GeSHi](https://github.com/GeSHi/) - PHP based "Generic Syntax Highlighter"
* [Script: Syntax highlighting for posting AutoHotkey code on phpbb forums](https://github.com/ahkon/Highlite)
* [Web Syntax Highlighters](https://github.com/ahkscript/awesome-AutoHotkey#web-syntax-highlighters)
* [Wordpress plugin](https://wordpress.org/plugins/syntaxhighlighter-evolved-autohotkey-brush/)

## Functions

**Download files and strip comments and empty lines**

Available functions (for AutoHotkey 1.x)

* [GetAHKSyntaxFiles()](functions/GetAHKSyntaxFiles.ahk)

## Writing your own

If you write or update a script please do take into account the following:

* Include any specific instructions at the top of your installer script(s)
* Try to detect if syntax highlighting is already installed, if so, offer the option to the user to only update the Syntax File (and not affect any colour schemes they may already have setup)
* Always have your script download these files from the GitHub repository: [Commands.txt](Commands.txt), [Directives.txt](Directives.txt), [Functions.txt](Functions.txt), [Keywords.txt](Keywords.txt), [Variables.txt](Variables.txt) and [Keys.txt](Keys.txt). That way your script does not have to be updated when a new function or command is added.
* Submit a pull request to this GH repository to have your script included here

