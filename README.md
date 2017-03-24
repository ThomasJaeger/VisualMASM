VisualMASM
==========
Create 32-bit and 64-bit Microsoft Windows and 16-bit MS-DOS applications with Visual MASM for Microsoft Macro Assembler (MASM). This will be the source repository of the project site at http://www.visualmasm.com

![visualmasm0](https://cloud.githubusercontent.com/assets/1396719/24023474/f579e5bc-0a82-11e7-8466-4b0b550e2a0d.png)
![visualmasm0](https://cloud.githubusercontent.com/assets/1396719/24023490/07cabdc2-0a83-11e7-8c87-c83795279f0e.png)

Update - 03-23-2017
-------------------
- Added new visual form designer to create dialogs easily (Project > Add New > Dialog File)
  (Events handlers are not hooked up, yet nor is the creation of .RC files)

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

Video 2 - Early Version

[![Early Version](https://img.youtube.com/vi/YgQFvElx9dA/0.jpg)](https://www.youtube.com/watch?v=YgQFvElx9dA)

Video 1 - Why

[![Why](https://img.youtube.com/vi/GnaeTDGWEzA/0.jpg)](https://www.youtube.com/watch?v=GnaeTDGWEzA)

Requirements
------------
The installation program of VisualMASM will allow you to download MASM32 or the Microsoft Platform SDK so that you can start writing assembly programs right away.

Compiling Source
----------------
To compile the source you will need the follwing:
- Delphi XE4
- AlphaSkins (commercial)
- EControl form designer (commercial)
- SynEdit (https://github.com/ThomasJaeger/SynEdit)
