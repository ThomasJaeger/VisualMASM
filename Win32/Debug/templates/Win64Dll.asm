; *************************************************************************
; 32-bit Windows Application Extension (DLL)
; Created by Visual MASM (http://www.visualmasm.com)
; *************************************************************************

; *************************************************************************
; MASM32 proto types for Win32 functions and structures
; *************************************************************************  
include \masm32\include\masm32rt.inc
include \masm32\include\windows.inc

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
; Main function
; *************************************************************************
LibMain proc instance:DWORD,reason:DWORD,unused:DWORD 

    .if reason == DLL_PROCESS_ATTACH
      mrm hInstance, instance       ; copy local to global
      mov eax, TRUE                 ; return TRUE so DLL will start

    .elseif reason == DLL_PROCESS_DETACH

    .elseif reason == DLL_THREAD_ATTACH

    .elseif reason == DLL_THREAD_DETACH

    .endif

    ret

LibMain endp

; *************************************************************************
; Your custom functions you may want to export in the DLL.
; *************************************************************************
My_proc proc 

    ret

My_proc endp

; *************************************************************************

  comment * -----------------------------------------------------
          You should add the procedures your DLL requires AFTER
          the LibMain procedure. For each procedure that you
          wish to EXPORT you must place its name in the "mydll.def"
          file so that the linker will know which procedures to
          put in the EXPORT table in the DLL. Use the following
          syntax AFTER the LIBRARY name on the 1st line.
          LIBRARY mydll
          EXPORTS YourProcName
          EXPORTS AnotherProcName
          ------------------------------------------------------- *

; *************************************************************************

end LibMain