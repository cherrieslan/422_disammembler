*****************************
*
*
* 
*
* Test program
*
*****************************

start		EQU	$00007000	* ORG and END address

* ORG the program so that it straddles the address boundary $00007FFF to $00008000

		ORG	start

* NOP and similar instructions. Should clearly differentiate NOP and RTS from others.

		NOP			*Required
		RTS			*Required
		STOP	#$2000  	* Not required instruction
		
* 0000
		ORI             #1,CCR                       
		ORI             #1,SR                        
		ORI.L           #$4455FF,D5
		ANDI            #1,CCR                       
		ANDI            #1,SR                        
		ANDI.L          #$4455FF,D5                    
		SUBI.L          #$4455FF,D5
		  
		ADDI.L          #$08FF,D5
		ADDI.W          #$4E71,D1
                ADDI.W	        #$5555,D6
                ADDI.W          #$4E71,D1
                ADDI.W	        #$5555,D6
                ADDI.B          #$22,D1                         
                ADDI.L          #$34FEEF43,D2
		
                EORI.L          #$4455FF,D5
		EORI            #1,CCR
		CMPI.L          #$4455FF,D5
		BTST.L          #$4455FF,D5
		BCHG.L          #$4455FF,D5
		BCLR.L          #$4455FF,D5
		BSET.L          #$4455FF,D5
		MOVEP.L         D5,$20(A2)
		MOVEA.L         D4,A5   
		MOVE.L          D4,D5

*0100                   
                MOVE            SR,D5
                MOVE            SR,(2, a6)
                MOVE            SR,$0000ffff
                MOVE            SR,$1234
                
                MOVE            D5,SR
		MOVE            $5555,SR
		MOVE            $12345678, SR
		MOVE            #$5678,sR
		
		MOVE            D5,CCR
		MOVE            $5555,CCR
		MOVE            $12345678,CCR
		MOVE            #$5678,CCR
		
		MOVEM.L         D0-D3/D5/A3-A5, -(SP)
		movem.l         a3, -(sp)
		MOVEM.w         (SP)+, D0-D3/D5/A3-A5
		
                NEGX.L          D5
		CLR.L           D5
		NEG.L           D5             
		NOT.L           D5
		EXT.L           D5
		NBCD            D5
		SWAP            D5
		PEA             (A5)
		ILLEGAL
		TAS             D5
		TST.L           D5
		TRAP            #15
		LINK            A4,#4
		UNLK            A4
		MOVE            USP,A4
		RESET
		NOP
		STOP            #4455
		RTE
		RTS
		TRAPV
		RTR
		JSR             clear
		JMP             clear 
		MOVEM.L         D0-D3/A0-A3,-(SP)
		LEA             (A4),A5
		CHK.W           D4,D5
		
*0101
		ADDQ            #8,D5
		ADDQ            #1,D5
		ADDQ            #2,D5
		ADDQ            #3,D5
		ADDQ            #4,D5
		ADDQ            #5,D5
		ADDQ            #6,D5
		ADDQ            #7,D5
		SUBQ.L          #8,D5
		SCC             D5
		DBCC            D5,clear

*0110
                BCC             clear
		BRA             clear
		BSR             clear
		
*0111
		MOVEQ           #1,D4
		
*1000
		DIVU            D4,D5
		DIVS            D4,D5
		SBCD            -(A4),-(A5)    
		OR.L            D4,D5
		
*1001
		SUB.L           D4,D5
		SUBX.L          -(A4),-(A5)
		SUBA.L          D4,A5
		
*1011
		EOR.L           D4,D5
		CMPM.L          (A4)+,(A5)+
		CMP.L           D4,D5
		CMPA.L          $12345000, A5
		CMPA.L          $5000, A5
		CMPA.L          #$5000, A5
		CMPA.L          D5,A5
		
*1100
		MULU            D4,D5
		MULU            #$FFFF,D5
		MULS            D4,D5
		ABCD            -(A3),-(A4)
		EXG             A3,A4
		AND             D4,D5
	
