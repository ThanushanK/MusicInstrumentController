.include "W:/MusicalController/nios_macros.s"

###################### Interrupt Handler  ##############################
.section .exceptions, "ax"
ISR:

	subi sp, sp, 36 # Save necessary values onto stack
	stw r6, 0(sp)
	stw r12, 4(sp)
	stw r4, 8(sp)
	stw r9, 12(sp)
	stw r11, 16(sp)
	stw et, 20(sp)
	rdctl et, ctl0
	stw et, 24(sp)
	stw ea, 28(sp)
	stw r8, 32(sp)
	
	# Check if Timer caused interrupt
	rdctl et, ctl4 # read ipending
	andi et, et, 0x1 # if irq0 == 1
	bne et, r0, TimerAction
	
	# Check if JTAG UART caused interrupt
	 rdctl et, ctl4 # read ipending
	 andi et, et, 0x100 # if irq8 == 1
	 beq et, r0, exitISR #exit Interrupt Handler

	# Check if PS2 caused interrupt
	# rdctl et, ctl4 # read ipending
	#  andi et, et, 0x80 # if irq7 == 1
	#  beq et, r0, exitISR #exit Interrupt Handler
	

CheckKey:

	movia  r2, JTAGUART2
	ldwio r16, 0(r2) #Get value from keyboard
	andi r16, r16, 0xFF # mask character byte
	movui r2, 'f' 
	beq r16, r2, serveManualTimer
	movui r2, 'g' 
	beq r16, r2, serveTimer
	movui r2, 'a' 
	beq r16, r2, Timer1
	movui r2, 's' 
	beq r16, r2, Timer2
	movui r2, 'd' 
	beq r16, r2, Timer3 
	movui r2, 'j' 
	beq r16, r2, serveGuitar 
	movui r2, 'k'  
	beq r16, r2, Pitch1 
	movui r2, 'l'  
	beq r16, r2, Pitch2 
	movui r2, ';  
	beq r16, r2, Pitch3 
	movui r2, 'i' 
	beq r16, r2, Pitch4 
	movui r2, 'o'  
	beq r16, r2, Pitch5 
	movui r2, 'p'  
	beq r16, r2, Pitch6

	br exitISR

serveManualTimer:
	
	bne r3, r0, exitISR
	
	movi r2, 0x01
	movia r9, ADDR_LCD
	stwio r2, 0(r9)
	movi r2, 0x80
	stwio r2, 0(r9)
	
	subi sp, sp, 32 # Save necessary values onto stack
	stw r2, 0(sp)
	stw r4, 4(sp)
	stw r5, 8(sp)
	stw r6, 12(sp)
	stw r9, 16(sp)
	stw r4, 20(sp)
	stw r1, 24(sp)
	stw r3, 28(sp)
	call TimeManualLCD
	ldw r2, 0(sp)
	ldw r4, 4(sp)
	ldw r5, 8(sp)
	ldw r6, 12(sp)
	ldw r9, 16(sp)
	ldw r4, 20(sp)
	ldw r1, 24(sp)
	ldw r3, 28(sp)
	addi sp, sp, 32
	
	movia r8, ADDR_JP1

	bne r10, r0, downMotion2

upMotion2:
   ldwio r4, 0(r8)
   movia  r9, 0xfffffffe      # enables motor one and drives it backward
   and r6, r17, r9
  movia r9, 0x00000002
   or r4, r9, r6
   mov r17, r4
   stwio  r4, 0(r8)
   movi r10, 0x1
   br resetTimer
downMotion2:

   ldwio r4, 0(r8)
   movia  r9, 0xfffffffc      # enables motor one and drives it forward
   and r6, r17, r9
   mov r17, r6
   stwio  r6, 0(r8)
   movi r10, 0x0
   br resetTimer
	
