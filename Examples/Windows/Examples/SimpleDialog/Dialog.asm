; **********************************************************
; Iczelion 
; Tutorial 10: Dialog Box as Main Window
; 
; http://www.programminghorizon.com/win32assembly/tut10.html
; **********************************************************

.386 
.model flat,stdcall 
option casemap:none 

WinMain proto :DWORD,:DWORD,:DWORD,:DWORD 
include \masm32\include\windows.inc 
include \masm32\include\user32.inc 
include \masm32\include\kernel32.inc 
includelib \masm32\lib\user32.lib 
includelib \masm32\lib\kernel32.lib 

.data 
	ClassName db "DLGCLASS",0 
	MenuName db "MyMenu",0 
	DlgName db "MyDialog",0 

.data?
	hInstance HINSTANCE ? 
	CommandLine LPSTR ? 

.const 
	IDM_EXIT		equ 32002
	 
.code
 
start: 
	invoke	GetModuleHandle, NULL 
	mov		hInstance,eax 
	invoke	GetCommandLine
	mov		CommandLine,eax 
	invoke	WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT 
	invoke	ExitProcess,eax
	 
WinMain	proc hInst:HINSTANCE,hPrevInst:HINSTANCE,CmdLine:LPSTR,CmdShow:DWORD 
	LOCAL	wc:WNDCLASSEX 
	LOCAL	msg:MSG 
	LOCAL	hDlg:HWND 
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
	invoke	RegisterClassEx, addr wc 
	invoke	CreateDialogParam,hInstance,ADDR DlgName,NULL,NULL,NULL 
	mov		hDlg,eax 
	invoke	ShowWindow, hDlg,SW_SHOWNORMAL 
	invoke	UpdateWindow, hDlg 
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

WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM 
	.IF uMsg==WM_DESTROY 
		invoke PostQuitMessage,NULL 
	.ELSEIF uMsg==WM_COMMAND 
		mov eax,wParam 
		.IF lParam==0 
			invoke DestroyWindow,hWnd 
		.ENDIF 
	.ELSE 
		invoke DefWindowProc,hWnd,uMsg,wParam,lParam 
		ret 
	.ENDIF 
	xor	eax,eax 
	ret 
WndProc endp 

end start 
