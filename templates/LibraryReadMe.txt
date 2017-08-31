What is a library?
------------------
Libraries are collections of compiled or assembled object modules that
provide a common set of useful routines and data. You use these libraries
to provide your program with the routines and data at link time; this is
called static linking. After you have linked a program to a library, the
program can use a routine or data item exactly as if it were included
in the program.

What can a library contain?
---------------------------
A library can contain the following types of modules:

1. Object files in the Microsoft Relocatable Object-Module Format (OMF),
   which is based on the Intel 8086 OMF. These object files can be
   created by compilers such as a C, C++ or Delphi compilers. Or, they
   can be assembled with the Microsoft Macro Assembler (MASM). 
2. Standard libraries in Microsoft library format.
3. Import libraries created by the Microsoft Import Library Manager
   (IMPLIB)
4. 286 XENIX archives and Intel-style libraries

How do I use a library with Visual MASM?
----------------------------------------
Simply add an assembly source file to the Library project with the menu
Project -> Add... and select an assembly source file to add. Visual 
MASM will assemble it with MASM and include it in the final library. 
Or, you can add the binary object (.obj) or binary library (.lib) files 
directly and Visual MASM will include it in the final library.

Tips:
-----
Libraries are a great way to organize large projects. Use libraries 
whenever you can. It will help you re-using your routines and data.
Also, make sure you include a readme file to describe your libaries 
and to document what's included in these libraries.