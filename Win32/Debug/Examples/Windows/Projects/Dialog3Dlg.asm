.386 
.model flat,stdcall 
option casemap:none 

include \masm32\include\windows.inc 
include \masm32\include\user32.inc 
include \masm32\include\kernel32.inc 

.Data?

.Data

.Code

Dialog3Proc proc hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
	.IF uMsg==WM_DESTROY 
		invoke PostQuitMessage,NULL 
	.ELSEIF uMsg==WM_COMMAND 
		mov eax,wParam 
		.IF lParam==0 
;			.IF ax==IDM_GETTEXT 
;				invoke GetDlgItemText,hWnd,IDC_EDIT,ADDR buffer,512 
;				invoke MessageBox,NULL,ADDR buffer,ADDR AppName,MB_OK 
;			.ELSEIF ax==IDM_CLEAR 
;				invoke SetDlgItemText,hWnd,IDC_EDIT,NULL 
;			.ELSE 
				invoke DestroyWindow,hWnd 
;			.ENDIF 
		.ELSE 
			mov edx,wParam 
			shr edx,16 
;			.IF dx==BN_CLICKED 
;				.IF ax==IDC_BUTTON 
;					invoke SetDlgItemText,hWnd,IDC_EDIT,ADDR TestString 
;				.ELSEIF ax==IDC_EXIT 
;					invoke SendMessage,hWnd,WM_COMMAND,IDM_EXIT,0 
;				.ENDIF 
;			.ENDIF 
		.ENDIF 
	.ELSE 
		invoke DefWindowProc,hWnd,uMsg,wParam,lParam 
		ret 
	.ENDIF 
	xor	eax,eax 
	ret 
Dialog3Proc endp

end