*1101
		ADD             D4,D5
		ADDX.L          -(A3),-(A4)
		ADDA            D4,A5
		
*1110
		ASR.L           #4,D5
		ASL.L           #4,D5
		LSR.L           #4,D5
		LSL.L           #4,D5
		ROXR.L          #4,D5
		ROXL.L          #4,D5
		ROR.L           #4,D5
		ROL.L           #4,D5
		ASR.W           $00FF0000
		ASL.W           $00FF0000
		LSR.W           $00FF0000
		LSL.W           $00FF0000
		ROXR.W          $00FF0000
		ROXL.W          $00FF0000
		ROR.W           $00FF0000
		ROL.W           $00FF0000
		
		
		        

* This is a group of ADD instructions
    
                movem.l         d0-d3/D5/a3-a5, -(sp)
                movem.l        (sp)+, d0-d5/a3-a5
                movem.w         d1-d3, -(sp)
                movem.w        (sp)+, d1-d3
                movem.w         a0, -(sp)
                movem.w        (sp)+, a0
                
clear		CLR	(1,a2)
                CLR     -(A1)
                CLR     (A1)+
                CLR     (A1)
                CLR.B	D4 
                CLR.B   -(A1)
                CLR.B   (A1)+
                CLR.B   (A1)
                CLR.B   $99
                CLR.W	D4
                CLR.W   -(A1)
                CLR.W   (A1)+
                CLR.W   (A1)
                CLR.W   $99
                CLR.L	D4
                CLR.L   -(A1)
                CLR.L   (A1)+
                CLR.L   (A1)
                CLR.L   $99FF
                CLR.L   $11111111
                CLR.L   $8888FFFF
 
                ADD.W   D1,D2	
                
                
                ADD.B   D5,$15
                ADD.B   D4,$13
                ADD.B   $12,D5                        
                ADD.B   D5,D4
                ADD.B   $9100,D5
                ADD.W   $CD45,D5
                ADD.L   $1FF0,D5
                ADD.L   $9001FF,D5
                ADD.W   $255E,D5
                
                ADDA.W  $45AE,A4
                ADDA.L  $A20FEB,A4
                
                ADDQ.B  #$7,D5
                ADDQ.B  #7,(A4)
                ADDQ.B  #7,(A4)+
                ADDQ.B  #7,-(A4)
                ADDQ.B  #7,$7700
                ADDQ.B  #7,$F0000
                
                ADDQ.W  #7,D5
                ADDQ.W  #7,(A4)
                ADDQ.W  #7,(A4)+
                ADDQ.W  #7,-(A4)
                ADDQ.W  #7,$7700
                ADDQ.W  #7,$F0000
                
                ADDQ.L  #7,D5
                ADDQ.L  #7,(A4)
                ADDQ.L  #7,(A4)+
                ADDQ.L  #7,-(A4)
                ADDQ.L  #7,$7700
                ADDQ.L  #7,$F0000
                
		
* This is a group of SUB instructions
subtracts	SUBA.W	(A4),A6
                SUB.B   D5,$20
                SUB.W   D5,$811F
                SUB.L   D5,$1FFA44F
                
* Group is random data

data1		DC.B		$FF,$AA,$45,$0A

* Move instructions

