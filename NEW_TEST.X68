*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $7000
START:                  ; first instruction of program

* Put program code here
    NOP
    RTS
    NOP
    
    ORI         #2,CCR
    ORI.W       #2,SR
    ORI         #1,D2
    ORI.B       #2,$7200
    
    CLR.B       D1
    CLR.W       D2
    CLR.L       D3
    
    ANDI        #2,CCR
    ANDI.W      #2,SR
    ANDI        #1,D2
    ANDI.B      #2,$7200
    
    NOP
    RTS
    NOP
    
    MOVE.B      D1,D7
    MOVE.B      #-15,D5
    MOVE.B      #-15,(A5)
    MOVE.B      #-15,-(A6)
    MOVE.B      #-15,(A7)+
    MOVE.B      $8888,D5
    MOVE.B      $1123FF55,D6
    MOVE.B      $FFFFFFF,D7
    MOVE.B      %11001111,D3
    MOVE.B      $23435,$8000
    MOVE.B      #$12,-(SP)
    MOVE.B      $20,(SP)+
    MOVE.B      (A2),D4  
    MOVE.B      D7,(A4)
    MOVE.B      -(A7),D3
    MOVE.B      (A1)+,D6
    MOVE.B      (A5),(A4)
    MOVE.B      $FFFFFFFF,$900000
    MOVE.B      #$11,(A4)+
    MOVE.B      #$10,-(A4)
    MOVE.B      $20,(SP)+
    MOVE.B      D5,$20(A2)
    MOVE.B      $20(A2),D5

    NOP
    RTS
    NOP
        
    ORI.B       #124,D4
    ORI.B       #137,$7000
    ORI.B       #223,(A5)
    ORI.B       #234,(A5)+ 
    ORI.B       #223,-(A5)
    NOP
    ORI.W       #124,D4
    ORI.W       #14524,D4
    ORI.W       #13523,$7000
    ORI.W       #22576,(A5)
    ORI.W       #28924,(A5)+ 
    ORI.W       #26635,-(A5)
    NOP
    ORI.L       #124,D4
    ORI.L       #28924,(A5)+
    ORI.L       #1454673637,D4
    ORI.L       #1364575626,$7000
    ORI.L       #2545325756,(A5)
    ORI.L       #2234674524,(A5)+ 
    ORI.L       #2534850344,-(A5)   
    
    NOP
    RTS
    NOP
    
    MOVE.W      D1,D7
    MOVE.W      #-1599,D5
    MOVE.W      #-1599,(A5)
    MOVE.W      #-1599,-(A6)
    MOVE.W      #-1599,(A7)+
    MOVE.W      $8888EEEE,D5
    MOVE.W      $1123FF55,D6
    MOVE.W      $0000FFFF,D7
    MOVE.W      %11001111,D3
    MOVE.W      $23435FF,$8000
    MOVE.W      #$12FF,-(SP)
    MOVE.W      $20EDF,(SP)+
    MOVE.W      (A2),D4  
    MOVE.W      D7,(A4)
    MOVE.W      -(A7),D3
    MOVE.W      (A1)+,D6
    MOVE.W      (A5),(A4)
    MOVE.W      $FFFFFFFF,$900000
    MOVE.W      #$FF11,(A4)+
    MOVE.W      #$FFFF,-(SP)
    MOVE.W      D5,$20(A2)
    MOVE.W      $20(A2),D5
    
    NOP
    RTS
    NOP
    
    ANDI.B      #124,D4
    ANDI.B      #137,$7000
    ANDI.B      #223,(A5)
    ANDI.B      #234,(A5)+ 
    ANDI.B      #223,-(A5)
    NOP
    ANDI.W      #124,D4
    ANDI.W      #14524,D4
    ANDI.W      #13523,$7000
    ANDI.W      #22576,(A5)
    ANDI.W      #28924,(A5)+ 
    ANDI.W      #26635,-(A5)
    NOP
    ANDI.L      #124,D4
    ANDI.L      #28924,(A5)+
    ANDI.L      #1454673637,D4
    ANDI.L      #1364575626,$7000
    ANDI.L      #2545325756,(A5)
    ANDI.L      #2234674524,(A5)+ 
    ANDI.L      #2534850344,-(A5)  

    NOP
    RTS
    NOP
    
    MOVE.L      D1,D7
    MOVE.L      #-1599,D5
    MOVE.L      #-1599,(A5)
    MOVE.L      #-1599,-(A6)
    MOVE.L      #-1599,(A7)+
    MOVE.L      $8888EEEE,D5
    MOVE.L      $1123FF55,D6
    MOVE.L      $0000FFFF,D7
    MOVE.L      %11001111,D3
    MOVE.L      #%101010101,(A0)
    MOVE.L      $23435FFF,$8000
    MOVE.L      #$12FF,-(SP)
    MOVE.L      $20EDF,(SP)+
    MOVE.L      (A2),D4  
    MOVE.L      D7,(A4)
    MOVE.L      -(A7),D3
    MOVE.L      (A1)+,D6
    MOVE.L      (A5),(A4)
    MOVE.L      $FFFFFFFF,$900000
    MOVE.L      #$FFF1111,(A4)+   
    
    NOP
    RTS
    NOP
    
    SUBI.B      #124,D4
    SUBI.B      #137,$7000
    SUBI.B      #223,(A5)
    SUBI.B      #234,(A5)+ 
    SUBI.B      #223,-(A5)
    NOP
    SUBI.W      #124,D4
    SUBI.W      #14524,D4
    SUBI.W      #13523,$7000
    SUBI.W      #22576,(A5)
    SUBI.W      #28924,(A5)+ 
    SUBI.W      #26635,-(A5)
    NOP
    SUBI.L      #124,D4
    SUBI.L      #28924,(A5)+
    SUBI.L      #1454673637,D4
    SUBI.L      #1364575626,$7000
    SUBI.L      #2545325756,(A5)
    SUBI.L      #2234674524,(A5)+ 
    SUBI.L      #2534850344,-(A5)
    
    NOP
    RTS
    NOP
    
    ADDI.B      #-15,D5
    ADDI.B      #-15,(A5)
    ADDI.B      #-15,-(A6)
    ADDI.B      #-15,(A7)+
    ADDI.B      #$88,D5
    ADDI.B      #%11001111,D3
    ADDI.B      #$23,$8000
    ADDI.B      #$12,-(SP)
    ADDI.B      #$20,(SP)+
    ADDI.B      #$F,$900000
    ADDI.B      #11,(A4)+
    ADDI.B      #10,-(A4)
    ADDI.B      #20,(SP)+

    NOP
    RTS
    NOP
    
    EORI        #2,CCR
    EORI.W      #2,SR
    EORI        #1,D2
    EORI.B      #2,$7200
    NOP    
    EORI.B      #124,D4
    EORI.B      #137,$7000
    EORI.B      #223,(A5)
    EORI.B      #234,(A5)+ 
    EORI.B      #223,-(A5)
    NOP
    EORI.W      #124,D4
    EORI.W      #14524,D4
    EORI.W      #13523,$7000
    EORI.W      #22576,(A5)
    EORI.W      #28924,(A5)+ 
    EORI.W      #26635,-(A5)
    NOP
    EORI.L      #124,D4
    EORI.L      #28924,(A5)+
    EORI.L      #1454673637,D4
    EORI.L      #1364575626,$7000
    EORI.L      #2545325756,(A5)
    EORI.L      #2234674524,(A5)+ 
    EORI.L      #2534850344,-(A5)    
    
    NOP
    RTS
    NOP
    

    ADDI.W      #-1599,D5
    ADDI.W      #-1599,(A5)
    ADDI.W      #-1599,-(A6)
    ADDI.W      #-1599,(A7)+
    ADDI.W      #$88EE,D5
    ADDI.W      #$0000FFFF,D7
    ADDI.W      #%11001111,D3
    ADDI.W      #$23FF,$8000
    ADDI.W      #$12FF,-(SP)
    ADDI.W      #$2DF,(SP)+
    ADDI.W      #$FFFFFFFF,$900000
    ADDI.W      #$FF11,(A4)+
    ADDI.W      #$FFFF,-(SP)
    
    NOP
    RTS
    NOP
    
    CMPI.B      #124,D4
    CMPI.B      #137,$7000
    CMPI.B      #223,(A5)
    CMPI.B      #234,(A5)+ 
    CMPI.B      #223,-(A5)
    NOP
    CMPI.W      #124,D4
    CMPI.W      #14524,D4
    CMPI.W      #13523,$7000
    CMPI.W      #22576,(A5)
    CMPI.W      #28924,(A5)+ 
    CMPI.W      #26635,-(A5)
    NOP
    CMPI.L      #124,D4
    CMPI.L      #28924,(A5)+
    CMPI.L      #1454673637,D4
    CMPI.L      #1364575626,$7000
    CMPI.L      #2545325756,(A5)
    CMPI.L      #2234674524,(A5)+ 
    CMPI.L      #2534850344,-(A5)  

    NOP
    RTS
    CLR.B       D1
    
    ADDI.L      #-1599,D5
    ADDI.L      #-1599,(A5)
    ADDI.L      #-1599,-(A6)
    ADDI.L      #-1599,(A7)+
    ADDI.L      #$8888EEEE,D5
    ADDI.L      #$1123FF55,D6
    ADDI.L      #$0000FFFF,D7
    ADDI.L      #%11001111,D3
    ADDI.L      #%101010101,(A0)
    ADDI.L      #$23435FFF,$8000
    ADDI.L      #$12FF,-(SP)
    ADDI.L      #$20EDF,(SP)+
    ADDI.L      #$FFFFFFFF,$900000
    ADDI.L      #$FFF1111,(A4)+
    
    NOP
    STOP        #$9000
    CLR.W       D2

    MOVEP.W     D5,$20(A2)
    MOVEP.W     D4,(A1)
    NOP
    MOVEP.L     D5,$20(A2)
    MOVEP.L     D4,(A1)
    
    NOP
    STOP        #$9000
    CLR.L       D3
    
    ASL.W       #2,D3
    ASR.B       #8,D3
    ASR.L       #7,D3
    ASR         #1,D3
    ASL         #$8,D3
    ASL.B       D4,D3  
    ASL.W       D4,D3 
    ASL.L       D4,D3  
    ASR.B       D4,D3  
    ASR.W       D4,D3 
    ASR.L       D4,D3
    ASR.W       $00FF0000
	ASR.W       $00FF0000
	ASL.W       $20(A5)
	ASR.W       $20(A5)
	ASL.W       $2033(A5)
	ASR.W       $2033(A5)
    BSR         SUBROUTINE  
	LSL.W       #2,D3
    LSR.B       #8,D3
    LSR.L       #7,D3
    LSR         #1,D3
    LSL         #$8,D3
    LSL.B       D4,D3  
    LSL.W       D4,D3 
    LSL.L       D4,D3  
    LSR.B       D4,D3  
    LSR.W       D4,D3 
    LSR.L       D4,D3
    LSL.W       $00FF0000
	LSR.W       $00FF0000
	LSL.W       $20(A5)
	LSR.W       $20(A5)
	LSL.W       $2033(A5)
	LSR.W       $2033(A5)
    BSR         SUBROUTINE
	NOP
	ROXR.L      #4,D5
	ROXL.L      #4,D5
	ROXR.W      $00FF0000
	ROXL.W      $00FF0000
	NOP
	ROL.W       #2,D3
    ROR.B       #8,D3
    ROR.L       #7,D3
    ROR         #1,D3
    ROL         #$8,D3
    ROL.B       D4,D3  
    ROL.W       D4,D3 
    ROL.L       D4,D3  
    ROR.B       D4,D3  
    ROR.W       D4,D3 
    ROR.L       D4,D3
    ROR.W       $00FF0000
	ROL.W       $00FF0000
	ROR.W       $20(A5)
	ROL.W       $20(A5)
	ROL.W       $2033(A5)
	ROR.W       $2033(A5)
    BSR         SUBROUTINE
    
    NOP
    RTS
    NOP

    MOVE.B      D1,D7
    MOVE.B      #-15,D5
    MOVE.B      #-15,(A5)
    MOVE.B      #-15,-(A6)
    MOVE.B      #-15,(A7)+
    MOVE.B      $8888,D5
    MOVE.B      $1123FF55,D6
    MOVE.B      $FFFFFFF,D7
    MOVE.B      %11001111,D3
    MOVE.B      $23435,$8000
    MOVE.B      #$12,-(SP)
    MOVE.B      $20,(SP)+
    MOVE.B      (A2),D4  
    MOVE.B      D7,(A4)
    MOVE.B      -(A7),D3
    MOVE.B      (A1)+,D6
    MOVE.B      (A5),(A4)
    MOVE.B      $FFFFFFFF,$900000
    MOVE.B      #$11,(A4)+
    MOVE.B      #$10,-(A4)
    MOVE.B      $20,(SP)+
    MOVE.B      D5,$20(A2)
    MOVE.B      $20(A2),D5
    
    NOP
    RTS
    NOP
    
    MOVE.W      D1,D7
    MOVE.W      #-1599,D5
    MOVE.W      #-1599,(A5)
    MOVE.W      #-1599,-(A6)
    MOVE.W      #-1599,(A7)+
    MOVE.W      $8888EEEE,D5
    MOVE.W      $1123FF55,D6
    MOVE.W      $0000FFFF,D7
    MOVE.W      %11001111,D3
    MOVE.W      $23435FF,$8000
    MOVE.W      #$12FF,-(SP)
    MOVE.W      $20EDF,(SP)+
    MOVE.W      (A2),D4  
    MOVE.W      D7,(A4)
    MOVE.W      -(A7),D3
    MOVE.W      (A1)+,D6
    MOVE.W      (A5),(A4)
    MOVE.W      $FFFFFFFF,$900000
    MOVE.W      #$FF11,(A4)+
    MOVE.W      #$FFFF,-(SP)
    MOVE.W      D5,$20(A2)
    MOVE.W      $20(A2),D5
    
    NOP
    RTS
    NOP
	
    MOVE.L      D1,D7
    MOVE.L      #-1599,D5
    MOVE.L      #-1599,(A5)
    MOVE.L      #-1599,-(A6)
    MOVE.L      #-1599,(A7)+
    MOVE.L      $8888EEEE,D5
    MOVE.L      $1123FF55,D6
    MOVE.L      $0000FFFF,D7
    MOVE.L      %11001111,D3
    MOVE.L      #%101010101,(A0)
    MOVE.L      $23435FFF,$8000
    MOVE.L      #$12FF,-(SP)
    MOVE.L      $20EDF,(SP)+
    MOVE.L      (A2),D4  
    MOVE.L      D7,(A4)
    MOVE.L      -(A7),D3
    MOVE.L      (A1)+,D6
    MOVE.L      (A5),(A4)
    MOVE.L      $FFFFFFFF,$900000
    MOVE.L      #$FFF1111,(A4)+ 
    
    NOP
    RTS
    NOP
    
    MOVEM.W     A1-A7,$12
    MOVEM.L     D1-D7,$12
    MOVEM.W     A1/D7,$12
    MOVEM.L     A1/D7,$12
    MOVEM.W     A1-A7,$1234
    MOVEM.L     D1-D7,$1234
    MOVEM.W     A1/D7,$1234
    MOVEM.L     A1/D7,$1234
    MOVEM.W     A1-A7,$12345678
    MOVEM.L     D1-D7,$12345678
    MOVEM.W     A1/D7,$12345678
    MOVEM.L     A1/D7,$12345678
    MOVEM.W     $12,A1-A7
    MOVEM.L     $12,D1-D7
    MOVEM.W     $12,A1/D7
    MOVEM.L     $12,A1/D7
    MOVEM.W     $1234,A1-A7
    MOVEM.L     $1234,D1-D7
    MOVEM.W     $1234,A1/D7
    MOVEM.L     $1234,A1/D7
    MOVEM.W     $12345678,A1-A7
    MOVEM.L     $12345678,D1-D7
    MOVEM.W     $12345678,A1/D7
    MOVEM.L     $12345678,A1/D7
    
    MOVEM.W     D0-D7/A0-A7,-(SP)
    MOVEM.W     (SP)+,D0-D7/A0-A7
    MOVEM.W     D7/A0,-(SP)
    MOVEM.W     (SP)+,D0/A7 
    MOVEM.W     (2,A4), D0-D7
    MOVEM.W     (-2,A4), D0-D7
    MOVEM.W     A0-A7/D4, -(A5)
    MOVEM.W     A0-A7/D3/D6, -(A3)
    MOVEM.W     A0-A7, -(SP)
    MOVEM.W     (2,A4), D0-D7
    MOVEM.W     (-2,A4), D0-D7
    
    MOVE.W      SR,D1
    MOVE.W      SR,$20(A4)
    MOVE.W      SR,$5000
    MOVE.W      SR,$FFFF6000
    MOVE.W      SR,(A4)
    MOVE.W      SR,$4000(A4)
    MOVE.W      SR,-(SP)
    MOVE.W      SR,(SP)+
    MOVE.W      D5,SR
    MOVE.W      $5555,SR
	MOVE.W      $12345678, SR
	MOVE.W      #$5678,SR
    JSR         SUBROUTINE
    MOVE.L      D1,D7
    MOVE.L      #-1599,D5
    MOVE.L      #-1599,(A5)
    MOVE.L      #-1599,-(A6)
    MOVE.L      #-1599,(A7)+
    MOVE.L      $8888EEEE,D5
    MOVE.L      $1123FF55,D6
    MOVE.L      $0000FFFF,D7
    MOVE.L      %11001111,D3
    MOVE.L      #%101010101,(A0)
    MOVE.L      $23435FFF,$8000
    MOVE.L      #$12FF,-(SP)
    MOVE.L      $20EDF,(SP)+
    MOVE.L      (A2),D4  
    MOVE.L      D7,(A4)
    MOVE.L      -(A7),D3
    MOVE.L      (A1)+,D6
    MOVE.L      (A5),(A4)
    MOVE.L      $FFFFFFFF,$900000
    MOVE.L      #$FFF1111,(A4)+ 
    MOVE        D5,CCR
	MOVE        $5555,CCR
	MOVE        #$5678,CCR
    MOVE        $20(A4),CCR
    MOVE        $FFFF6000,CCR
    MOVE        (A4),CCR
    MOVE        $4000(A4),CCR
    MOVE        -(SP),CCR
    MOVE        (SP)+,CCR
    RTS
    MOVEM.L     D0-D7/A0-A7,-(SP)
    MOVEM.L     (SP)+,D0-D7/A0-A7
    MOVEM.L     D7/A0,-(SP)
    MOVEM.L     (SP)+,D0/A7 
    MOVEM.L     (2,A4), D0-D7
    MOVEM.L     (-2,A4), D0-D7
    MOVEM.L     A0-A7/D4, -(A5)
    MOVEM.L     A0-A7/D3/D6, -(A3)
    MOVEM.L     A0-A7, -(SP)
    MOVEM.L     (2,A4), D0-D7
    MOVEM.L     (-2,A4), D0-D7
    
    NOP
    RTS
    NOP
    
    ADDQ.B      #7,D1
	ADDQ.W      #3,D1
	ADDQ.L      #4,D1
	ADDQ.B      #1,(A3)
	ADDQ.W      #4,(A3)
    ADDQ.L      #5,(A3)
    ADDQ.B      #6,(A4)+
    ADDQ.W      #7,(A4)+
    ADDQ.L      #2,(A4)+
    ADDQ.B      #8,-(A5)
    ADDQ.W      #8,-(A5)
	ADDQ.L      #6,-(A5)
	ADDQ.W      #3,$1234
	ADDQ.L      #6,$1234ABCD
	ADDQ.L      #8,$3009(A6)
	ADDQ.B      #8,$11(A4)
		
	SUBQ.B      #1,D1
	SUBQ.W      #2,D1
	SUBQ.L      #3,D1
	SUBQ.B      #4,(A3)
	SUBQ.W      #5,(A3)
    SUBQ.L      #6,(A3)
    SUBQ.B      #7,(A4)+
    SUBQ.W      #8,(A4)+
    SUBQ.L      #1,(A4)+
    SUBQ.B      #1,-(A5)
    SUBQ.W      #1,-(A5)
	SUBQ.L      #1,-(A5)
	SUBQ.W      #1,$1234
	SUBQ.L      #1,$1234ABCD
	SUBQ.L      #8,$3009(A6)
	SUBQ.B      #8,$11(A4)
		
	SCC         D5
    SCC         (A1)
    SCC         (A1)+
    SCC         -(A1)
    SCC         $1234
    SCC         $1234ABCD
		
	DBCC        D5,CLEAR
	
	MOVEA.W     D1,A2
	MOVEA.W     A1,A2
	MOVEA.W     (A1),A2
	MOVEA.W     (A1)+,A2
	MOVEA.W     -(A1),A2
	MOVEA.W     #$1234,A2
	MOVEA.W     #-1234,A2
	MOVEA.W     #1234,A2
	MOVEA.W     $20034,A3
	MOVEA.W     $20(A5),A5
	
	NOP
	
    MOVEA.L     D1,A2
    MOVEA.L     A1,A2
    MOVEA.L     (A1),A2
    MOVEA.L     (A1)+,A2
    MOVEA.L     -(A1),A2
    MOVEA.L     #$1234ABCD,A2
    MOVEA.L     #$1234,A2
	MOVEA.L     #-1234,A2
	MOVEA.L     #-12345678,A2
	MOVEA.L     #1234,A2
	MOVEA.L     $2074,A3
	MOVEA.L     $2074FFFF,A3
	MOVEA.L     $20(A5),A5
	
	NEGX.B      D5
    NEGX.B      (A1)
    NEGX.B      (A1)+
    NEGX.B      -(A1)
	NEGX.W      D5
    NEGX.W      (A1)
    NEGX.W      (A1)+
    NEGX.W      -(A1)                
    NEGX.L      D5
    NEGX.L      (A1)
    NEGX.L      (A1)+
    NEGX.L      -(A1)
    NEGX.L      $1234
    NEGX.L      $1234ABCD
                
    BTST.L      #$12345678,D1
    BTST.B      #1,(A3)
    BTST.B      #1,(A4)+
    BTST.B      #1,-(A5)
    BTST.B      #$1234,$1234
	BTST.B      #$1234ABCD,$1234
	BTST.B      #1,$1234
	BTST.B      #$1234,$1234
	BTST.B      #$1234ABCD,$1234
	BTST.B      #$1234,#$12
		
	BTST.L      D1,D1
	BTST.B      D1,(A3)
    BTST.B      D1,(A4)+
    BTST.B      D1,-(A5)
	BTST.B      D1,$1234
	BTST.B      D1,#$12
	TRAP        #15
	LINK        A4,#4
	UNLK        A4
	MOVE        USP,A4
	MOVE        A4,USP
	RESET
	NOP
	STOP        #4455
	RTE
	RTS
	TRAPV
	RTR
    
    JSR         SUBROUTINE
    MOVEM.L     D0-D7/A0-A7,-(SP)
    MOVEM.L     (SP)+,D0-D7/A0-A7
    MOVEM.L     D7/A0,-(SP)
    MOVEM.L     (SP)+,D0/A7 
    MOVEM.L     (2,A4), D0-D7
    MOVEM.L     (-2,A4), D0-D7
    MOVEM.L     A0-A7/D4, -(A5)
    MOVEM.L     A0-A7/D3/D6, -(A3)
    MOVEM.L     A0-A7, -(SP)
    MOVEM.L     (2,A4), D0-D7
    MOVEM.L     (-2,A4), D0-D7
    
    JMP         (A1)
	JMP         $1234
	JMP         $1234ABCD
	JMP         CLEAR
		
	AND.W       D4,D5
	AND.W       (A1),D5
	AND.W       (A1)+,D5
	AND.W       -(A1),D5
	AND.W       $1234,D5
	AND.W       $1234ABCD,D5  
	AND.W       #1234,D5
                
    AND.B       D4,D5
	AND.B       (A1),D5
	AND.B       (A1)+,D5
	AND.B       -(A1),D5
	AND.B       $1234,D5
	AND.B       $1234ABCD,D5
	AND.B       #1,D5
                
	AND.L       D4,D5
	AND.L       (A1),D5
	AND.L       (A1)+,D5
	AND.L       -(A1),D5
	AND.L       $1234,D5
	AND.L       $1234ABCD,D5
	AND.L       #1234,D5
		
	AND.W       D1,D4
	AND.W       D1,(A1)
	AND.W       D1,(A1)+
	AND.W       D1,-(A1)
	AND.W       D1,$1234
	AND.W       D1,$1234ABCD
	AND.B       D1,$12(A5)
                
    AND.B       D1,D4
	AND.B       D1,(A1)
	AND.B       D1,(A1)+
	AND.B       D1,-(A1)
	AND.B       D1,$1234
	AND.B       D1,$1234ABCD
	AND.B       D1,$12(A5)
                
	AND.L       D1,D4
	AND.L       D1,(A1)
	AND.L       D1,(A1)+
	AND.L       D1,-(A1)
	AND.L       D1,$1234
	AND.L       D1,$1234ABCD
    AND.L       D1,$12(A5)
    
    DBCC        D5,CLEAR
	
	MOVEA.W     D1,A2
	MOVEA.W     A1,A2
	MOVEA.W     (A1),A2
	MOVEA.W     (A1)+,A2
	MOVEA.W     -(A1),A2
	MOVEA.W     #$1234,A2
	MOVEA.W     #-1234,A2
	MOVEA.W     #1234,A2
	MOVEA.W     $20034,A3
	MOVEA.W     $20(A5),A5
	
	NOP
	
    MOVEA.L     D1,A2
    MOVEA.L     A1,A2
    MOVEA.L     (A1),A2
    MOVEA.L     (A1)+,A2
    MOVEA.L     -(A1),A2
    MOVEA.L     #$1234ABCD,A2
    MOVEA.L     #$1234,A2
	MOVEA.L     #-1234,A2
	MOVEA.L     #-12345678,A2
	MOVEA.L     #1234,A2
	MOVEA.L     $2074,A3
	MOVEA.L     $2074FFFF,A3
	MOVEA.L     $20(A5),A5
	
	BCHG.L      #$12345678,D1
	BCHG.B      #1,(A3)
    BCHG.B      #1,(A4)+
    BCHG.B      #1,-(A5)
	BCHG.B      #$1234,$1234
	BCHG.B      #$1234ABCD,$1234
	BCHG.B      #1,$1234
	BCHG.B      #$1234,$1234
	BCHG.B      #$1234ABCD,$1234
		
	BCHG.L      D1,D1
	BCHG.B      D1,(A3)
    BCHG.B      D1,(A4)+
    BCHG.B      D1,-(A5)
	BCHG.B      D1,$1234

    BCLR.L      #$12345678,D1
	BCLR.B      #1,(A3)
    BCLR.B      #1,(A4)+
    BCLR.B      #1,-(A5)
	BCLR.B      #$1234,$1234
	BCLR.B      #$1234ABCD,$1234
	BCLR.B      #1,$1234
	BCLR.B      #$1234,$1234
	BCLR.B      #$1234ABCD,$1234
		
	BCLR.L      D1,D1
	BCLR.B      D1,(A3)
    BCLR.B      D1,(A4)+
    BCLR.B      D1,-(A5)
    BCLR.B      D1,$1234
		
    BSET.L      #$12345678,D1
	BSET.B      #1,(A3)
    BSET.B      #1,(A4)+
    BSET.B      #1,-(A5)
	BSET.B      #$1234,$1234
	BSET.B      #$1234ABCD,$1234
	BSET.B      #1,$1234
	BSET.B      #$1234,$1234
	BSET.B      #$1234ABCD,$1234
		
	BSET.L      D1,D1
	BSET.B      D1,(A3)
    BSET.B      D1,(A4)+
    BSET.B      D1,-(A5)
	BSET.B      D1,$1234

    NOP
    RTS
    NOP
    
    MOVE.B      D1,D7
    MOVE.B      #-15,D5
    MOVE.B      #-15,(A5)
    MOVE.B      #-15,-(A6)
    MOVE.B      #-15,(A7)+
    MOVE.B      $8888,D5
    MOVE.B      $1123FF55,D6
    MOVE.B      $FFFFFFF,D7
    MOVE.B      %11001111,D3
    MOVE.B      $23435,$8000
    MOVE.B      #$12,-(SP)
    MOVE.B      $20,(SP)+
    MOVE.B      (A2),D4  
    MOVE.B      D7,(A4)
    MOVE.B      -(A7),D3
    MOVE.B      (A1)+,D6
    MOVE.B      (A5),(A4)
    MOVE.B      $FFFFFFFF,$900000
    MOVE.B      #$11,(A4)+
    MOVE.B      #$10,-(A4)
    MOVE.B      $20,(SP)+
    MOVE.B      D5,$20(A2)
    MOVE.B      $20(A2),D5
    
    MOVEQ       #1,D4
    MOVEQ       #8,D5
    MOVEQ       #$55,D6
    MOVEQ       #-34,D5
    MOVEQ       #-$44,D6
    
    LEA	        $DC00FF00,A2
    LEA         $8000,A1
    LEA         (A1),A3
	LEA         CLEAR,A1
	LEA         $32(A5),A4
	
	CHK.W       D4,D5
	CHK.W       (A4),D5
	CHK.W       (A4)+,D5
	CHK.W       -(A4),D5
	CHK.W       $1234,D5
	CHK.W       #$1234,D5
	CHK.W       $20(A6),D6
	
	NOP
	
	ADD.W       D4,D5
    ADD.W       A1,D5
	ADD.W       (A1),D5
	ADD.W       (A1)+,D5
	ADD.W       -(A1),D5
	ADD.W       $1234,D5
	ADD.W       $1234ABCD,D5
	ADD.W       #1234,D5
                
    ADD.B       D4,D5
	ADD.B       (A1),D5
	ADD.B       (A1)+,D5
	ADD.B       -(A1),D5
	ADD.B       $1234,D5
	ADD.B       $1234ABCD,D5
	ADD.B       #1,D5
                
	ADD.L       D4,D5
	ADD.L       A1,D5
	ADD.L       (A1),D5
	ADD.L       (A1)+,D5
	ADD.L       -(A1),D5
	ADD.L       $1234,D5
	ADD.L       $1234ABCD,D5
	ADD.L       #1234,D5
		
	ADD.W       D1,D4
	ADD.W       D1,(A1)
	ADD.W       D1,(A1)+
	ADD.W       D1,-(A1)
	ADD.W       D1,$1234
	ADD.W       D1,$1234ABCD
	
	MOVEM.L     D0-D7/A0-A7,-(SP)
    MOVEM.L     (SP)+,D0-D7/A0-A7
    MOVEM.L     D7/A0,-(SP)
    MOVEM.L     (SP)+,D0/A7 
    MOVEM.L     (2,A4), D0-D7
    MOVEM.L     (-2,A4), D0-D7
    MOVEM.L     A0-A7/D4, -(A5)
    MOVEM.L     A0-A7/D3/D6, -(A3)
    MOVEM.L     A0-A7, -(SP)
    MOVEM.L     (2,A4), D0-D7
    MOVEM.L     (-2,A4), D0-D7
                
    ADD.B       D1,D4
	ADD.B       D1,(A1)
	ADD.B       D1,(A1)+
	ADD.B       D1,-(A1)
	ADD.B       D1,$1234
	ADD.B       D1,$1234ABCD
                
	ADD.L       D1,D4
	ADD.L       D1,(A1)
	ADD.L       D1,(A1)+
	ADD.L       D1,-(A1)
	ADD.L       D1,$1234
	ADD.L       D1,$1234ABCD
                
    ADDX.B      D1,D2
	ADDX.B      -(A3),-(A4)
    ADDX.W      D1,D2
	ADDX.W      -(A3),-(A4)
    ADDX.L      D1,D2
	ADDX.L      -(A3),-(A4)
	ADDA        D4,A5
	
	MOVEM.L     D0-D7/A0-A7,-(SP)
    MOVEM.L     (SP)+,D0-D7/A0-A7
    MOVEM.L     D7/A0,-(SP)
    MOVEM.L     (SP)+,D0/A7 
    MOVEM.L     (2,A4), D0-D7
    MOVEM.L     (-2,A4), D0-D7
    MOVEM.L     A0-A7/D4, -(A5)
    MOVEM.L     A0-A7/D3/D6, -(A3)
    MOVEM.L     A0-A7, -(SP)
    MOVEM.L     (2,A4), D0-D7
    MOVEM.L     (-2,A4), D0-D7
    
    NEG.B       D5
    NEG.B       (A1)
    NEG.B       (A1)+
    NEG.B       -(A1)
	NEG.W       D5
    NEG.W       (A1)
    NEG.W       (A1)+
    NEG.W       -(A1)          
    NEG.L       D5
    NEG.L       (A1)
    NEG.L       (A1)+
    NEG.L       -(A1)
    NEG.L       $1234
    NEG.L       $1234ABCD
		
	NOT.B       D5
    NOT.B       (A1)
    NOT.B       (A1)+
    NOT.B       -(A1)
	NOT.W       D5
    NOT.W       (A1)
    NOT.W       (A1)+
    NOT.W       -(A1)    
    NOT.L       D5
    NOT.L       (A1)
    NOT.L       (A1)+
    NOT.L       -(A1)
    NOT.L       $1234
    NOT.L       $1234ABCD
		
	EXT.W       D1
	EXT.L       D5
		
	NBCD.B      D5
    NBCD.B      (A1)
    NBCD.B      (A1)+
    NBCD.B      -(A1)
    NBCD.B      $1234
    NBCD.B      $1234ABCD
		
	SWAP        D5
		
    PEA         (A1)
    PEA         $1234
    PEA         $1234ABCD
		
	ILLEGAL
		
	TAS         D5
    TAS         (A1)
    TAS         (A1)+
    TAS         -(A1)
    TAS         $1234
    TAS         $1234ABCD
		
	TST.B       D5
    TST.B       (A1)
    TST.B       (A1)+
    TST.B       -(A1)
	TST.W       D5
    TST.W       (A1)
    TST.W       (A1)+
    TST.W       -(A1)    
    TST.L       D5
    TST.L       (A1)
    TST.L       (A1)+
    TST.L       -(A1)
    TST.L       $1234
    TST.L       $1234ABCD
	
	NOP
	
	DIVU        D4,D5
	DIVU        (A1),D5
	DIVU        (A1)+,D5
	DIVU        -(A1),D5
	DIVU        $1234,D5
	DIVU        $1234ABCD,D5
	DIVU        #1234,D5
	
	DIVS        D4,D5
	DIVS        (A1),D5
	DIVS        (A1)+,D5
	DIVS        -(A1),D5
	DIVS        $1234,D5
	DIVS        $1234ABCD,D5
	DIVS        #1234,D5
				
	SBCD        D1,D2
	SBCD        -(A4),-(A5)
	
	CMPM.L      (A4)+,(A5)+
		
	CMP.W       D4,D5
    CMP.W       A1,D5
	CMP.W       (A1),D5
	CMP.W       (A1)+,D5
	CMP.W       -(A1),D5
	CMP.W       $1234,D5
	CMP.W       $1234ABCD,D5
	CMP.W       #1234,D5
           
    CMP.B       D4,D5
	CMP.B       (A1),D5
	CMP.B       (A1)+,D5
	CMP.B       -(A1),D5
	CMP.B       $1234,D5
	CMP.B       $1234ABCD,D5
	CMP.B       #1,D5
           
	CMP.L       D4,D5
	CMP.L       A1,D5
	CMP.L       (A1),D5
	CMP.L       (A1)+,D5
	CMP.L       -(A1),D5
	CMP.L       $1234,D5
	CMP.L       $1234ABCD,D5
	CMP.L       #1234,D5		
		
	CMPA.W      D4,A1
    CMPA.W      A1,A1
	CMPA.W      (A1),A1
	CMPA.W      (A1)+,A1
	CMPA.W      -(A1),A1
	CMPA.W      $1234,A1
	CMPA.W      $1234ABCD,A1
	CMPA.W      #1234,A1
       
	CMPA.L      D4,A1
	CMPA.L      A1,A1
	CMPA.L      (A1),A1
	CMPA.L      (A1)+,A1
	CMPA.L      -(A1),A1
	CMPA.L      $1234,A1
	CMPA.L      $1234ABCD,A1
	CMPA.L      #1234,A1
	
	NOP
    RTS
    NOP
	
    MOVE.L      D1,D7
    MOVE.L      #-1599,D5
    MOVE.L      #-1599,(A5)
    MOVE.L      #-1599,-(A6)
    MOVE.L      #-1599,(A7)+
    MOVE.L      $8888EEEE,D5
    MOVE.L      $1123FF55,D6
    MOVE.L      $0000FFFF,D7
    MOVE.L      %11001111,D3
    MOVE.L      #%101010101,(A0)
    MOVE.L      $23435FFF,$8000
    MOVE.L      #$12FF,-(SP)
    MOVE.L      $20EDF,(SP)+
    MOVE.L      (A2),D4  
    MOVE.L      D7,(A4)
    MOVE.L      -(A7),D3
    MOVE.L      (A1)+,D6
    MOVE.L      (A5),(A4)
    MOVE.L      $FFFFFFFF,$900000
    MOVE.L      #$FFF1111,(A4)+ 
    
    NOP
    RTS
    NOP
    
    MOVEM.W     D0-D7/A0-A7,-(SP)
    MOVEM.W     (SP)+,D0-D7/A0-A7
    MOVEM.W     D7/A0,-(SP)
    MOVEM.W     (SP)+,D0/A7 
    MOVEM.W     (2,A4), D0-D7
    MOVEM.W     (-2,A4), D0-D7
    MOVEM.W     A0-A7/D4, -(A5)
    MOVEM.W     A0-A7/D3/D6, -(A3)
    MOVEM.W     A0-A7, -(SP)
    MOVEM.W     (2,A4), D0-D7
    MOVEM.W     (-2,A4), D0-D7

    EOR.W       D1,D4
	EOR.W       D1,(A1)
	EOR.W       D1,(A1)+
	EOR.W       D1,-(A1)
	EOR.W       D1,$1234
	EOR.W       D1,$1234ABCD
            
    EOR.B       D1,D4
	EOR.B       D1,(A1)
	EOR.B       D1,(A1)+
	EOR.B       D1,-(A1)
	EOR.B       D1,$1234
	EOR.B       D1,$1234ABCD
            
	EOR.L       D1,D4
	EOR.L       D1,(A1)
	EOR.L       D1,(A1)+
	EOR.L       D1,-(A1)
	EOR.L       D1,$1234
	EOR.L       D1,$1234ABCD
	
	MULU.W      D4,D1
    MULU.W      (A1),D1
	MULU.W      (A1)+,D1
	MULU.W      -(A1),D1
	MULU.W      $1234,D1
	MULU.W      $1234ABCD,D1
	MULU.W      #1234,D1

    ABCD        D1,D3
	ABCD        -(A3),-(A4)
		
	EXG         D1,D2
	EXG         D2,A4
	EXG         A3,A4
	
    OR.W        D4,D5
	OR.W        (A1),D5
	OR.W        (A1)+,D5
	OR.W        -(A1),D5
	OR.W        $1234,D5
	OR.W        $1234ABCD,D5
	OR.W        #1234,D5
            
    OR.B        D4,D5
	OR.B        (A1),D5
	OR.B        (A1)+,D5
	OR.B        -(A1),D5
	OR.B        $1234,D5
	OR.B        $1234ABCD,D5
	OR.B        #1,D5
            
	OR.L        D4,D5
	OR.L        (A1),D5
	OR.L        (A1)+,D5
	OR.L        -(A1),D5
	OR.L        $1234,D5
	OR.L        $1234ABCD,D5
	OR.L        #1234,D5
		
		
	OR.W        D1,D4
	OR.W        D1,(A1)
	OR.W        D1,(A1)+
	OR.W        D1,-(A1)
	OR.W        D1,$1234
	OR.W        D1,$1234ABCD
            
    OR.B        D1,D4
	OR.B        D1,(A1)
	OR.B        D1,(A1)+
	OR.B        D1,-(A1)
	OR.B        D1,$1234
	OR.B        D1,$1234ABCD
            
	OR.L        D1,D4
	OR.L        D1,(A1)
	OR.L        D1,(A1)+
	OR.L        D1,-(A1)
	OR.L        D1,$1234
	OR.L        D1,$1234ABCD
    
    DBCC        D5,CLEAR
	
	MOVEA.W     D1,A2
	MOVEA.W     A1,A2
	MOVEA.W     (A1),A2
	MOVEA.W     (A1)+,A2
	MOVEA.W     -(A1),A2
	MOVEA.W     #$1234,A2
	MOVEA.W     #-1234,A2
	MOVEA.W     #1234,A2
	MOVEA.W     $20034,A3
	MOVEA.W     $20(A5),A5
	
	SUB.W       D4,D5
	SUB.W       A1,D5
	SUB.W       (A1),D5
	SUB.W       (A1)+,D5
	SUB.W       -(A1),D5
	SUB.W       $1234,D5
	SUB.W       $1234ABCD,D5
	SUB.W       #1234,D5
    SUB.W       $29(A6),D4
    SUB.W       #1,D5
	SUB.W       $29(A6),D4
	SUB.W       #-23,D5
	SUB.W       #$F88F,D6
	SUB.W       #-$8,D6
	
	SUB.B       D4,D5
	SUB.B       (A1),D5
	SUB.B       (A1)+,D5
	SUB.B       -(A1),D5
	SUB.B       $1234,D5
	SUB.B       $1234ABCD,D5
	SUB.B       #1,D5
	SUB.B       $29(A6),D4
	SUB.B       #-23,D5
	SUB.B       #$F8,D6
	SUB.B       #-$8,D6
	
	SUB.L       D4,D5
	SUB.L       A1,D5
	SUB.L       (A1),D5
	SUB.L       (A1)+,D5
	SUB.L       -(A1),D5
	SUB.L       $1234,D5
	SUB.L       $1234ABCD,D5
	SUB.L       #1234,D5
	SUB.L       #1,D5
	SUB.L       $29(A6),D4
	SUB.L       #-$23FF44,D5
	SUB.L       #$F88F88FF,D6
	SUB.L       #-8,D6
	
	SUB.W       D1,D4
	SUB.W       D1,(A1)
	SUB.W       D1,(A1)+
	SUB.W       D1,-(A1)
	SUB.W       D1,$1234
	SUB.W       D1,$1234ABCD
	
	SUB.B       D1,D4
	SUB.B       D1,(A1)
	SUB.B       D1,(A1)+
	SUB.B       D1,-(A1)
	SUB.B       D1,$1234
	SUB.B       D1,$1234ABCD
	
	SUB.L       D1,D4
	SUB.L       D1,(A1)
	SUB.L       D1,(A1)+
	SUB.L       D1,-(A1)
	SUB.L       D1,$1234
	SUB.L       D1,$1234ABCD

	SUBX.B      D1,D2
	SUBX.B      -(A4),-(A5)
	SUBX.W      D1,D2
	SUBX.W      -(A4),-(A5)
	SUBX.L      D1,D2
	SUBX.L      -(A4),-(A5)
	
	SUBA.W      D4,A1
	SUBA.W      A1,A1
	SUBA.W      (A1),A1
	SUBA.W      (A1)+,A1
	SUBA.W      -(A1),A1
	SUBA.W      $1234,A1
	SUBA.W      $1234ABCD,A1
	SUBA.W      #1234,A1
    SUBA.W      $29(A6),A4
	SUBA.W      #-$FFF,A6
	SUBA.W      #-234,A5
	SUBA.W      #$FFFF8888,A6
	SUBA.W      #-$FFFF8888,A6
	
	SUBA.L      D4,A1
	SUBA.L      A1,A1
	SUBA.L      (A1),A1
	SUBA.L      (A1)+,A1
	SUBA.L      -(A1),A1
	SUBA.L      $1234,A1
	SUBA.L      $1234ABCD,A1
	SUBA.L      #1234,A1
	SUBA.L      $29(A6),A4
	SUBA.L      #-$FFF,A6
	SUBA.L      #-234,A5
	SUBA.L      #$FFFF8888,A6
	SUBA.L      #-$FFFF8888,A6


