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
                ORI.B           #1,D1
                ORI.W           #$1234,D1
                ORI.L           #$AABB1234,D1
                ORI.B           #1,(A3)
                ORI.W           #$1234,(A3)
		ORI.L           #$4455FF,(A3)
		ORI.B           #1,(A4)+
		ORI.W           #$1234,(A4)+
		ORI.L           #$ABABABAB,(A4)+
                ORI.B           #1,-(A5)
                ORI.W           #$1234,-(A5)
		ORI.L           #$1234CCDD,-(A5)		
		ORI.W           #$1234,$1234
		ORI.L           #$1234ABCD,$1234
		
		ANDI            #1,CCR                       
		ANDI            #1,SR
                ANDI.B          #1,D1
                ANDI.W          #$1234,D1   
                ANDI.B          #1,D1
                ANDI.L          #$1234,D1                 
                ANDI.L          #$AABB1234,D1
                ANDI.B          #1,(A3)
                ANDI.W          #$1234,(A3)
                ANDI.L          #$11AABBCC,(A3)
                ANDI.B          #1,(A4)+
                ANDI.W          #$1234,(A4)+
                ANDI.L          #$1234ABCD,(A4)+
		ANDI.B          #1,-(A5)
		ANDI.W          #$1234,-(A5)
		ANDI.L          #$1234ABCD,-(A5)
		ANDI.W          #$1234,$1234
		ANDI.L          #$1234ABCD,$1234
                        
		SUBI.B          #1,D1
		SUBI.W          #$1234,D1
		SUBI.L          #$1234ABCD,D1
		SUBI.B          #1,(A3)
		SUBI.W          #$1234,(A3)
                SUBI.L          #$11AABBCC,(A3)
                SUBI.B          #1,(A4)+
                SUBI.W          #$1234,(A4)+
                SUBI.L          #$1234ABCD,(A4)+
                SUBI.B          #1,-(A5)
                SUBI.W          #$1234,-(A5)
		SUBI.L          #$1234ABCD,-(A5)
		SUBI.W          #$1234,$1234
		SUBI.L          #$1234ABCD,$1234ABCD
		
		ADDI.B          #1,D1
		ADDI.W          #$1234,D1
		ADDI.L          #$12345678,D1
		ADDI.B          #1,(A3)
		ADDI.W          #$11AA,(A3)
                ADDI.L          #$11AABBCC,(A3)
                ADDI.B          #1,(A4)+
                ADDI.W          #$1234,(A4)+
                ADDI.L          #$1234ABCD,(A4)+
                ADDI.B          #1,-(A5)
                ADDI.W          #$1234,-(A5)
		ADDI.L          #$1234ABCD,-(A5)
		ADDI.W          #$1234,$1234
		ADDI.L          #$1234ABCD,$1234
		
                EORI            #1,CCR                       
		EORI            #1,SR
                EORI.B          #1,D1
		EORI.W          #$1234,D1
		EORI.L          #$12345678,D1
		EORI.B          #1,(A3)
		EORI.W          #$11AA,(A3)
                EORI.L          #$11AABBCC,(A3)
                EORI.B          #1,(A4)+
                EORI.W          #$1234,(A4)+
                EORI.L          #$1234ABCD,(A4)+
                EORI.B          #1,-(A5)
                EORI.W          #$1234,-(A5)
		EORI.L          #$1234ABCD,-(A5)
		EORI.W          #$1234,$1234
		EORI.L          #$1234ABCD,$1234
                
		CMPI.B          #1,D1
		CMPI.W          #$1234,D1
		CMPI.L          #$12345678,D1
		CMPI.B          #1,(A3)
		CMPI.W          #$11AA,(A3)
                CMPI.L          #$11AABBCC,(A3)
                CMPI.B          #1,(A4)+
                CMPI.W          #$1234,(A4)+
                CMPI.L          #$1234ABCD,(A4)+
                CMPI.B          #1,-(A5)
                CMPI.W          #$1234,-(A5)
		CMPI.L          #$1234ABCD,-(A5)
		CMPI.W          #$1234,$1234
		CMPI.L          #$1234ABCD,$1234
				
		BTST.L          #$12345678,D1
		BTST.B          #1,(A3)
                BTST.B          #1,(A4)+
                BTST.B          #1,-(A5)
		BTST.B          #$1234,$1234
		BTST.B          #$1234ABCD,$1234
		BTST.B          #1,$1234
		BTST.B          #$1234,$1234
		BTST.B          #$1234ABCD,$1234
		BTST.B          #$1234,#$12
		
		BTST.L          D1,D1
		BTST.B          D1,(A3)
                BTST.B          D1,(A4)+
                BTST.B          D1,-(A5)
		BTST.B          D1,$1234
		BTST.B          D1,#$12
                
                BCHG.L          #$12345678,D1
		BCHG.B          #1,(A3)
                BCHG.B          #1,(A4)+
                BCHG.B          #1,-(A5)
		BCHG.B          #$1234,$1234
		BCHG.B          #$1234ABCD,$1234
		BCHG.B          #1,$1234
		BCHG.B          #$1234,$1234
		BCHG.B          #$1234ABCD,$1234
		
		BCHG.L          D1,D1
		BCHG.B          D1,(A3)
                BCHG.B          D1,(A4)+
                BCHG.B          D1,-(A5)
		BCHG.B          D1,$1234

                BCLR.L          #$12345678,D1
		BCLR.B          #1,(A3)
                BCLR.B          #1,(A4)+
                BCLR.B          #1,-(A5)
		BCLR.B          #$1234,$1234
		BCLR.B          #$1234ABCD,$1234
		BCLR.B          #1,$1234
		BCLR.B          #$1234,$1234
		BCLR.B          #$1234ABCD,$1234
		
		BCLR.L          D1,D1
		BCLR.B          D1,(A3)
                BCLR.B          D1,(A4)+
                BCLR.B          D1,-(A5)
		BCLR.B          D1,$1234
		
                BSET.L          #$12345678,D1
		BSET.B          #1,(A3)
                BSET.B          #1,(A4)+
                BSET.B          #1,-(A5)
		BSET.B          #$1234,$1234
		BSET.B          #$1234ABCD,$1234
		BSET.B          #1,$1234
		BSET.B          #$1234,$1234
		BSET.B          #$1234ABCD,$1234
		
		BSET.L          D1,D1
		BSET.B          D1,(A3)
                BSET.B          D1,(A4)+
                BSET.B          D1,-(A5)
		BSET.B          D1,$1234
		
		MOVEP.L         D1,$20(A2)
		MOVEP.W         $6789(A2),D2
		
		MOVEA.W         D1,A2
                MOVEA.L         D1,A2
                MOVEA.W         A1,A2
                MOVEA.L         A1,A2
                MOVEA.W         (A1),A2
                MOVEA.L         (A1),A2
                MOVEA.W         (A1)+,A2
                MOVEA.L         (A1)+,A2
                MOVEA.W         -(A1),A2
                MOVEA.L         -(A1),A2
                MOVEA.W         #$1234,A2
                MOVEA.L         #$1234ABCD,A2
                MOVEA.W         #1234,A2

                MOVE.B          #1,D1           ******MORE MOVE TEST
                MOVE.W          #$1234,A2
                MOVE.L          #$11AABBCC,(A3)
                MOVE.B          #1,(A4)+
		MOVE.W          #$1234,-(A5)
		MOVE.L          #$1234ABCD,$1234
		MOVE.L          #$1234ABCD,$1234ABCD


