Visual MASM
===========
Create 32-bit and 64-bit Microsoft Windows and 16-bit MS-DOS applications with Visual MASM for Microsoft Macro Assembler (MASM). This is the source repository of the project site at http://www.visualmasm.com

![visualmasm0](https://cloud.githubusercontent.com/assets/1396719/26026485/ffe4df42-37c9-11e7-9b6a-885410abf210.png)
![visualmasm0](https://cloud.githubusercontent.com/assets/1396719/24023490/07cabdc2-0a83-11e7-8c87-c83795279f0e.png)
![visualmasm0](https://cloud.githubusercontent.com/assets/1396719/24279842/bbcbfe5e-1022-11e7-86b5-06e2086d0658.png)

Update - 07-12-17
-------------------
- Prep work for upcoming Visual MASM user-mode debugger
- Removed AlphaSkins and replaced with Delphi's built-in VCL Style skinning
- Replaced older TSynEdit with TurboPack SynEdit, added MASM Assembly support
- Implemented full docking panel support with drag & drop of panels and tool windows (similar to Visual Studio)
- Fixed loading group when documents are still open
- Fixed status bar when multiple projects are open
- Fixed closing dialog file should also close .asm and .rc files
- Added IDE layout saving and loading capability
- Added loading of Skins from main IDE window
- Added Windows Controls panel (when designing Windows Dialogs)
- Added Object Tree panel (when designing Windows Dialogs)
- Added toolbar for main IDE window

To try out the latest build
---------------------------
To try out the latest build, copy all files and sub-folders from this folder:
https://github.com/ThomasJaeger/VisualMASM/tree/master/Win32/Debug
and run VisualMASM.exe

Run VisualMASMSetup.exe
-----------------------
Instead of copying the files above, you can simply download and run the new setup program
for Visual MASM. You can download it here:
https://github.com/ThomasJaeger/VisualMASM/raw/master/Setup/VisualMASMSetup.exe

Video 3 - Form Designer

[![Form Designer](https://img.youtube.com/vi/tsIvckVAdKk/0.jpg)](https://www.youtube.com/watch?v=tsIvckVAdKk)

Video 2 - Early Version

[![Early Version](https://img.youtube.com/vi/YgQFvElx9dA/0.jpg)](https://www.youtube.com/watch?v=YgQFvElx9dA)

Video 1 - Why

[![Why](https://img.youtube.com/vi/GnaeTDGWEzA/0.jpg)](https://www.youtube.com/watch?v=GnaeTDGWEzA)

Requirements
------------
The installation program of VisualMASM will allow you to download MASM32 or the Microsoft Platform SDK so that you can start writing assembly programs right away.

Donate
------
Help support Visual MASM with your financial donation at http://paypal.me/thomasheinzjaeger
This will help me with paying for some or all of the expenses to keep Visual MASM going.

Compiling Source
----------------
To compile the source you will need the follwing:
- Delphi XE4
- SynEdit (https://github.com/ThomasJaeger/SynEdit-1, forked from TurboPack)
- HtmlViewer (https://github.com/BerndGabriel/HtmlViewer)
- Json Data Objects (https://github.com/ahausladen/JsonDataObjects)
- VCL Styles Utils (https://github.com/RRUZ/vcl-styles-utils)
- LMD IDE-Tools (commercial
