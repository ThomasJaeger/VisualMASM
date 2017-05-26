; *************************************************************************
; 32-bit Windows Hello World Application - MASM32 Example
; EXE File size: 2,560 Bytes
; Created by Visual MASM (http://www.visualmasm.com)
; *************************************************************************
     
.386					; Enable 80386+ instruction set
.model flat, stdcall	; Flat, 32-bit memory model (not used in 64-bit)
option casemap: none	; Case sensitive syntax

; *************************************************************************
; MASM32 proto types for Win32 functions and structures
; *************************************************************************  
include c:\masm32\include\windows.inc
include c:\masm32\include\user32.inc
include c:\masm32\include\kernel32.inc
         
; *************************************************************************
; MASM32 object libraries
; *************************************************************************  
includelib c:\masm32\lib\user32.lib
includelib c:\masm32\lib\kernel32.lib

; *************************************************************************
; Our data section. Here we declare our strings for our message box
; *************************************************************************
.data
      strTitle		db "Bare Bone",0
      strMessage	db "Hello World!",0

; *************************************************************************
; Our executable assembly code starts here in the .code section
; *************************************************************************
.code

start:
	; Use the MessageBox API function to display the message box.
	; To read more about MessageBox, move your mouse cursor over the
	; MessageBox text and press F1 to launch the Win32 help  
    invoke MessageBox, 0, ADDR strMessage, ADDR strTitle, MB_OK
    
	; When the message box has been closed, exit the app with exit code 0
    invoke ExitProcess, 0
end start
