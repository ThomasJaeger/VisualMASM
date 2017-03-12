VisualMASM
==========
Create Microsoft Windows and MS-DOS applications with Visual MASM for Microsoft Macro Assembler (MASM). This will be the source repository of the project site at http://www.visualmasm.com

![visualmasm0](https://cloud.githubusercontent.com/assets/1396719/22631839/aaf84fac-ebe1-11e6-82b2-7e0cc2f74fa4.png)

Update - 03-12-2017
-------------------
- Added new Blue code editor color
- Fixed color editor switching in Options menu

Update - 03-11-2017
-------------------
- Added new Labels list view
- Added search selection highlight (double click to enable or disable a word in editor)

Update - 03-04-2017
-------------------
- Added new function list view
- Added project options
- Added Themes

Update - 02-28-2017
-------------------
- Added Tools -> Options -> File Locations
- Added Setup wizard to download MASM32 package
- Added Assemble, Build, Run capabilities to projects and files

Update - 02-26-2017
-------------------
- Fixes
- Added Search & Replace
- Added Bookmarks

Update - 02-25-2017
-------------------
- Fine tuned creation of new projects
- Added File, Project, and Group functionality (Project Explorer)

Update - 02-20-2017
-------------------
- Added tab support
- Added templates
- Added basic saving
- Added project type support
- Added project file type support

Update - 02-18-2017
-------------------
- Added VisualMASMColors.json file which allows you to customize the editor's colors, fonts, etc.
- Added simple copy & paste, comment line, etc. features
- Ctrl-N creates a new editor
- Implemented full Microsoft MASM code highlighting and tokenization

To try out the latest build
---------------------------
To try out the latest build, copy all files and sub-folders from this folder:
https://github.com/ThomasJaeger/VisualMASM/tree/master/Win32/Debug
and run VisualMASM.exe

There are some major changes I'm planning on making such as:

- Project Explorer based on the VisualMASM objects [Done]
- Project Explorer persisted as formatted JSON text file [Done]
- New editor features such as minimap, code folding, etc.
- Full support for code completion and function paramters
- Externalizing skins [Done]
- Adding font and color options for editor [Done]
- bug fixes and more

Requirements
------------
The installation program of VisualMASM will allow you to download MASM32 or the Microsoft Platform SDK so that you can start writing assembly programs right away.

Compiling Source
----------------
To compile the source you will need the follwing:
- Delphi XE4
- AlphaSkins (commercial)
- SynEdit (https://github.com/ThomasJaeger/SynEdit)