*0100                   
                MOVE            SR,D5
                MOVE            SR,(A1)
                MOVE            SR,(A1)+
                MOVE            SR,-(A1)
                MOVE            SR,(2,A6)
                MOVE            SR,$0000FFFF
                MOVE            SR,$1234
                
                MOVE            D5,SR
		MOVE            $5555,SR
		MOVE            $12345678, SR
		MOVE            #$5678,SR
		
		MOVE            D5,CCR
		MOVE            (A1),CCR
		MOVE            (A1)+,CCR
		MOVE            -(A1),CCR
		MOVE            $5555,CCR
		MOVE            $12345678,CCR
		MOVE            #$5678,CCR
		
		MOVEM.L         D0-D3/D5/A3-A5, -(SP)      *****MORE MOVEM TEST
		MOVEM.L         A3, -(SP)
		MOVEM.W         (SP)+, D0-D3/D5/A3-A5
		
		NEGX.B          D5
                NEGX.B          (A1)
                NEGX.B          (A1)+
                NEGX.B          -(A1)
		NEGX.W          D5
                NEGX.W          (A1)
                NEGX.W          (A1)+
                NEGX.W          -(A1)                
                NEGX.L          D5
                NEGX.L          (A1)
                NEGX.L          (A1)+
                NEGX.L          -(A1)
                NEGX.L          $1234
                NEGX.L          $1234ABCD
                
		CLR.B           D5
                CLR.B           (A1)
                CLR.B           (A1)+
                CLR.B           -(A1)
		CLR.W           D5
                CLR.W           (A1)
                CLR.W           (A1)+
                CLR.W           -(A1)                
                CLR.L           D5
                CLR.L           (A1)
                CLR.L           (A1)+
                CLR.L           -(A1)
                CLR.L           $1234
                CLR.L           $1234ABCD
		
		NEG.B           D5
                NEG.B           (A1)
                NEG.B           (A1)+
                NEG.B           -(A1)
		NEG.W           D5
                NEG.W           (A1)
                NEG.W           (A1)+
                NEG.W           -(A1)                
                NEG.L           D5
                NEG.L           (A1)
                NEG.L           (A1)+
                NEG.L           -(A1)
                NEG.L           $1234
                NEG.L           $1234ABCD
		
		NOT.B           D5
                NOT.B           (A1)
                NOT.B           (A1)+
                NOT.B           -(A1)
		NOT.W           D5
                NOT.W           (A1)
                NOT.W           (A1)+
                NOT.W           -(A1)                
                NOT.L           D5
                NOT.L           (A1)
                NOT.L           (A1)+
                NOT.L           -(A1)
                NOT.L           $1234
                NOT.L           $1234ABCD
		
		EXT.W           D1
		EXT.L           D5
		
		NBCD.B          D5
                NBCD.B          (A1)
                NBCD.B          (A1)+
                NBCD.B          -(A1)
                NBCD.B          $1234
                NBCD.B          $1234ABCD
		
		SWAP            D5
		
                PEA             (A1)
                PEA             $1234
                PEA             $1234ABCD
		
		ILLEGAL
		
		TAS             D5
                TAS             (A1)
                TAS             (A1)+
                TAS             -(A1)
                TAS             $1234
                TAS             $1234ABCD
		
		TST.B           D5
                TST.B           (A1)
                TST.B           (A1)+
                TST.B           -(A1)
		TST.W           D5
                TST.W           (A1)
                TST.W           (A1)+
                TST.W           -(A1)                
                TST.L           D5
                TST.L           (A1)
                TST.L           (A1)+
                TST.L           -(A1)
                TST.L           $1234
                TST.L           $1234ABCD
		
		TRAP            #15
		LINK            A4,#4
		UNLK            A4
		MOVE            USP,A4
		MOVE            A4,USP
		RESET
		NOP
		STOP            #4455
		RTE
		RTS
		TRAPV
		RTR
		
		JSR             (A1)
		JSR             $1234
		JSR             $1234ABCD
		JSR             clear
		
		JMP             (A1)
		JMP             $1234
		JMP             $1234ABCD
		JMP             clear

 
		MOVEM.L         D0-D3/A0-A3,-(SP)       **MORE MOVEM TEST
		
		LEA             (A1),A2
		LEA             $1234,A1
		LEA             $1234ABCD,A1
		LEA             clear,A1
		
		CHK.W           D4,D5
		CHK.W           (A4),D5
		CHK.W           (A4)+,D5
		CHK.W           -(A4),D5
		CHK.W           $1234,D5
		CHK.W           #$1234,D5
		