compares
    CMP.B	    (A3),D5  
    CMP.W       $2000,D5
    CMP.L       #$FFEEDD,D5

jmplabel	
    BCC         compares		
	BGT	        compares		
	BLE	        compares	
	JSR	        (A3)		* Address register indirect
	BCC	        CLEAR		
	JSR         $7900
	JSR         $FF500
	
    MOVEM.L     D0-D7/A0-A7,-(SP)
    MOVEM.L     (SP)+,D0-D7/A0-A7
    MOVEM.L     D7/A0,-(SP)
    MOVEM.L     (SP)+,D0/A7 
    MOVEM.L     (2,A4), D0-D7
    MOVEM.L     (-2,A4), D0-D7
    MOVEM.L     A0-A7/D4, -(A5)
    MOVEM.L     A0-A7/D3/D6, -(A3)
    MOVEM.L     A0-A7, -(SP)
    MOVEM.L     (2,A4), D0-D7
    MOVEM.L     (-2,A4), D0-D7
    
CLEAR:
    CLR.L       D5
    CLR.W       D5
    CLR.B       $9000
    
SUBROUTINE:
    MULS.W      D5,D6
    MULS.W      #1,D5
    MULS.W      (A6),D6
    MULS.W      -(A7),D6
    MULS.W      (A6)+,D5
    MULS.W      $20(A6),D6
    MULS.W      #-14,D6
    MULS.W      #-$ABC,D6
    MULS.W      #34,D6
    MULS.W      #$FF11,D6
    MULS.W      $555,D7
    MULS.W      $FFFFFFFF,D4
    
    
    SIMHALT        ; halt simulator

* Put variables and constants here

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
