TITLE Program Template     (EmmetCookeProgram4.asm)

; Author: Emmet Cooke
; Course / Project ID: CS271-400 Program 4    Date: 10/30/2017
; Description:

INCLUDE Irvine32.inc

UPPER_LIMIT = 400
TAB = 9

.data

	; Strings for the introduction
	programTitle	BYTE	"Program   : Composite Numbers",0
	programmerName	BYTE	"Programmer: Emmet Cooke",0

	; Prompt to get data
	prompt1			BYTE	"Please enter the number of composite numbers you "
					BYTE	"would like to see.",0
	prompt2			BYTE	"Please enter an integer in the range [1 - 400]: ",0

	; Error String
	error			BYTE	"That is outside of the designated range. ",0

	; Variables to hold data
	userInput		DWORD	?

.code
main PROC

; Introduction
	call	introduceProgrammer
	call	Crlf

; Get User Data
	call	getUserData

; Show Composites
	call	writeComposites

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
getUserData PROC USES edx
	mov		edx, OFFSET prompt1
	call	WriteString
	call	Crlf
loopStart:
	mov		edx, OFFSET prompt2
	call	WriteString
	call	ReadInt
	push	eax
	call	Crlf
	call	validateInput
	pop		eax
	cmp		bx, 1
	je		invalidInput
	mov		ecx, eax
	jmp		endGetUserData

invalidInput:
	mov		edx, OFFSET error
	call	WriteString
	call	Crlf
	jmp		loopStart

endGetUserData:	
	ret
getUserData ENDP

;-------------------------------------
; Procedure to validate the user input
; recieves: user input value
; returns: none
; preconditions: none
; registers changed: 
;-------------------------------------
validateInput PROC
	push	ebp
	mov		ebp, esp
	mov		eax, [ebp + 8]
	cmp		eax, 1
	jb		badInput
	cmp		eax, UPPER_LIMIT
	ja		badInput
	pop		ebp
	mov		bx, 0
	ret		

badInput:
	pop		ebp
	mov		bx, 1
	ret		
validateInput ENDP

;-------------------------------------
; Procedure to validate the user input
; recieves: user input value
; returns: none
; preconditions: none
; registers changed: 
;-------------------------------------
writeComposites PROC USES eax ebx
	mov		ebx, 10
	mov		eax, 1
printStart:
	call	WriteDec
	dec		ebx
	cmp		ebx, 0
	je		rowBreak
	push	eax
	mov		al, TAB
	call	WriteChar
	pop		eax
writeNumber:
	inc		eax
	loop	printStart
	ret

rowBreak:
	mov		ebx, 10
	call	Crlf
	jmp		WriteNumber
writeComposites ENDP

;-------------------------------------
; Procedure to validate the user input
; recieves: user input value
; returns: none
; preconditions: none
; registers changed: 
;-------------------------------------
isPrime PROC
	ret
isPrime ENDP

END main
