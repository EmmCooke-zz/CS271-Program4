TITLE Composite Numbers    (EmmetCookeProgram4.asm)

; Author: Emmet Cooke
; Course / Project ID: CS271-400 Program 4    Date: 10/30/2017
; Description: This program asks the user for the number of composite numbers they
; would like to see printed. It takes this number and then goes through as many numbers
; as it needs to until that number of composites are printed. It checks if a number is
; prime, and if it is not, it prints it.
; EC1: The output numbers are aligned.

INCLUDE Irvine32.inc

UPPER_LIMIT = 400
TAB = 9

.data

	; Strings for the introduction
	programTitle	BYTE	"Program   : Composite Numbers",0
	programmerName	BYTE	"Programmer: Emmet Cooke",0
	extraCredit1	BYTE	"EC1: Numbers are aligned in output",0

	; Prompt to get data
	prompt1			BYTE	"Please enter the number of composite numbers you "
					BYTE	"would like to see.",0
	prompt2			BYTE	"Please enter an integer in the range [1 - 400]: ",0

	; Error String
	error			BYTE	"That is outside of the designated range. ",0

	; Variables to hold data
	userInput		DWORD	?
	prime			DWORD	0
	numbersPrinted	DWORD	0

	; Strings for farewell
	goodbye			BYTE	"Thank you for using this program. Goodbye.",0
.code
main PROC

; Introduction
	call	introduceProgrammer
	call	Crlf

; Get User Data
	call	getUserData

; Show Composites
	call	writeComposites
	call	Crlf

; Farewell
	call	farewellMessage

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
	mov		edx, OFFSET extraCredit1
	call	WriteString
	call	Crlf
	ret
introduceProgrammer ENDP

;-------------------------------------
; Procedure to output goodbye message
; recieves: none
; returns: none
; preconditions: none
; registers changed: edx
;-------------------------------------
farewellMessage PROC USES edx
	mov		edx, OFFSET goodbye
	call	WriteString
	call	Crlf
	ret
farewellMessage ENDP

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
	push	eax				; Send eax to validateInput
	call	Crlf
	call	validateInput
	pop		eax
	cmp		bx, 1			; if bx equal to 1 as set by validateInput
	je		invalidInput	; the input is not valid
	mov		userInput, eax	; pass the valid entry to a global variable
	jmp		endGetUserData

invalidInput:
	mov		edx, OFFSET error
	call	WriteString
	call	Crlf
	jmp		loopStart		; try again

endGetUserData:	
	ret
getUserData ENDP

;-------------------------------------
; Procedure to validate the user input
; recieves: user input value
; returns: bx
; preconditions: none
; registers changed: eax ebp esp
;-------------------------------------
validateInput PROC
	push	ebp
	mov		ebp, esp
	mov		eax, [ebp + 8]
	; Check if the number is below 1
	cmp		eax, 1			
	jb		badInput
	; Check if the number is above 400
	cmp		eax, UPPER_LIMIT
	ja		badInput
	pop		ebp
	mov		bx, 0	; The input is good
	ret		

badInput:
	pop		ebp
	mov		bx, 1	; The input is bad
	ret		
validateInput ENDP

;-------------------------------------
; Procedure to print out the composite numbers
; recieves: none
; returns: none
; preconditions: none
; registers changed: eax, ebx, ecx, edx
;-------------------------------------
writeComposites PROC USES eax ebx
	mov			ecx, UPPER_LIMIT
	mov			ebx, 10
	mov			eax, 4

printStart:
	push		eax
	call		isPrime
	pop			eax
	; Check if the number is prime
	cmp			prime, 1
	jne			primeNumber	; the number is prime
	call		WriteDec
	inc			numbersPrinted	; tracks how many numbers are printed
	call		WriteTab
	; Check if at the end of a row
	dec			ebx
	cmp			ebx, 0	
	je			rowBreak
continuePrint:
	push		eax
	; Check how many numbers have been printed
	mov			eax, userInput
	cmp			eax, numbersPrinted
	je			endPrint
	pop			eax
	inc			eax
	loop		printStart

; If the number is prime, skip the printing process
primeNumber:
	inc			eax
	loop		printStart

; If 10 have been printed, create a new row
rowBreak:
	mov			ebx, 10
	call		Crlf
	jmp			continuePrint

endPrint:
	pop			eax
	ret
writeComposites ENDP

;-------------------------------------
; Procedure to check if a number is prime
; recieves: eax
; returns: prime
; preconditions: none
; registers changed: eax ebx ecx edx
;-------------------------------------
isPrime PROC USES eax ebx ecx edx
	mov		ebx, 2
; Determine how many numbers need to be checked
	mov		ecx, eax
	sub		ecx, ebx
	dec		ecx	; So that the final number isn't checked

checkPrime:
	xor		edx, edx
	push	ecx
	mov		ecx, eax	; Holds eax during idiv
	idiv	ebx
	mov		eax, ecx
	pop		ecx
	cmp		edx, 0		; If no remainder, it's prime
	je		notPrime
	inc		ebx
	loop	checkPrime

	mov		prime, 0	; Not prime
	ret

notPrime:
	mov		prime, 1
	ret

isPrime ENDP

;-------------------------------------
; Procedure to print a tab between numbers
; recieves: none
; returns: none
; preconditions: none
; registers changed: eax
;-------------------------------------
writeTab PROC
	push	eax
	mov		al, TAB
	call	WriteChar
	pop		eax
	ret
writeTab ENDP

END main