Timer1:

	beq r3, r0, exitISR
	
	movi r2, 0x01
	movia r9, ADDR_LCD
	stwio r2, 0(r9)
	movi r2, 0x80
	stwio r2, 0(r9)
	
	subi sp, sp, 32 # Save necessary values onto stack
	stw r2, 0(sp)
	stw r4, 4(sp)
	stw r5, 8(sp)
	stw r6, 12(sp)
	stw r9, 16(sp)
	stw r4, 20(sp)
	stw r1, 24(sp)
	stw r3, 28(sp)
	call Period1LCD
	ldw r2, 0(sp)
	ldw r4, 4(sp)
	ldw r5, 8(sp)
	ldw r6, 12(sp)
	ldw r9, 16(sp)
	ldw r4, 20(sp)
	ldw r1, 24(sp)
	ldw r3, 28(sp)
	addi sp, sp, 32
	
	movia r5, 25000000
	#onTimer Action
	movia r9, TIMER #store timer address
	mov r6, r5
	andi r6, r6, 0xFFFF
	stwio r6, 8(r9) # set low
	mov r6, r5
	srli r6, r6, 16
	andi r6, r6, 0xFFFF 
	stwio r6, 12(r9) # set high

	stwio r0, 0(r9) #clear timer
	movui r1, 0x7 # Allow interrupt, continue, and start
	stwio r1, 4(r9)

	br exitISR
Timer2:

	beq r3, r0, exitISR

	movi r2, 0x01
	movia r9, ADDR_LCD
	stwio r2, 0(r9)
	movi r2, 0x80
	stwio r2, 0(r9)
	
	subi sp, sp, 32 # Save necessary values onto stack
	stw r2, 0(sp)
	stw r4, 4(sp)
	stw r5, 8(sp)
	stw r6, 12(sp)
	stw r9, 16(sp)
	stw r4, 20(sp)
	stw r1, 24(sp)
	stw r3, 28(sp)
	call Period2LCD
	ldw r2, 0(sp)
	ldw r4, 4(sp)
	ldw r5, 8(sp)
	ldw r6, 12(sp)
	ldw r9, 16(sp)
	ldw r4, 20(sp)
	ldw r1, 24(sp)
	ldw r3, 28(sp)
	addi sp, sp, 32

	movia r5, 50000000
	#onTimer Action
	movia r9, TIMER #store timer address
	mov r6, r5
	andi r6, r6, 0xFFFF
	stwio r6, 8(r9) # set low
	mov r6, r5
	srli r6, r6, 16
	andi r6, r6, 0xFFFF 
	stwio r6, 12(r9) # set high

	stwio r0, 0(r9) #clear timer
	movui r1, 0x7 # Allow interrupt, continue, and start
	stwio r1, 4(r9)
	
	br exitISR
Timer3:

	beq r3, r0, exitISR
	
	movi r2, 0x01
	movia r9, ADDR_LCD
	stwio r2, 0(r9)
	movi r2, 0x80
	stwio r2, 0(r9)
	
	subi sp, sp, 32 # Save necessary values onto stack
	stw r2, 0(sp)
	stw r4, 4(sp)
	stw r5, 8(sp)
	stw r6, 12(sp)
	stw r9, 16(sp)
	stw r4, 20(sp)
	stw r1, 24(sp)
	stw r3, 28(sp)
	call Period3LCD
	ldw r2, 0(sp)
	ldw r4, 4(sp)
	ldw r5, 8(sp)
	ldw r6, 12(sp)
	ldw r9, 16(sp)
	ldw r4, 20(sp)
	ldw r1, 24(sp)
	ldw r3, 28(sp)
	addi sp, sp, 32
	
	movia r5, 75000000

	#onTimer Action
	movia r9, TIMER #store timer address
	mov r6, r5
	andi r6, r6, 0xFFFF
	stwio r6, 8(r9) # set low
	mov r6, r5
	srli r6, r6, 16
	andi r6, r6, 0xFFFF 
	stwio r6, 12(r9) # set high

	stwio r0, 0(r9) #clear timer
	movui r1, 0x7 # Allow interrupt, continue, and start
	stwio r1, 4(r9)
	br exitISR
		
TimerAction:

	
	movia r9, TIMER #store timer address
	stwio r0, 0(r9) #clear timer
	movui r1, 0x7 # Allow interrupt, continue, and start
	stwio r1, 4(r9)
	
	movia r8, ADDR_JP1

	bne r10, r0, downMotion

upMotion:
  #ldwio r4, 0(r8)
   movia  r9, 0xfffffffe      # enables motor one and drives it backward
   and r6, r17, r9
   movia r9, 0x00000002
   or r2,r6,r9
   mov r17, r2
   stwio  r2, 0(r8)
   movi r10, 0x1
   br resetTimer
