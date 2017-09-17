; This program makes appointments by storing ID numbers
; Appointment conflicts are checked
.ORIG x3000
LD R0, MReq			; memory location x3200 in R0
begin LDR R1, R0, #0		; load request in R1
LD R5, #5			; counter to 5
JSR RSH				; right shift (start time)
LDR R2, R4, #0			; start time in R2
LD R5, #5			; counter to 5
JSR RSH				; right shift (end time)
LDR R3, R4, #0			; end time in R3
LD R5, #6			; counter to 6
JSR RSH				; right shift (ID) -R4 full of 0's, R5 has ID
LDR R4, R5, #0			; ID in R4
BRz stop			; is ID zero????

LD R6, Cst			; memory location x3100 in R6
NOT R3, R3			; inverse of end time
ADD R3, R3, #1			; 2's comp of end time
ADD R3, R3, R2			; subtract start from end time (counter fo' time slots)
ADD R6, R2, R6			; get location for cstate time (time in request) :D
LDR R7, R3, #0

billy LDR R5, R6, #0		; cst id for time slot in R5
BRz gong			; check if ID in requested time slot is 0
NOT R1, R5			; inverse of time slot ID
ADD R1, R1, #1			; 2's comp of time slot ID
ADD R1, R1, R4			; diff or request ID and time slot ID
BRnp fail			; checks if ID's are the diff :3
gong ADD R6, R6, #1
ADD R3, R3, #-1
BRnp billy

LDR R3, R7, #0
LD R6, Cst
ADD R6, R2, R6
gwash STR R6, R4, #0
ADD R6, R6, #1
ADD R3, R3, #-1
BRnp gwash

fail ADD R0, R0, #1
LD R1, begin
JMP R1

stop HALT
RSH LD R4, #0			; clear R4 (blank variable)
    kevin ADD R4, R4, R4		; left shift
    ADD R1, R1, #0
    BRzp shift			; if R1 is neg, cont., else, skip to shift
    ADD R4, R4, #1		; add 1 to R4 if msb = 1
    shift ADD R1, R1, R1	; left shift request
    ADD R5, R5, #-1		; decrement counter
    BRnp kevin			; if counter 0, skip, else, cont.
RET
MReq .FILL x3200
Cst .FILL x3100

.END
