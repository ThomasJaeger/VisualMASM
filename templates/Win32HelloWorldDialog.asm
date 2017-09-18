; *************************************************************************
; 32-bit Windows Simple Dialog Application - MASM32 Example
; EXE File size: 3,072 Bytes
; Created by Visual MASM (http://www.visualmasm.com)
; *************************************************************************

.386					; Enable 80386+ instruction set
.model flat, stdcall	; Flat, 32-bit memory model (not used in 64-bit)
option casemap: none	; Case sensitive syntax

; *************************************************************************
; Our Dialog Window procedure prototype
; *************************************************************************
WndProc proto :DWORD,:DWORD,:DWORD,:DWORD

; *************************************************************************
; Our main application procedure prototype
; *************************************************************************
WinMain proto :DWORD,:DWORD,:DWORD,:DWORD 

; *************************************************************************
; MASM32 proto types for Win32 functions and structures
; *************************************************************************  
include \masm32\include\windows.inc 
include \masm32\include\user32.inc 
include \masm32\include\kernel32.inc 

; *************************************************************************
; MASM32 object libraries
; *************************************************************************  
includelib \masm32\lib\user32.lib 
includelib \masm32\lib\kernel32.lib 

; *************************************************************************
; Our initialized data section. Here we declare our strings.
; *************************************************************************
.data 
	ClassName db "DLGCLASS",0 
    MenuName db "MyMenu",0
	DlgName db "DesignForm",0 

; *************************************************************************
; Our un-initialized data section. We don't care about the values assigned.
; *************************************************************************
.data?
	hInstance HINSTANCE ? 
	CommandLine LPSTR ? 

; *************************************************************************
; Our constant section. Good for things like internal IDs, etc. 
; *************************************************************************
.const 

; *************************************************************************
; Our executable assembly code starts here in the .code section
; *************************************************************************
.code
 
start: 
	invoke	GetModuleHandle, NULL 
	mov		hInstance,eax 
	invoke	GetCommandLine
	mov		CommandLine,eax 
	invoke	WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT 
	invoke	ExitProcess,eax
	 
; *************************************************************************
; Our main window procedure. From here we kick of the dialog(s).
; *************************************************************************
WinMain	proc hInst:HINSTANCE,hPrevInst:HINSTANCE,CmdLine:LPSTR,CmdShow:DWORD 
	
	; ********************
	; Some local variables
	; ********************	
	LOCAL	wc:WNDCLASSEX 
	LOCAL	msg:MSG 
	LOCAL	hDlg:HWND
	 
	; *********************************************************
	; Prepare and fill-up the window class structure WNDCLASSEX 
	; *********************************************************	
	mov		wc.cbSize,SIZEOF WNDCLASSEX 
	mov		wc.style, CS_HREDRAW or CS_VREDRAW 
	mov		wc.lpfnWndProc, OFFSET WndProc 
	mov		wc.cbClsExtra,NULL 
	mov		wc.cbWndExtra,DLGWINDOWEXTRA 
	push	hInst 
	pop		wc.hInstance 
	mov		wc.hbrBackground,COLOR_BTNFACE+1 
	mov		wc.lpszMenuName,OFFSET MenuName 
	mov		wc.lpszClassName,OFFSET ClassName 
	invoke	LoadIcon,NULL,IDI_APPLICATION 
	mov		wc.hIcon,eax 
	mov		wc.hIconSm,eax 
	invoke	LoadCursor,NULL,IDC_ARROW 
	mov		wc.hCursor,eax
	; Now that we filled-up our window class, register it with the OS 
	invoke	RegisterClassEx, addr wc
	 
	; ***********************************************************
	; Now let's create the actual dialog, passing the dialog name
	; ***********************************************************	
	invoke	CreateDialogParam,hInstance,ADDR DlgName,NULL,NULL,NULL
	 
	; ******************************
	; Display the dialog to the user
	; ******************************	
	mov		hDlg,eax 
	invoke	ShowWindow, hDlg,SW_SHOWNORMAL
	
	; **************************************************
	; Update the dialog by sending a paint message to it  
	; **************************************************	
	invoke	UpdateWindow, hDlg
	
	; ******************************************
	; Go into a loop and process system messages 
	; ******************************************	
	.WHILE TRUE 
		invoke GetMessage, ADDR msg,NULL,0,0 
		.BREAK .IF (!eax) 
		invoke IsDialogMessage, hDlg, ADDR msg 
		.IF eax ==FALSE 
			invoke TranslateMessage, ADDR msg 
			invoke DispatchMessage, ADDR msg 
		.ENDIF 
	.ENDW 
	mov		eax,msg.wParam 
	ret 
WinMain endp 

end start 
