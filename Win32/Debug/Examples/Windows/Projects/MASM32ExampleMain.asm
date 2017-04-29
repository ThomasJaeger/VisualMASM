; #########################################################################

      .386
      .model flat, stdcall
      option casemap :none   ; case sensitive

; #########################################################################

      include \masm32\include\windows.inc
      include \masm32\include\gdi32.inc
      include \masm32\include\user32.inc
      include \masm32\include\kernel32.inc

      includelib \masm32\lib\gdi32.lib
      includelib \masm32\lib\user32.lib
      includelib \masm32\lib\kernel32.lib

; #########################################################################

      ;=============
      ; Local macros
      ;=============

      szText MACRO Name, Text:VARARG
        LOCAL lbl
          jmp lbl
            Name db Text,0
          lbl:
        ENDM

      m2m MACRO M1, M2
        push M2
        pop  M1
      ENDM

      return MACRO arg
        mov eax, arg
        ret
      ENDM

        ;=================
        ; Local prototypes
        ;=================
        WinMain PROTO :DWORD,:DWORD,:DWORD,:DWORD
        WndProc PROTO :DWORD,:DWORD,:DWORD,:DWORD
        TopXY PROTO   :DWORD,:DWORD

    .data
        szDisplayName db "Popup ListBox",0
        CommandLine   dd 0
        hWnd          dd 0
        hInstance     dd 0
        lpfnWndProc   dd 0

    .code

start:
        invoke GetModuleHandle, NULL
        mov hInstance, eax

        invoke GetCommandLine
        mov CommandLine, eax

        invoke WinMain,hInstance,NULL,CommandLine,SW_SHOWDEFAULT
        invoke ExitProcess,eax

; #########################################################################

WinMain proc hInst     :DWORD,
             hPrevInst :DWORD,
             CmdLine   :DWORD,
             CmdShow   :DWORD

        ;====================
        ; Put LOCALs on stack
        ;====================

        LOCAL msg  :MSG
        LOCAL Wwd  :DWORD
        LOCAL Wht  :DWORD
        LOCAL Wtx  :DWORD
        LOCAL Wty  :DWORD

        mov Wwd, 150
        mov Wht, 150

        invoke GetSystemMetrics,SM_CXSCREEN
        invoke TopXY,Wwd,eax
        mov Wtx, eax

        invoke GetSystemMetrics,SM_CYSCREEN
        invoke TopXY,Wht,eax
        mov Wty, eax

        szText szClassName,"LISTBOX"

        invoke CreateWindowEx,WS_EX_PALETTEWINDOW or WS_EX_CLIENTEDGE,
                              ADDR szClassName,
                              ADDR szDisplayName,
                              WS_OVERLAPPEDWINDOW or WS_VSCROLL or \
                              LBS_HASSTRINGS or LBS_NOINTEGRALHEIGHT or \
                              LBS_DISABLENOSCROLL, \
                              Wtx,Wty,Wwd,Wht,
                              NULL,NULL,
                              hInst,NULL
        mov   hWnd,eax

        invoke SetWindowLong,hWnd,GWL_WNDPROC,ADDR WndProc
        mov lpfnWndProc, eax

        invoke GetStockObject,ANSI_FIXED_FONT
        invoke SendMessage,hWnd,WM_SETFONT,eax,0

        jmp @123
          item1 db "This is item 1",0
          item2 db "This is item 2",0
          item3 db "This is item 3",0
          item4 db "This is item 4",0
          item5 db "This is item 5",0
          item6 db "This is item 6",0
          item7 db "This is item 7",0
          item8 db "This is item 8",0
          item9 db "This is item 9",0
          item0 db "This is item 0",0
        @123:

        invoke SendMessage,hWnd,LB_ADDSTRING,0,ADDR item1
        invoke SendMessage,hWnd,LB_ADDSTRING,0,ADDR item2
        invoke SendMessage,hWnd,LB_ADDSTRING,0,ADDR item3
        invoke SendMessage,hWnd,LB_ADDSTRING,0,ADDR item4
        invoke SendMessage,hWnd,LB_ADDSTRING,0,ADDR item5
        invoke SendMessage,hWnd,LB_ADDSTRING,0,ADDR item6
        invoke SendMessage,hWnd,LB_ADDSTRING,0,ADDR item7
        invoke SendMessage,hWnd,LB_ADDSTRING,0,ADDR item8
        invoke SendMessage,hWnd,LB_ADDSTRING,0,ADDR item9
        invoke SendMessage,hWnd,LB_ADDSTRING,0,ADDR item0

        invoke ShowWindow,hWnd,SW_SHOWNORMAL
        invoke UpdateWindow,hWnd

      ;===================================
      ; Loop until PostQuitMessage is sent
      ;===================================

    StartLoop:
      invoke GetMessage,ADDR msg,NULL,0,0
      cmp eax, 0
      je ExitLoop
      invoke TranslateMessage, ADDR msg
      invoke DispatchMessage,  ADDR msg
      jmp StartLoop
    ExitLoop:

      return msg.wParam

WinMain endp

; #########################################################################

WndProc proc hWin   :DWORD,
             uMsg   :DWORD,
             wParam :DWORD,
             lParam :DWORD

    .if uMsg == WM_CLOSE

    .elseif uMsg == WM_DESTROY
        invoke PostQuitMessage,NULL
        return 0 
    .endif

    invoke CallWindowProc,lpfnWndProc,hWin,uMsg,wParam,lParam

    ret

WndProc endp

; ########################################################################

TopXY proc wDim:DWORD, sDim:DWORD

    shr sDim, 1      ; divide screen dimension by 2
    shr wDim, 1      ; divide window dimension by 2
    mov eax, wDim    ; copy window dimension into eax
    sub sDim, eax    ; sub half win dimension from half screen dimension

    return sDim

TopXY endp

; ########################################################################

end start
