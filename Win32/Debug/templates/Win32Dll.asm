; *************************************************************************
; 32-bit Windows Application Extension (DLL - Dynamic Link Library)
; Created by Visual MASM (http://www.visualmasm.com)
; *************************************************************************

; *************************************************************************
; MASM32 proto types for Win32 functions and structures
; *************************************************************************  
include \masm32\include\masm32rt.inc

; *************************************************************************
; Our data section. Put your declarations here
; *************************************************************************
.data?
hInstance dd ?

; *************************************************************************
; Our executable assembly code starts here in the .code section
; *************************************************************************
.code

; *************************************************************************
; Main function, this is the DLL entry point that Windows will call
; *************************************************************************
LibMain proc instance:DWORD,reason:DWORD,unused:DWORD 

    ; *********************************************************************
    ; DLL_PROCESS_ATTACH - Your dll is being loaded, this is where you 
    ; can do your initialization.
    ; *********************************************************************
    .if reason == DLL_PROCESS_ATTACH
        mrm hInstance, instance       ; copy local to global
        mov eax, TRUE                 ; return TRUE so DLL will start

    ; *********************************************************************
    ; DLL_PROCESS_DETACH - Your dll did not load successfully, or it is 
    ; being terminated. This is where you can do any cleanup if needed.
    ; *********************************************************************
    .elseif reason == DLL_PROCESS_DETACH

    ; *********************************************************************
    ; DLL_THREAD_ATTACH, DLL_THREAD_DETACH
    ; These are the same as the above but for multi-threaded dlls.
    ; *********************************************************************
    .elseif reason == DLL_THREAD_ATTACH
    .elseif reason == DLL_THREAD_DETACH

    .endif

    ret

LibMain endp

; *************************************************************************
; Your custom functions go here. 
; To export your functions, right click on the project name in the project 
; manager, select "Export Functions" and click the functions you would 
; like to export from your DLL.
; *************************************************************************
My_proc proc 

    ret

My_proc endp

end LibMain