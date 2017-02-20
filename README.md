VisualMASM
==========
Create Microsoft Windows and MS-DOS applications with Visual MASM for Microsoft Macro Assembler (MASM). This will be the source repository of the project site at http://www.visualmasm.com

![visualmasm0](https://cloud.githubusercontent.com/assets/1396719/22631839/aaf84fac-ebe1-11e6-82b2-7e0cc2f74fa4.png)

Update - 02-20-2017
-------------------
- Added tab support

Update - 02-18-2017
-------------------
- Added VisualMASMColors.json file which allows you to customize the editor's colors, fonts, etc.
- Added simple copy & paste, comment line, etc. features
- Ctrl-N creates a new editor (can't save or load files, yet)
- Implemented full Microsoft MASM code highlighting and tokenization

Not fully working, yet
----------------------
This new version 2 is only partially working as I'm moving code from version 1 to 2. If you want a working version, you can go the project site at http://www.visualmasm.com and download version 1 from there.

To try out the latest build, copy all files from this folder:
https://github.com/ThomasJaeger/VisualMASM/tree/master/Win32/Debug
and run VisualMASM.exe

In the meantime, if you following along this repo, you can see how VisualMASM is being built over time. I'm moving some code from version 1 into version 2 over time. There are some major changes I'm planning on making such as:

- Project Explorer based on the VisualMASM objects
- Project Explorer persisted as formatted JSON text file
- New editor features such as minimap, code folding, etc.
- Full support for code completion and function paramters
- Externalizing skins
- Adding font and color options for editor
- bug fixes and more

Supports MASM
-------------
VisualMASM fully supports MASM and all its macros.

Goal
----
I will be incorporating some of the original Delphi source into this repository and work on it when I have time.

Requirements
------------
The installation program of VisualMASM will allow you to download MASM32 or the Microsoft Platform SDK so that you can start writing assembly programs right away.

Compiling Source
----------------
To compile the source you will need the follwing:
- Delphi XE4
- AlphaSkins (commercial)
- SynEdit (https://github.com/ThomasJaeger/SynEdit)