downMotion:
   #ldwio r4, 0(r8)
   movia  r9, 0xfffffffc      # enables motor one and drives it forward
   and r6, r17, r9
   mov r17, r6
   stwio  r6, 0(r8)
   movi r10, 0x0


resetTimer:
	
	#onTimer Action
	mov r6, r5
	andi r6, r6, 0xFFFF
	stwio r6, 8(r9) # set low
	mov r6, r5
	srli r6, r6, 16
	andi r6, r6, 0xFFFF 
	stwio r6, 12(r9) # set high

	stwio r0, 0(r9) #clear timer
	movui r1, 0x7 # Allow interrupt, continue, and start
	stwio r1, 4(r9)
	
	
	br exitISR		
		
serveTimer:

	movia et, TIMER
	stwio r0, 0(et) #clear timer
	movui r1, 0x7 # Allow interrupt, continue, and start
	stwio r1, 4(et)


	bne r3, r0, offTimer

onTimer:
	movui et, ' '
	stwio et, 0(r2)	
	movui et, 'O'
	stwio et, 0(r2)
	movui et, 'N'
	stwio et, 0(r2)
	
	movi r2, 0x01
	movia r9, ADDR_LCD
	stwio r2, 0(r9)
	movi r2, 0x80
	stwio r2, 0(r9)
	
    subi sp, sp, 32 # Save necessary values onto stack
	stw r2, 0(sp)
	stw r4, 4(sp)
	stw r5, 8(sp)
	stw r6, 12(sp)
	stw r9, 16(sp)
	stw r4, 20(sp)
	stw r1, 24(sp)
	stw r3, 28(sp)
	call TimerOnLCD
	ldw r2, 0(sp)
	ldw r4, 4(sp)
	ldw r5, 8(sp)
	ldw r6, 12(sp)
	ldw r9, 16(sp)
	ldw r4, 20(sp)
	ldw r1, 24(sp)
	ldw r3, 28(sp)
	addi sp, sp, 32
	
	movi r3,0x1 # Set timer back to on

	#onTimer Action
	movia r9, TIMER #store timer address
	mov r6, r5
	andi r6, r6, 0xFFFF
	stwio r6, 8(r9) # set low
	mov r6, r5
	srli r6, r6, 16
	andi r6, r6, 0xFFFF 
	stwio r6, 12(r9) # set high

	stwio r0, 0(r9) #clear timer
	movui r1, 0x7 # Allow interrupt, continue, and start
	stwio r1, 4(r9)

	br exitISR
	
offTimer:
	movui et, ' '
	stwio et, 0(r2)	
	movui et, 'O'
	stwio et, 0(r2)
	movui et, 'F'
	stwio et, 0(r2)
	movui et, 'F'
	stwio et, 0(r2)

	movi r2, 0x01
	movia r9, ADDR_LCD
	stwio r2, 0(r9)
	movi r2, 0x80
	stwio r2, 0(r9)
	
	subi sp, sp, 32 # Save necessary values onto stack
	stw r2, 0(sp)
	stw r4, 4(sp)
	stw r5, 8(sp)
	stw r6, 12(sp)
	stw r9, 16(sp)
	stw r4, 20(sp)
	stw r1, 24(sp)
	stw r3, 28(sp)
	call TimerOffLCD
	ldw r2, 0(sp)
	ldw r4, 4(sp)
	ldw r5, 8(sp)
	ldw r6, 12(sp)
	ldw r9, 16(sp)
	ldw r4, 20(sp)
	ldw r1, 24(sp)
	ldw r3, 28(sp)
	addi sp, sp, 32
	 
	movi r3, 0x0 # Set timer back to off


	# offTimer Action
	movia r9, TIMER 
	stwio r0, 0(r9) #clear timer completely
	stwio r0, 4(r9)

	br exitISR

serveGuitar:
	
	movi r2, 0x01
	movia r9, ADDR_LCD
	stwio r2, 0(r9)
	movi r2, 0x80
	stwio r2, 0(r9)
	
	subi sp, sp, 32 # Save necessary values onto stack
	stw r2, 0(sp)
	stw r4, 4(sp)
	stw r5, 8(sp)
	stw r6, 12(sp)
	stw r9, 16(sp)
	stw r4, 20(sp)
	stw r1, 24(sp)
	stw r3, 28(sp)
	call strumLCD
	ldw r2, 0(sp)
	ldw r4, 4(sp)
	ldw r5, 8(sp)
	ldw r6, 12(sp)
	ldw r9, 16(sp)
	ldw r4, 20(sp)
	ldw r1, 24(sp)
	ldw r3, 28(sp)
	addi sp, sp, 32


	
