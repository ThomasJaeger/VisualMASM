VisualMASM
==========
Create Microsoft Windows and MS-DOS applications with Visual MASM for Microsoft Macro Assembler (MASM). This will be the source repository of the project site at http://www.visualmasm.com

![visualmasm0](https://cloud.githubusercontent.com/assets/1396719/22631839/aaf84fac-ebe1-11e6-82b2-7e0cc2f74fa4.png)

Update
------
I decided to release the source code of VisualMASM on Github. This allows me to share the code base for more feedback and also keep the project going with potential project contributors. The source code that I will be adding to Github is not the current code base but a new version of VisualMASM 2.0. I want to make some big changes to VisualMASM and I figured this is a good way to also share the source code at the same time. You can follow along the changes of VisualMASM as I will build it out more over time and when time permits at the Github repository.

Not working, yet
----------------
This new version 2 is not working yet as I'm moving code from version 1 to 2. If you want a working version, you can go the project site at http://www.visualmasm.com and download version 1 from there.

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
- SynEdit