*0101
		ADDQ.B          #1,D1
		ADDQ.W          #1,D1
		ADDQ.L          #1,D1
		ADDQ.B          #1,(A3)
		ADDQ.W          #1,(A3)
                ADDQ.L          #1,(A3)
                ADDQ.B          #1,(A4)+
                ADDQ.W          #1,(A4)+
                ADDQ.L          #1,(A4)+
                ADDQ.B          #1,-(A5)
                ADDQ.W          #1,-(A5)
		ADDQ.L          #1,-(A5)
		ADDQ.W          #1,$1234
		ADDQ.L          #1,$1234ABCD
		
		SUBQ.B          #1,D1
		SUBQ.W          #1,D1
		SUBQ.L          #1,D1
		SUBQ.B          #1,(A3)
		SUBQ.W          #1,(A3)
                SUBQ.L          #1,(A3)
                SUBQ.B          #1,(A4)+
                SUBQ.W          #1,(A4)+
                SUBQ.L          #1,(A4)+
                SUBQ.B          #1,-(A5)
                SUBQ.W          #1,-(A5)
		SUBQ.L          #1,-(A5)
		SUBQ.W          #1,$1234
		SUBQ.L          #1,$1234ABCD
		
		SCC             D5
                SCC             (A1)
                SCC             (A1)+
                SCC             -(A1)
                SCC             $1234
                SCC             $1234ABCD
		
		DBCC            D5,clear

