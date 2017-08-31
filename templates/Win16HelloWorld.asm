; *************************************************************************
; 16-bit Windows Hello World Application - MASM32 Example
; Created by Visual MASM (http://www.visualmasm.com)
; *************************************************************************
     
.286					; Enable 80286+ instruction set
.model medium, pascal	; 
option casemap: none	; Case sensitive syntax

STACKSLOP = 256 		; Amount of STACKSLOP required
maxRsrvPtrs = 5			; Number of Windows reserved pointers

; *************************************************************************
; Type definitions for functions used
; *************************************************************************  
EXTERNDEF	rsrvptrs:	word	; Pointers to Windows reserved pointers
PUBLIC		__astart			; Application startup routine
uInt		typerdef	word
hInstance	typerdef	uInt
hTask		typerdef	uInt
lPstr		typerdef	far ptr byte			

; *************************************************************************
; Proto types for functions and structures
; *************************************************************************  
Dos3Call	PROTO	far	PASCAL

; as of 08-30-2017, this is incomplete. You will need to finsih this
; startup code for Win16. When I have time, I might complete this.