movia r8, ADDR_JP1
moveMotor:
	beq r7, r0, moveLeft      #MOVE MOTOR based on r7

moveRight: 
   	ldwio r4, 0(r8)
	movia  r9, 0xfffffffb      # enables motor one and drives it forward
	and r6, r17, r9	
	movia r9, 0x00000008
	or r4, r6, r9
	mov r17, r4
  	stwio  r4, 0(r8)	
	br exitISR
 
moveLeft: 
   ldwio r4, 0(r8)
   movia  r9, 0xfffffff3      # enables motor one and drives it backward
   and r6, r17, r9
   mov r17, r6
   stwio  r6, 0(r8)
   br exitISR


Pitch1:

	movi r2, 0x01
	movia r9, ADDR_LCD
	stwio r2, 0(r9)
	movi r2, 0x80
	stwio r2, 0(r9)
	
	subi sp, sp, 32 # Save necessary values onto stack
	stw r2, 0(sp)
	stw r4, 4(sp)
	stw r5, 8(sp)
	stw r6, 12(sp)
	stw r9, 16(sp)
	stw r4, 20(sp)
	stw r1, 24(sp)
	stw r3, 28(sp)
	call pitch1LCD
	ldw r2, 0(sp)
	ldw r4, 4(sp)
	ldw r5, 8(sp)
	ldw r6, 12(sp)
	ldw r9, 16(sp)
	ldw r4, 20(sp)
	ldw r1, 24(sp)
	ldw r3, 28(sp)
	addi sp, sp, 32

	subi r15, r13, 1
	movi r13, 1
	
	br pitchHandler

Pitch2:

	movi r2, 0x01
	movia r9, ADDR_LCD
	stwio r2, 0(r9)
	movi r2, 0x80
	stwio r2, 0(r9)
	
	subi sp, sp, 32 # Save necessary values onto stack
	stw r2, 0(sp)
	stw r4, 4(sp)
	stw r5, 8(sp)
	stw r6, 12(sp)
	stw r9, 16(sp)
	stw r4, 20(sp)
	stw r1, 24(sp)
	stw r3, 28(sp)
	call pitch2LCD
	ldw r2, 0(sp)
	ldw r4, 4(sp)
	ldw r5, 8(sp)
	ldw r6, 12(sp)
	ldw r9, 16(sp)
	ldw r4, 20(sp)
	ldw r1, 24(sp)
	ldw r3, 28(sp)
	addi sp, sp, 32
		
	
	subi r15, r13, 2
	movi r13, 2
	
	br pitchHandler

Pitch3:
	

	movi r2, 0x01
	movia r9, ADDR_LCD
	stwio r2, 0(r9)
	movi r2, 0x80
	stwio r2, 0(r9)
	
	subi sp, sp, 32 # Save necessary values onto stack
	stw r2, 0(sp)
	stw r4, 4(sp)
	stw r5, 8(sp)
	stw r6, 12(sp)
	stw r9, 16(sp)
	stw r4, 20(sp)
	stw r1, 24(sp)
	stw r3, 28(sp)
	call pitch3LCD
	ldw r2, 0(sp)
	ldw r4, 4(sp)
	ldw r5, 8(sp)
	ldw r6, 12(sp)
	ldw r9, 16(sp)
	ldw r4, 20(sp)
	ldw r1, 24(sp)
	ldw r3, 28(sp)
	addi sp, sp, 32
	

	subi r15, r13, 3
	movi r13, 3
	
	br pitchHandler
	
Pitch4:

	movi r2, 0x01
	movia r9, ADDR_LCD
	stwio r2, 0(r9)
	movi r2, 0x80
	stwio r2, 0(r9)
	
	subi sp, sp, 32 # Save necessary values onto stack
	stw r2, 0(sp)
	stw r4, 4(sp)
	stw r5, 8(sp)
	stw r6, 12(sp)
	stw r9, 16(sp)
	stw r4, 20(sp)
	stw r1, 24(sp)
	stw r3, 28(sp)
	call pitch4LCD
	ldw r2, 0(sp)
	ldw r4, 4(sp)
	ldw r5, 8(sp)
	ldw r6, 12(sp)
	ldw r9, 16(sp)
	ldw r4, 20(sp)
	ldw r1, 24(sp)
	ldw r3, 28(sp)
	addi sp, sp, 32

	subi r15, r13, 4
	movi r13, 4
	
	br pitchHandler
	
