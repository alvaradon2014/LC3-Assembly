;Finds the student name given an ID number
;Student ID and name are stored in a tree

.ORIG x3000
LEA R0, PROMPT		; LOADS ADDRESS OF PROMPT INTO RO
PUTS			; PRINTS PROMPT ONTO CONSOLE
GETC			; GETS STUDENT ID
OUT			; SHOWS ID ONTO CONSOLE
ADD R1, R0, #0		; COPIES INPUT ID INTO R1
GETC			; GETS ENTER
OUT			; SHOWS ENTER ONTO CONSOLE
ADD R0, R1, #0		; COPIES ID INTO R0
JSR IDHEX		; GETS HEX VALUE OF ID
LD R2, ROOT		; LOADS MEM LOC OF ROOT INTO R2
LD R4, ROOT		; COPIES MEM LOC OF ROOT INTO R4
TREEID ADD R4, R4, #0
       BRnp CONTINUE	; CHECKS IF LEFT CHILD IS ZERO, IF SO, CHECKS RIGHT, IF NOT, CONTINUES
       ADD R5, R4, #1	; MEM LOC OF RIGH CHILD
       BRz NA		; CHECKS IF BOTH CHILDREN ARE 0 (IF THERE'S NO ENTRY
CONTINUE ADD R3, R2, #2	; GETS MEM LOC OF ID
       LDR R3, R3, #0	; GETS VALUE OF ID
       NOT R1, R0	; INVERTS VALUE OF ID
       ADD R1, R1, #1	; 2'S COMP OF ID
       ADD R3, R3, R1	; SUBTRACTS ID FROM INPUT ID
       BRp LEFT		; IF ANS IS POS, INPUT IS LESS THAN ID
       BRn RIGHT	; IF ANS IS NEG, INPUT IS GREATER THAN ID
       ADD R3, R2, #3	; IF ANS IS 0, INPUT = ID, GET MEM LOC OF NAME
       LDR R3, R3, #0	; GETS START OF NAME
       ADD R0, R3, #0	; COPIES START OF NAME INTO R0
       PUTS		; PRINTS NAME OF STUDENT WITH ID
       BRnzp EXIT	; GOES TO HALT
LEFT LDR R2, R2, #0	; GETS CONTENTS AT MEM LOC OF LEFT CHILD
     BRnzp TREEID	; COMPARES INPUT TO ID
RIGHT ADD R2, R2, #1	; GETS MEM LOC OF RIGHT CHILD
      ADD R4, R2, #0	; COPIES MEM OF RIGHT CHILD INTO R4
      LDR R2, R2, #0	; GETS CONTENTS OF RIGHT CHILD
      BRnzp TREEID	; COMPARES INPUT TO ID
NA LEA R0, NONE
   PUTS
EXIT HALT

PROMPT       .FILL x0054		; "Type a student ID and then press Enter:"
             .FILL x0079
             .FILL x0070
             .FILL x0065
             .FILL x0020
             .FILL x0061
             .FILL x0020
             .FILL x0073
             .FILL x0074
             .FILL x0075
             .FILL x0064
             .FILL x0065
             .FILL x006E
             .FILL x0074
             .FILL x0020
             .FILL x0049
             .FILL x0044
             .FILL x0020
             .FILL x0061
             .FILL x006E
             .FILL x0064
             .FILL x0020
             .FILL x0070
             .FILL x0072
             .FILL x0065
             .FILL x0073
             .FILL x0073
             .FILL x0020
             .FILL x0045
             .FILL x006E
             .FILL x0074
             .FILL x0065
             .FILL x0072
             .FILL x003A
             .FILL x0A
             .FILL x0000
IDHEX	LD R2, INPUTHEX
	ADD R0, R0, R2
	ADD R1, R0, #0
	LD R2, CHECKd
	ADD R1, R1, R2
	BRz EXIT
	AND R1, R1, #0
RET

INPUTHEX .FILL x-30
CHECKd .FILL x-34
ROOT .FILL x3300	
NONE .FILL x004E		; NO ENTRY
     .FILL x006F
     .FILL x0020
     .FILL x0045
     .FILL x006E
     .FILL x0074
     .FILL x0072
     .FILL x0079
     .FILL x0A
     .FILL x0000

.END