*0110

                BCC.W           clear
		BRA.W           clear
		BSR.W           clear
		
*0111
		MOVEQ           #1,D4
		
*1000
		DIVU            D4,D5
		DIVU            (A1),D5
		DIVU            (A1)+,D5
		DIVU            -(A1),D5
		DIVU            $1234,D5
		DIVU            $1234ABCD,D5
		DIVU            #1234,D5

		DIVS            D4,D5
		DIVS            (A1),D5
		DIVS            (A1)+,D5
		DIVS            -(A1),D5
		DIVS            $1234,D5
		DIVS            $1234ABCD,D5
		DIVS            #1234,D5
				
		SBCD            D1,D2
		SBCD            -(A4),-(A5) 
   
                OR.W            D4,D5
		OR.W            (A1),D5
		OR.W            (A1)+,D5
		OR.W            -(A1),D5
		OR.W            $1234,D5
		OR.W            $1234ABCD,D5
		OR.W            #1234,D5
                
                OR.B            D4,D5
		OR.B            (A1),D5
		OR.B            (A1)+,D5
		OR.B            -(A1),D5
		OR.B            $1234,D5
		OR.B            $1234ABCD,D5
		OR.B            #1,D5
                
		OR.L            D4,D5
		OR.L            (A1),D5
		OR.L            (A1)+,D5
		OR.L            -(A1),D5
		OR.L            $1234,D5
		OR.L            $1234ABCD,D5
		OR.L            #1234,D5
		
		
		OR.W            D1,D4
		OR.W            D1,(A1)
		OR.W            D1,(A1)+
		OR.W            D1,-(A1)
		OR.W            D1,$1234
		OR.W            D1,$1234ABCD
                
                OR.B            D1,D4
		OR.B            D1,(A1)
		OR.B            D1,(A1)+
		OR.B            D1,-(A1)
		OR.B            D1,$1234
		OR.B            D1,$1234ABCD
                
		OR.L            D1,D4
		OR.L            D1,(A1)
		OR.L            D1,(A1)+
		OR.L            D1,-(A1)
		OR.L            D1,$1234
		OR.L            D1,$1234ABCD
						