Pitch5:

	movi r2, 0x01
	movia r9, ADDR_LCD
	stwio r2, 0(r9)
	movi r2, 0x80
	stwio r2, 0(r9)
	
	subi sp, sp, 32 # Save necessary values onto stack
	stw r2, 0(sp)
	stw r4, 4(sp)
	stw r5, 8(sp)
	stw r6, 12(sp)
	stw r9, 16(sp)
	stw r4, 20(sp)
	stw r1, 24(sp)
	stw r3, 28(sp)
	call pitch5LCD
	ldw r2, 0(sp)
	ldw r4, 4(sp)
	ldw r5, 8(sp)
	ldw r6, 12(sp)
	ldw r9, 16(sp)
	ldw r4, 20(sp)
	ldw r1, 24(sp)
	ldw r3, 28(sp)
	addi sp, sp, 32

	subi r15, r13, 5
	movi r13, 5
	
	br pitchHandler
	
Pitch6:

	movi r2, 0x01
	movia r9, ADDR_LCD
	stwio r2, 0(r9)
	movi r2, 0x80
	stwio r2, 0(r9)
	
	subi sp, sp, 32 # Save necessary values onto stack
	stw r2, 0(sp)
	stw r4, 4(sp)
	stw r5, 8(sp)
	stw r6, 12(sp)
	stw r9, 16(sp)
	stw r4, 20(sp)
	stw r1, 24(sp)
	stw r3, 28(sp)
	call pitch6LCD
	ldw r2, 0(sp)
	ldw r4, 4(sp)
	ldw r5, 8(sp)
	ldw r6, 12(sp)
	ldw r9, 16(sp)
	ldw r4, 20(sp)
	ldw r1, 24(sp)
	ldw r3, 28(sp)
	addi sp, sp, 32

	subi r15, r13, 6
	movi r13, 6
	
	br pitchHandler
	
pitchHandler:
	#muli r15, r15, 2
	movi r16, 0
	beq r15, r0, exitISR
	blt r15, r0, toHigherPitch

toLowerPitch:
   	ldwio r4, 0(r8)
	movia  r9, 0xffffffef      # enables motor one and drives it forward
	and r6, r17, r9	
	movia r9, 0x00000020
	or r4, r6, r9
  	stwio  r4, 0(r8)
	mov r17, r4
	br exitISR

toHigherPitch:
	muli r15, r15, -1
	
	ldwio r4, 0(r8)
	movia  r9, 0xffffffcf      # enables motor one and drives it forward
	and r6, r17, r9	
	mov r17, r6
  	stwio  r6, 0(r8)
	br exitISR
	
exitISR:

	movia r2, ADDR_REDLEDS
	mov r9, r17
	srli r9, r9, 10
	andi r9, r9, 0x3F
	stwio r9, 0(r2)
	
	movia r2, ADDR_GREENLEDS
	mov r9, r17
	andi r9, r9, 0x3F
	stwio r9, 0(r2)
	
	ldw r6, 0(sp)
	ldw r12, 4(sp)
	ldw r4, 8(sp)
	ldw r9, 12(sp)
	ldw r11, 16(sp)
	ldw et,20(sp) # Restore all values form stack
	ldw r2, 24(sp)
	wrctl ctl0, r2 #set interrupts back on PIE = 1
	ldw ea, 28(sp)
	ldw r8, 32(sp)
	addi sp, sp, 36
	
	subi ea, ea, 4 # Returns back to original line where interrupt occured
	eret
#########################################################################

.section .data
.equ spStart, 0x800000 
.equ TIMER, 0x10002000
.equ JTAGUART2, 0x10001000
.equ PS2, 0x10000100
.equ ADDR_JP1, 0x10000060
.equ ADDR_REDLEDS, 0x10000000
.equ ADDR_GREENLEDS, 0x10000010
.equ ADDR_LCD, 0x10003050

.section .text

