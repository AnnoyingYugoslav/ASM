ORG 0x00
jmp start


ORG 0x0B
jmp timer



timer:
inc r5
cjne r5, #1, y ;12 dla rzeczywistego
mov r5, #0
inc r1
cjne r1, #10, y
mov r1, #0
inc r2
cjne r2, #6, y
mov r2, #0
inc r3
cjne r3, #10, y
mov r3, #0
inc r4
cjne r4, #6, y
mov r4, #0
y:
reti

start: mov tmod, #01h
MOV TH0, #0xFC
MOV TL0, #0x18
mov P0, #0F0h
setb tr0
SETB ET0
setb ex0
setb IT1
setb p3.7
;clr p3.0
SETB EA
mov b, #0
mov r0, #0 ;used for showing the number
mov r1, #0 ;seconds
mov r2, #0 ;tens of second
mov r3, #0 ;minutes
mov r4, #0 ;tens of minutes
mov r5, #0 ;goes to 12 for time

X:
mov a, r1
mov r0, A
CLR P3.4
CLR P3.3
call display
call delay
mov a, r2
mov r0, A
setb p3.3
call display
call delay
mov a, r3
mov r0, A
setb p3.4
clr p3.3
call display
call delay
mov a, r4
mov r0, A
setb p3.3
call display
call delay
jmp x

Display:
MOV DPTR, #SEGMENT_TABLE
MOV A, R0
MOVC A, @A+DPTR
MOV P1, A
ret

delay:
mov r6, #013h
delay2: mov r7, #010h
djnz r7, $
djnz r6, delay2
call search
ret

search:
	clr f0
	MOV B, #0
	SETB P0.3
	CLR P0.0
	CALL colScan
	JB F0, switch
	SETB P0.0
	CLR P0.1
	CALL colScan
	JB F0, switch
	SETB P0.1
	CLR P0.2
	CALL colScan
	JB F0, switch
	SETB P0.2
	CLR P0.3
	CALL colScan
	JB F0, switch
	ret
switch:
	cpl p3.7
	jnb p3.7, zero
  setb et0
	SETB EA
	jmp start
colScan:
	JNB P0.4, gotKey
	INC B
	JNB P0.5, gotKey
	INC B
	JNB P0.6, gotKey
	INC B
	RET
gotKey:
	SETB F0
	RET
zero:
	clr et0
	clr EA
	jmp x

ORG 0x100
SEGMENT_TABLE: DB 0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90
