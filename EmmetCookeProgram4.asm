TITLE Program Template     (EmmetCookeProgram4.asm)

; Author: Emmet Cooke
; Course / Project ID: CS271-400 Program 4    Date: 10/30/2017
; Description:

INCLUDE Irvine32.inc

UPPER_LIMIT	= 400

.data

	; Strings for the introduction
	programTitle	BYTE	"Program   : Composite Numbers",0
	programmerName	BYTE	"Programmer: Emmet Cooke",0

	; Prompt to get data
	prompt1			BYTE	"Please enter the number of composite numbers you "
					BYTE	"would like to see.",0
	prompt2			BYTE	"Please enter an integer in the range [1 - 400]: ",0

	; Variables to hold data
	userInput		DWORD	?

.code
main PROC

; Introduction
	call	introduceProgrammer
	call	Crlf

; Get User Data
	call	getUserData
	; Validate User Data

; Show Composites
	; Is Composite

; Farewell

	exit	; exit to operating system
main ENDP

;-------------------------------------
; Procedure to introduce the programmer
; recieves: none
; returns: none
; preconditions: none
; registers changed: edx
;-------------------------------------
introduceProgrammer PROC USES edx
	mov		edx, OFFSET programTitle
	call	WriteString
	call	Crlf
	mov		edx, OFFSET programmerName
	call	WriteString
	call	Crlf
	ret
introduceProgrammer ENDP

;-------------------------------------
; Procedure to get an integer from the user
; recieves: none
; returns: none
; preconditions: none
; registers changed: edx
;-------------------------------------
getUserData PROC
	mov		edx, OFFSET prompt1
	call	WriteString
	call	Crlf
invalidInput:
	mov		edx, OFFSET prompt2
	call	WriteString
	;call	ReadInt
	call	Crlf
	;call	validateInput
	ret
getUserData ENDP


END main