/*

 r3: if timer on or off
 r5: timer periods
 r7: position of pick (1 if on sensor0 & 0 if on sensor1)
 r10: up/down direction for timer
 r11: touch sensor value
 r12: which sensor to check vald bit for
 r13: Current Pitch Value
 r14: color(Black or White)
 r16: counter for pitch
 r17: global register for Lego Controller

*/

.global main
main:

################  ENABLE INTERRUPTS  ############################
	
	movia sp, spStart #set start of stack
	movia r5, 50000000
	movia r8, ADDR_JP1
	movi r11, 0xD
	movia r9, 0x07f557ff          # set direction (input/output) for all sensors and motors
	stwio r9, 4(r8)

	movia r17, 0xFFFFFFFF
	stwio r17, 0(r8)

	#Enable Terminal
	movia r9, JTAGUART2
	movi r4, 0x11 # Enabling read interrupts
	stwio r4, 4(r9)

	#Enable PS/2
	#movia r9, PS2
	#movi r4, 0x1
	#stwio r1, 4(r9)

	#Enable interrupts using ienable
	movi r4, 0x101 #bit 1 and bit 8 enabled (PS2 and TIMER)
	wrctl ctl3, r4

	#enable PIE
	movi r4, 0b1
	wrctl ctl0, r4

	movi r3, 0x0 
	movi r10, 0x0 

	movi r7, 0x0
	movi r13, 1
	movi r14, 0x0
#################################################################

loop:

	movia r2, ADDR_REDLEDS
	mov r9, r17
	srli r9, r9, 10
	andi r9, r9, 0x3F
	stwio r9, 0(r2)
	
	movia r2, ADDR_GREENLEDS
	mov r9, r17
	andi r9, r9, 0x3F
	stwio r9, 0(r2)

lightAction:
	movia r18, 0xfffffc00
	or r17, r17, r18
	movia r18, 0xffffbfff      # enable sensor 0
	and r17, r17, r18
	stwio  r17, 0(r8)

	ldwio  r4,  0(r8)
	srli r4,  r4, 15          # bit 15 equals valid bit for sensor 2           
	andi   r4,  r4,0x1	
	bne r0, r4, lightAction   

	ldwio  r9, 0(r8)           # read sensor 0 value (into r7) 
    srli   r9, r9, 27          # shift to the right by 27 bits so that 4-bit sensor value is in lower 
    andi   r9, r9, 0x0f	

	beq r14, r0, checkBlack

checkWhite:	
	movi r4, 0x4
	blt r9, r4, count
	br donePitchSensor
	
checkBlack:
	movi r4, 0x8
	bgt r9, r4, count
	br donePitchSensor

count:
	addi r16, r16, 1
	xori r14, r14, 0b1
	andi r14, r14, 0x0001
	bne r16, r15, donePitchSensor


stopMotorPitch:	

	ldwio r4, 0(r8)
	movia  r9, 0x00000010      # enables motor 1 and drives it backward
   	or r2, r4, r9
	mov r17, r2
	stwio r2, 0(r8)
donePitchSensor:

	beq r7, r0, tSensor2	

tSensor1:

	movia r18, 0xfffffc00
	or r17, r17, r18
	movia r18, 0xfffffbff      # enable sensor 0
	and r17, r17, r18	

	movi r12, 11
	br touchAction
	
tSensor2:
	movia r18, 0xfffffc00
	or r17, r17, r18
	movia  r18, 0xffffefff      # enable sensor 1
	and r17, r17, r18

	movi r12, 13		

touchAction:	

	stwio  r17, 0(r8)     


	ldwio  r4,  0(r8)          # checking for valid data sensor 0
	srl r4,  r4,r12          # bit 11 equals valid bit for sensor 0           
	andi   r4,  r4,0x1	
	bne r0, r4, touchAction   
	
   	ldwio  r9, 0(r8)           # read sensor 0 value (into r7) 
   	srli   r9, r9, 27          # shift to the right by 27 bits so that 4-bit sensor value is in lower 
   	andi   r9, r9, 0x0f	
   
	blt	r9, r11, stopMotor     # If Touch Sensor detects something branch to stopMotor, else br loop
	br loop
  
stopMotor:		
	
	xori r7, r7, 0b1
	andi r7, r7, 0x0001
	
	ldwio r4, 0(r8)
	movia  r9, 0x00000004      # enables motor 1 and drives it backward
   	or r6, r4, r9
	mov r17, r6
	stwio r6, 0(r8)
	
	br loop