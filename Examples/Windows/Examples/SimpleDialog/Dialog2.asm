.386
.model flat,stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc

.Data?

.Data

.Code

WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM 
	.IF uMsg==WM_DESTROY 
		invoke PostQuitMessage,NULL 
	.ELSEIF uMsg==WM_COMMAND 
		mov eax,wParam 
		.IF lParam==0 
			invoke DestroyWindow,hWnd
		.ELSE
			mov edx,wParam
			shr edx,16
			; Process messages here
		.ENDIF 
	.ELSE 
		invoke DefWindowProc,hWnd,uMsg,wParam,lParam 
		ret 
	.ENDIF 
	xor	eax,eax 
	ret 
WndProc endp 

end