*1001
                SUB.W           D4,D5
                SUB.W           A1,D5
		SUB.W           (A1),D5
		SUB.W           (A1)+,D5
		SUB.W           -(A1),D5
		SUB.W           $1234,D5
		SUB.W           $1234ABCD,D5
		SUB.W           #1234,D5
                
                SUB.B           D4,D5
		SUB.B           (A1),D5
		SUB.B           (A1)+,D5
		SUB.B           -(A1),D5
		SUB.B           $1234,D5
		SUB.B           $1234ABCD,D5
		SUB.B           #1,D5
                
		SUB.L           D4,D5
		SUB.L           A1,D5
		SUB.L           (A1),D5
		SUB.L           (A1)+,D5
		SUB.L           -(A1),D5
		SUB.L           $1234,D5
		SUB.L           $1234ABCD,D5
		SUB.L           #1234,D5
		
		SUB.W           D1,D4
		SUB.W           D1,(A1)
		SUB.W           D1,(A1)+
		SUB.W           D1,-(A1)
		SUB.W           D1,$1234
		SUB.W           D1,$1234ABCD
                
                SUB.B           D1,D4
		SUB.B           D1,(A1)
		SUB.B           D1,(A1)+
		SUB.B           D1,-(A1)
		SUB.B           D1,$1234
		SUB.B           D1,$1234ABCD
                
		SUB.L           D1,D4
		SUB.L           D1,(A1)
		SUB.L           D1,(A1)+
		SUB.L           D1,-(A1)
		SUB.L           D1,$1234
		SUB.L           D1,$1234ABCD

                SUBX.B          D1,D2
		SUBX.B          -(A4),-(A5)
                SUBX.W          D1,D2
		SUBX.W          -(A4),-(A5)
                SUBX.L          D1,D2
		SUBX.L          -(A4),-(A5)
		
		SUBA.W          D4,A1
                SUBA.W          A1,A1
		SUBA.W          (A1),A1
		SUBA.W          (A1)+,A1
		SUBA.W          -(A1),A1
		SUBA.W          $1234,A1
		SUBA.W          $1234ABCD,A1
		SUBA.W          #1234,A1
                
		SUBA.L          D4,A1
		SUBA.L          A1,A1
		SUBA.L          (A1),A1
		SUBA.L          (A1)+,A1
		SUBA.L          -(A1),A1
		SUBA.L          $1234,A1
		SUBA.L          $1234ABCD,A1
		SUBA.L          #1234,A1
		
*1011
                EOR.W           D1,D4
		EOR.W           D1,(A1)
		EOR.W           D1,(A1)+
		EOR.W           D1,-(A1)
		EOR.W           D1,$1234
		EOR.W           D1,$1234ABCD
                
                EOR.B           D1,D4
		EOR.B           D1,(A1)
		EOR.B           D1,(A1)+
		EOR.B           D1,-(A1)
		EOR.B           D1,$1234
		EOR.B           D1,$1234ABCD
                
		EOR.L           D1,D4
		EOR.L           D1,(A1)
		EOR.L           D1,(A1)+
		EOR.L           D1,-(A1)
		EOR.L           D1,$1234
		EOR.L           D1,$1234ABCD

		CMPM.L          (A4)+,(A5)+
		
		CMP.W           D4,D5
                CMP.W           A1,D5
		CMP.W           (A1),D5
		CMP.W           (A1)+,D5
		CMP.W           -(A1),D5
		CMP.W           $1234,D5
		CMP.W           $1234ABCD,D5
		CMP.W           #1234,D5
                
                CMP.B           D4,D5
		CMP.B           (A1),D5
		CMP.B           (A1)+,D5
		CMP.B           -(A1),D5
		CMP.B           $1234,D5
		CMP.B           $1234ABCD,D5
		CMP.B           #1,D5
                
		CMP.L           D4,D5
		CMP.L           A1,D5
		CMP.L           (A1),D5
		CMP.L           (A1)+,D5
		CMP.L           -(A1),D5
		CMP.L           $1234,D5
		CMP.L           $1234ABCD,D5
		CMP.L           #1234,D5		
		
		CMPA.W          D4,A1
                CMPA.W          A1,A1
		CMPA.W          (A1),A1
		CMPA.W          (A1)+,A1
		CMPA.W          -(A1),A1
		CMPA.W          $1234,A1
		CMPA.W          $1234ABCD,A1
		CMPA.W          #1234,A1
                
		CMPA.L          D4,A1
		CMPA.L          A1,A1
		CMPA.L          (A1),A1
		CMPA.L          (A1)+,A1
		CMPA.L          -(A1),A1
		CMPA.L          $1234,A1
		CMPA.L          $1234ABCD,A1
		CMPA.L          #1234,A1
		
