; *************************************************************************
; 64-bit Windows Hello World Application - Win64 SDK Example
; EXE File size: 2,560 Bytes
; Created by Visual MASM (http://www.visualmasm.com)
; *************************************************************************

; *************************************************************************
; Proto types for API functions and structures
; *************************************************************************  
extrn ExitProcess: PROC
extrn MessageBoxA: PROC
         
; *************************************************************************
; Object libraries
; 
; NOTE: For 64-bit libraries, make sure you link the 64-bit versions
; of your libraries. For example:
; includelib "C:\Program Files (x86)\Windows Kits\10\Lib\10.0.14393.0\um\x64\user32.lib"
; includelib "C:\Program Files (x86)\Windows Kits\10\Lib\10.0.14393.0\um\x64\kernel32.lib"
; *************************************************************************
includelib user32.lib
includelib kernel32.lib
  
; *************************************************************************
; Our data section. Here we declare our strings for our message box
; *************************************************************************
.data
 	strTitle	db "64-bit",0
	strMessage	db "Hello World!",0

; *************************************************************************
; Our executable assembly code starts here in the .code section
; *************************************************************************
.code

WinMainCRTStartup PROC

	sub		rsp,28h			; shadow space, aligns stack
	mov		rcx,0			; hWnd = HWND_DESKTOP
	lea		rdx,strMessage	; LPCSTR lpText
	lea		r8,strTitle		; LPCSTR lpCaption
	mov		r9d,0			; uType = MB_OK
	
	; Use the MessageBoxA API function to display the message box.
	; To read more about MessageBox, move your mouse cursor over the
	; MessageBox text and press F1 to launch the Win32 help  
	call	MessageBoxA		; call MessageBox API function

	; When the message box has been closed, exit the app with exit code eax
	mov		ecx,eax
	call	ExitProcess

WinMainCRTStartup ENDP
End