moves		MOVE.B	D0,D1
                MOVE.B  (A4),D2
                MOVE.B  -(A4),D2
                MOVE.B  (A4)+,D2
                MOVE.B  #$80,D2
                MOVE.B  #$88,D2         need to fix
                MOVE.B  $7800,D2        need to fix
                MOVE.B  $F100,D2
                MOVE.B  (A4),$E0000
                        
                MOVE.W	D0,D1
                MOVE.W  (A4),D2
                MOVE.W  -(A4),D2
                MOVE.W  (A4)+,D2
                MOVE.W  #$80,D2
                MOVE.W  #$88,D2
                MOVE.W  $7800,D2
                MOVE.W  $F100,D2
                MOVE.W  A4,(A4)
                MOVE.W  A4,-(A4)
                MOVE.W  A4,(A4)+
                MOVE.W  (A4),$E0000
                
                MOVE.L	D0,D1
                MOVE.L  (A4),D2
                MOVE.L  -(A4),D2
                MOVE.L  (A4)+,D2
                MOVE.L  #$80,D2
                MOVE.L  #12,D2
                MOVE.L  $78,D2
                MOVE.L  $F100,D2
                MOVE.L  $1234DDCC,D2
                MOVE.L  A4,(A4)
                MOVE.L  A4,-(A4)
                MOVE.L  A4,(A4)+
                MOVE.L  (A4),$E0000
                
                MOVEA.W D3,A4
                MOVEA.W A1,A4
                MOVEA.W (A1),A4
                MOVEA.W (A1)+,A1
                MOVEA.W -(A1),A2
                MOVEA.W $EF00,A4
                MOVEA.W #$1234,A4
                MOVEA.W #05,A4
                
                MOVEA.L D3,A4
                MOVEA.L A1,A4
                MOVEA.L (A1),A4
                MOVEA.L (A1)+,A4
                MOVEA.L -(A1),A4
                MOVEA.L $EF00,A4
                MOVEA.L #$12345678,A4
                MOVEA.L #$1234,A4
                MOVEA.L #05,A4
                
                MOVEQ   #$1F,D3
                MOVEQ   #$8,D3
                MOVEQ   #80,D3                  need to fix
                MOVEQ   #%10001111,D3
                

data5		DC.B	'Here is some interspersed data'
		
* Divide and multiple optional instructions
	
ands		AND.B	#$01,$4568
                AND.W   #$0143,$4568
                AND.L   #$01FED,$4568
shifts		ASL.B	D0,D0
                ASL.W   D2,D0
                ASL.L   #6,D0
                ASL     $00FF0000
                ASL     (A0)+
                ASL     -(A0)     
                
                ASR.B   D0,D0
                ASR.W   D2,D0
                ASR.L   #6,D0
                ASR     $00FF0000
                ASR     (A0)+
                ASR     -(A0) 
               
                LSL.B   D0,D0
                LSL.W   D2,D0
                LSL.L   #6,D0
                LSL     $00FF0000
                LSL     (A0)+
                LSL     -(A0) 
                
                LSR.B   D0,D0
                LSR.W   D2,D0
                LSR.L   #6,D0
                LSR     $00FF0000
                LSR     (A0)+
                LSR     -(A0) 

rolls		ROL.L	D2,D3
                ROL.B   D1,D3
                ROL.W   #2,D3
                ROL     $00FF0000
                ROL     (A0)+
                ROL     -(A0) 
                
                ROR.L	D2,D3
                ROR.B   D1,D3
                ROR.W   #2,D3
                ROR     $00FF0000
                ROR     (A0)+
                ROR     -(A0) 




load_addr	LEA	$DC00FF00,A2
                LEA     $8000,A1
                LEA     (A1),A3

* random data	
		DC.W	2949,0411,2848,7869

compares	CMP.B	(A3),D5  
                CMP.W   $2000,D5
                CMP.L   #$FFEEDD,D5


* Branches	
		

* Jump and branch instructions

jmplabel	BCC	compares		
		BGT	compares		
		BLE	compares	
		JSR	(A3)		* Address register indirect
		BCC	clear		
		JSR     $7900
		JSR     $FF500
		
*These are not required instructions
multiply	MULS	D0,D3
		DIVU	(A3),D5	*Optional instruction
		MULS	D0,D3		*Optional instruction
		MULS	(A6),D0		*Optional instruction
		MULS	#$4567,D1	*Optional instruction
		DIVU	(A3)+,D5	*Optional instruction
		NOP
		NOP
		SUB.L	D2,D4
		SUB.L	(A3),D7
		OR      D0,D1
		

		END	start


























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~8~