*1100
		MULU.W          D4,D1
		MULU.W          (A1),D1
		MULU.W          (A1)+,D1
		MULU.W          -(A1),D1
		MULU.W          $1234,D1
		MULU.W          $1234ABCD,D1
		MULU.W          #1234,D1

                ABCD            D1,D3
		ABCD            -(A3),-(A4)
		
		EXG             D1,D2
		EXG             D2,A4
		EXG             A3,A4
		
		AND.W           D4,D5
		AND.W           (A1),D5
		AND.W           (A1)+,D5
		AND.W           -(A1),D5
		AND.W           $1234,D5
		AND.W           $1234ABCD,D5
		AND.W           #1234,D5
                
                AND.B           D4,D5
		AND.B           (A1),D5
		AND.B           (A1)+,D5
		AND.B           -(A1),D5
		AND.B           $1234,D5
		AND.B           $1234ABCD,D5
		AND.B           #1,D5
                
		AND.L           D4,D5
		AND.L           (A1),D5
		AND.L           (A1)+,D5
		AND.L           -(A1),D5
		AND.L           $1234,D5
		AND.L           $1234ABCD,D5
		AND.L           #1234,D5
		
		AND.W           D1,D4
		AND.W           D1,(A1)
		AND.W           D1,(A1)+
		AND.W           D1,-(A1)
		AND.W           D1,$1234
		AND.W           D1,$1234ABCD
                
                AND.B           D1,D4
		AND.B           D1,(A1)
		AND.B           D1,(A1)+
		AND.B           D1,-(A1)
		AND.B           D1,$1234
		AND.B           D1,$1234ABCD
                
		AND.L           D1,D4
		AND.L           D1,(A1)
		AND.L           D1,(A1)+
		AND.L           D1,-(A1)
		AND.L           D1,$1234
		AND.L           D1,$1234ABCD
	
*1101
                ADD.W           D4,D5
                ADD.W           A1,D5
		ADD.W           (A1),D5
		ADD.W           (A1)+,D5
		ADD.W           -(A1),D5
		ADD.W           $1234,D5
		ADD.W           $1234ABCD,D5
		ADD.W           #1234,D5
                
                ADD.B           D4,D5
		ADD.B           (A1),D5
		ADD.B           (A1)+,D5
		ADD.B           -(A1),D5
		ADD.B           $1234,D5
		ADD.B           $1234ABCD,D5
		ADD.B           #1,D5
                
		ADD.L           D4,D5
		ADD.L           A1,D5
		ADD.L           (A1),D5
		ADD.L           (A1)+,D5
		ADD.L           -(A1),D5
		ADD.L           $1234,D5
		ADD.L           $1234ABCD,D5
		ADD.L           #1234,D5
		
		ADD.W           D1,D4
		ADD.W           D1,(A1)
		ADD.W           D1,(A1)+
		ADD.W           D1,-(A1)
		ADD.W           D1,$1234
		ADD.W           D1,$1234ABCD
                
                ADD.B           D1,D4
		ADD.B           D1,(A1)
		ADD.B           D1,(A1)+
		ADD.B           D1,-(A1)
		ADD.B           D1,$1234
		ADD.B           D1,$1234ABCD
                
		ADD.L           D1,D4
		ADD.L           D1,(A1)
		ADD.L           D1,(A1)+
		ADD.L           D1,-(A1)
		ADD.L           D1,$1234
		ADD.L           D1,$1234ABCD
                
                ADDX.B          D1,D2
		ADDX.B          -(A3),-(A4)
                ADDX.W          D1,D2
		ADDX.W          -(A3),-(A4)
                ADDX.L          D1,D2
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
