$mod842

jmp st

org 03h
jmp bcl

org 053H
jnb f1, y
inc R1
mov sec, #0
cjne R1, #16h, y
mov R1, #10h
inc r2
cjne R2, #6ah, y
mov r2, #60h
cpl f0
inc r3
cjne R3, #36h, y
mov r3, #30h
inc r4
cjne r4, #4, z
cjne r4, #10, y
mov R4, #0
inc r5

y: reti


z: cjne r5, #12h, y
mov r4, #0
mov r5, #10h
jmp y

bcl: 
cpl f1
jnb f1, lo
mov timecon, #01000011B
mov r6, #0ffh
dela: mov r7, #0ffh
djnz r7, $
djnz r6, dela
jmp y

lo:
mov timecon, #01000010B
mov r6, #0ffh
dela2: mov r7, #0ffh
djnz r7, $
djnz r6, dela2
jmp y


st: mov timecon, #01000011B
mov IE, #081H
mov IEIP2, #0ffh
mov intval, #10
mov sec, #0
mov R1, #10h
mov R2, #60h
mov R3, #30h
mov R4, #0
mov R5, #10h
setb f0
setb f1

x: jnb f0, wysgodz
mov P2, sec
mov R0, #0ffh
djnz r0, $
mov p2, R1
mov R0, #0ffh
djnz r0, $
mov p2, r2
mov R0, #0ffh
djnz r0, $
mov p2, r3
mov R0, #0ffh
djnz r0, $
jmp x

wysgodz:
jb f0, x
mov P2, R4
mov R0, #0ffh
djnz r0, $
mov p2, r5
mov R0, #0ffh
djnz r0, $
jmp wysgodz



end