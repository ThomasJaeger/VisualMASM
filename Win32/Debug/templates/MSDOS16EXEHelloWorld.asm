; *************************************************************************
; 16-bit MS-DOS COM Hello World Application
; EXE File size: 542 Bytes
; Created by Visual MASM (http://www.visualmasm.com)
; For 16-bit DOS running restricts under Windows 2000/XP see below. 
; For more information about DOS interrupts, see:
; http://spike.scu.edu.au/~barry/interrupts.html
; *************************************************************************
.model	small			; Designate the application as EXE file

; *************************************************************************
; Our stack section
; *************************************************************************
.stack

; *************************************************************************
; Our data section. Here we declare our strings for our console message
; *************************************************************************
.data
	strMessage	db "Hello world", "$"
	
; *************************************************************************
; Our executable assembly code starts here in the .code section
; *************************************************************************
.code

	main	proc
			mov	ax,seg strMessage
			mov	ds,ax
			mov	ah,09
			lea	dx,strMessage
			int	21h					; Call DOS interrupt 21h

			mov	ax,4c00h
			int	21h					; Call DOS interrupt 21h
	main	endp
	
end	main

; =================================================== 
; 16-bit DOS running restricts under Windows 2000/XP:
; ===================================================
;
; * All MS-DOS functions except task-switching API (application programming interface) functions are supported.
; * Block mode device drivers are not supported. Block devices are not supported, so MS-DOS I/O control 
;      (IOCTL) APIs that deal with block devices and SETDPB functions are not supported.
; * Interrupt 10 function 1A returns 0; all other functions are passed to read-only memory (ROM).
; * Interrupt 13 calls that deal with prohibited disk access are not supported.
; * Interrupt 18 (ROM BASIC) generates a message that says that ROM BASIC is not supported.
; * Interrupt 19 does not restart the computer, but cleanly closes the current virtual DOS machine (VDM).
; * Interrupt 2F, which deals with the DOSKEY program callouts (AX = 4800), is not supported.
; * Microsoft CD-ROM Extensions (MSCDEX) functions 2, 3, 4, 5, 8, E, and F are not supported.
; * The 16-bit Windows subsystem on an x86 computer supports enhanced mode programs; it does not, however, 
;      support 16-bit virtual device drivers (VxDs). The subsystem on a non-x86 computer emulates the Intel 
;      40486 instruction set, which lets the computer run Enhanced-mode programs, such as Microsoft 
;      Visual Basic, on reduced instruction set computers (RISC).
;
; This means that Windows does not support 16-bit programs that require unrestricted access to hardware. 
; If your program requires this, your program will not work in Windows NT, Windows 2000, or Windows XP.
; (source: http://wyding.blogspot.com/2009/04/helloworld-for-16bit-dos-assembly.html)
