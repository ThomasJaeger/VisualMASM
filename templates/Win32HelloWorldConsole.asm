; *************************************************************************
; 32-bit Windows Console Hello World Application - MASM32 Example
; EXE File size: 2,560 Bytes
; Created by Visual MASM (http://www.visualmasm.com)
; *************************************************************************
                                    
.386					; Enable 80386+ instruction set
.model flat, stdcall	; Flat, 32-bit memory model (not used in 64-bit)
option casemap: none	; Case insensitive syntax

; *************************************************************************
; MASM32 proto types for Win32 functions and structures
; *************************************************************************  
include c:\masm32\include\kernel32.inc
include c:\masm32\include\masm32.inc
         
; *************************************************************************
; MASM32 object libraries
; *************************************************************************  
includelib c:\masm32\lib\kernel32.lib
includelib c:\masm32\lib\masm32.lib

; *************************************************************************
; Our data section. Here we declare our strings for our message
; *************************************************************************
.data
	strMessage	db "Hello World!",0

; *************************************************************************
; Our executable assembly code starts here in the .code section
; *************************************************************************
.code

start:
	; Use the StdOut API function to display the text in a console.
    invoke StdOut, addr strMessage
    
	; When the console has been closed, exit the app with exit code 0
    invoke ExitProcess, 0
end start
