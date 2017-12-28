
*******************************************************************************                              
*  
* Parameters:
*   A1: Load print
*   A2: Load address to print
*   A5: Load end address
*   A6: Load current address, addr to read
*   D0: Traps
*   D1: Traps  
*   D2: Screen Counter
*   D4: Special cases/abs.word(0)/abs.long (1)/immediate (4)
*   D5: Register number
*   D6: Bit manipulator
*   D7: Data                 
******************************************************************************    
READOPCODE:     MOVEM.L     A1-A2/D0-D3, -(SP)   
                CMP.W       #$4E71, D7          ; check if NOP
                BEQ         jumpTo_NOP                                               
                CMP.W       #$4E75, D7          ; check if RTS
                BEQ         jumpTo_RTS      
                
                MOVE.W      D7, D6               
                ROL.W       #4, D6              ; rotate D6 4 bits to left            
                ANDI.W      #$000F, D6          ; mask D6 with $000F           
                
checkOpCode:    CMP.W       #$0000, D6          ; compare D6 with $0
                BEQ         jumpTo_0000         ; branch to jumpTo_0000 if D6 equals to 0
                CMP.W       #$0001, D6          ; compare D5 with $1
                BEQ         jumpTo_0001         ; branch to jumpTo_0000 if D6 equals to $1
                CMP.W       #$0002, D6          ; compare D5 with $2
                BEQ         jumpTo_0002         ; branch to jumpTo_0000 if D6 equals to $2
                CMP.W       #$0003, D6          ; compare D5 with $3
                BEQ         jumpTo_0003         ; branch to jumpTo_0000 if D6 equals to $3
                CMP.W       #$0004, D6          ; compare D5 with $4
                BEQ         jumpTo_0004         ; branch to jumpTo_0000 if D6 equals to $4
                CMP.W       #$0005, D6          ; compare D5 with $5
                BEQ         jumpTo_0005         ; branch to jumpTo_0000 if D6 equals to $5
                CMP.W       #$0006, D6          ; compare D5 with $6
                BEQ         jumpTo_0006         ; branch to jumpTo_0000 if D6 equals to $6
                CMP.W       #$0007, D6          ; compare D5 with $7
                BEQ         jumpTo_0007         ; branch to jumpTo_0000 if D6 equals to $7
                CMP.W       #$0008, D6          ; compare D5 with $8
                BEQ         jumpTo_0008         ; branch to jumpTo_0000 if D6 equals to $8
                CMP.W       #$0009, D6          ; compare D5 with $9
                BEQ         jumpTo_0009         ; branch to jumpTo_0000 if D6 equals to $9
                CMP.W       #$000A, D6          ; compare D5 with $A
                BEQ         jumpTo_000A         ; branch to jumpTo_0000 if D6 equals to $A
                CMP.W       #$000B, D6          ; compare D5 with $B
                BEQ         jumpTo_000B         ; branch to jumpTo_0000 if D6 equals to $B
                CMP.W       #$000C, D6          ; compare D5 with $C
                BEQ         jumpTo_000C         ; branch to jumpTo_0000 if D6 equals to $C
                CMP.W       #$000D, D6          ; compare D5 with $D
                BEQ         jumpTo_000D         ; branch to jumpTo_0000 if D6 equals to $D
                CMP.W       #$000E, D6          ; compare D5 with $E
                BEQ         jumpTo_000E         ; branch to jumpTo_0000 if D6 equals to $E
                CMP.W       #$000F, D6          ; compare D5 with $F
                BEQ         jumpTo_000F         ; branch to jumpTo_0000 if D6 equals to $F
                BRA         jumpTo_inv          ; branch to jumpTo_inv
****************************************************************************** 
jumpTo_NOP:     LEA         opcode_NOP, A1      ; display opcode_NOP
                MOVE.B      #14, D0
                TRAP        #15                 
                BRA         done_opcode         ; branch to done_opcode
                
jumpTo_RTS:     LEA         opcode_RTS, A1      ; display opcode_RTS
                MOVE.B      #14, D0
                TRAP        #15                
                BRA         done_opcode         ; branch to done_opcode
******************************************************************************                   
jumpTo_0000:    MOVE.W      D7, D6              ; copy D7 to D6             
                ROL.W       #8, D6              ; rotate D6 8 bits to left with size word
                ANDI.W      #$000F, D6          ; mask D6 with $000F
                CMPI.W      #$0006, D6          ; compare D6 with $6
                BEQ         jumpTo_ADDI         ; branch to jumpTo_ADDI if D6 equals to $6               
                BRA         jumpTo_inv  
                                        
jumpTo_ADDI:    MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1
               
                MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$2F80, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1          
                
                LEA         opcode_ADDI, A1     ; display opcode_ADDI
                MOVE.B      #14, D0
                TRAP        #15    
                MOVE.W      D7, D6              ; copy D7 to D6
                ROR.W       #6, D6              ; rotate D6 6 bits to right with size word
                ANDI.W      #$0007, D6          ; mask D6 with $7
                JSR         SIZE_MODE1          ; jump to subroutine SIZE_MODE1
                LEA         space_1, A1         ; display space_1
                MOVE.B      #14, D0
                TRAP        #15            
                JSR         IMM_
                LEA         comma, A1           ; display comma
                MOVE.B      #14, D0
                TRAP        #15    
                MOVE.W      D7, D6               
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                JSR         MODE_XN             ; jump to subroutine MODE_XN
                BRA         done_opcode         ; branch to done_opcode                
                
******************************************************************************  
jumpTo_0001:    BRA         jumpTo_MOVE  
******************************************************************************                  
jumpTo_0002:    MOVE.W      D7, D6              ; copy D7 to D6
                ROL.W       #7, D6              ; rotate D6 7 bits to left with size word
                ROL.W       #3, D6              ; rotate D6 3 bits to left with size word
                ANDI.W      #$0007, D6          ; mask D6 with $7
                CMPI.W      #$0001, D6          ; compare D6 with 1
                BEQ         jumpTo_MOVEA        ; branch to jumpTo_MOVEA if D6 equals to 1
                BRA         jumpTo_MOVE         ; branch to jumpTo_MOVE 
                
jumpTo_MOVEA:   MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1         
                
                LEA         opcode_MOVEA, A1    ; diaplay opcode_MOVEA
                MOVE.B      #14, D0
                TRAP        #15         
                MOVE.W      D7, D6              ; copy D7 to D6 
                ROL.W       #4, D6              ; rotate D6 4 bits to left with size word       
                ANDI.W      #$0003, D6          ; mask D6 with $3
                JSR         SIZE_MODE3          ; jump to subroutine SIZE_MODE3
                MOVE.W      D7, D6              ; copy D7 to D6     
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                JSR         MODE_XN             ; jump to subroutine MODE_XN
                LEA         comma, A1           ; display comma
                MOVE.B      #14, D0
                TRAP        #15
                MOVE.W      D7, D6              ; copy D7 to D6                   
                ROL.W       #7, D6              ; rotate D6 7 bits to left with size word
                ANDI.W      #$0007, D6          ; mask D6 with $7
                MOVE.B      D6, (regNum)        ; copy D6 TO (regNum)
                JSR         AN_                 ; jump to subroutine AN_
                BRA         done_opcode         ; branch to done_opcode

jumpTo_MOVE:    MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1
                
                MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$3FC0, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1          
                                
                MOVE.W      D7,D6               ; copy D7 to D6
                ROR.W       #6, D6              ; rotate D6 6 bits to right with size word
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_XNM          ; jump to subroutine CHK_EA_XNM
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1
                
                MOVE.W      D7,D6               ; copy D7 to D6
                ROR.W       #6, D6
                ANDI.W      #$007,D6            ; mode
                MOVE.W      D6, D5
                ROR.W       #3, D6
                ROL.W       #3, D5
                ADD.W       D5, D6
                ADDI.W      #$2F80, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1          
                
                LEA         opcode_MOVE, A1     ; display opcode_MOVE
                MOVE.B      #14, D0
                TRAP        #15     
                MOVE.W      D7, D6              ; copy D7 to D6              
                ROL.W       #4, D6              ; rotate D6 4 bits to left with size word       
                ANDI.W      #$0003, D6          ; mask D6 with $0003
                JSR         SIZE_MODE3          ; jump to subroutine SIZE_MODE3
                LEA         space_1, A1         ; display space_1
                MOVE.B      #14, D0
                TRAP        #15
                MOVE.W      D7, D6              ; copy D7 to D6                               
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                JSR         MODE_XN             ; jump to subroutine MODE_XN
                LEA         comma, A1           ; display comma
                MOVE.B      #14, D0
                TRAP        #15
                MOVE.W      D7, D6              ; copy D7 to D6                     
                ROR.W       #6, D6              ; rotate D6 6 bits to right with size word
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                JSR         XN_MODE             ; jump to subroutine XN_MODE
                BRA         done_opcode         ; branch to done_opcode                    
                 
******************************************************************************                  
jumpTo_0003:    MOVE.W      D7, D6              ; copy D7 to D6 
                ROL.W       #7, D6              ; rotate D6 7 bits to left with size word
                ROL.W       #3, D6              ; rotate D6 3 bits to left with size word 
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                CMPI.W      #$0001, D6          ; compare D6 with 1
                BEQ         jumpTo_MOVEA        ; branch to jumpTo_MOVEA if D6 equals to 1
                BRA         jumpTo_MOVE         ; branch to jumpTo_MOVE
               
******************************************************************************                  
jumpTo_0004:    CLR.L       D5              ; clear D5
                MOVE.W      D7,D6           ; copy D7 to D6
                ROR.W       #8,D6           ; rotate D6 8 bits to right with size word
                ANDI.W      #$000F,D6       ; mask D6 with $000F
                MOVE.W      D6,D5           ; make a copy of D6 into D5
                DIVU        #2,D5           ; divide D5 with 2
                SWAP        D5              ; swap D5
                CMPI.W      #0,D5           ; compare D5 with 0
                BEQ         jumpTo_even     ; branch to jumpTo_even if D5 is even or equals to 0
                MOVE.W      D7,D6           ; make a new copy of D7 into D6
                ROR.W       #6,D6           ; rotate D6 6 bits to right with size word
                ANDI.W      #0001,D6        ; mask D6 with $0001
                CMPI.B      #$0001,D6       ; compare D6 with $0001
                BEQ         jumpTo_LEA      ; branch to jumpTo_LEA if D6 equals to 1
                BRA         jumpTo_inv      ; branch to jumpTo_inv if D6 doesn't equal to 1
                
jumpTo_even:    CMPI.W      #$0008,D6       ; compare D6 with $0008
                BEQ         jumpTo_MOVEM    ; branch to jumpTo_MOVEM if D6 equals to 8
                CMPI.W      #$000C,D6       ; compare D6 with $000C  
                BEQ         jumpTo_MOVEM    ; branch to jumpTo_MOVEM if D6 equals to C
                
                MOVE.W      D7, D6              ; copy D7 to D6
                ROL.W       #8, D6              ; rotate D6 8 bits to left with size word        
                ANDI.W      #$000F, D6          ; mask D6 with $000F
                CMPI.W      #$0002, D6          ; compare D6 with $0002
                BEQ         jumpTo_CLR          ; branch to jumpTo_CLR if D6 equals to $0002
                               
                MOVE.W      D7, D6              ; copy D7 to D6             
                ROL.W       #4, D6              ; rotate D6 4 bits to left with size word
                ROL.W       #6, D6              ; rotate D6 6 bits to left with size word         
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                CMPI.W      #$003A, D6          ; compare D6 with $003A
                BEQ         jumpTo_JSR          ; branch to jumpTo_JSR if D6 equals to $003A
                BRA         jumpTo_inv 
         
jumpTo_CLR:     MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1
                
                MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$2F80, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1          
                
                LEA         opcode_CLR, A1      ; diaplay opcode_CLR
                MOVE.B      #14, D0
                TRAP        #15 
                MOVE.W      D7, D6              ; copy D7 to D6              
                ROR.W       #6, D6              ; rotate D6 6 bits to right with size word 
                ANDI.W      #$0003, D6          ; mask D6 with $0003
                JSR         SIZE_MODE1          ; jump to subroutine SIZE_MODE1
                LEA         space_2, A1         ; display space_2
                MOVE.B      #14, D0
                TRAP        #15
                MOVE.W      D7, D6              ; copy D7 to D6
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                JSR         MODE_XN             ; jump to subroutine MODE_XN
                BRA         done_opcode         ; branch to done_opcode   

jumpTo_JSR:     MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1
                
                MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$0980, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1                          

                LEA         opcode_JSR, A1      ; diaplay opcode_JSR
                MOVE.B      #14, D0
                TRAP        #15    
                LEA         space_2, A1         ; diaplay space_2
                MOVE.B      #14, D0
                TRAP        #15  
                MOVE.W      D7, D6              ; copy D7 to D6    
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                JSR         MODE_XN             ; jump to subroutine MODE_XN            
                BRA         done_opcode         ; branch to done_opcode  

jumpTo_MOVEM:   MOVE.W      D7,D6               ; copy D7 to D6
                ROR.W       #7,D6
                ANDI.W      #0007,D6
                CMPI.B      #$0,D6
                BEQ         jumpTo_inv
                MOVE.W      D7,D6               ; copy D7 to D6 
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1
                MOVE.W      D7,D6               ; copy D7 to D6 
                ROR.W       #3, D6
                ANDI.W      #$007,D6           ; mask D6 with $003F
                CMPI.B      #0, D6
                BEQ         jumpTo_inv          ; for exit
                MOVE.W      D7, D6              ; copy D7 to D6
                ROL.W       #6, D6              ; rotate D6 6 bits to left with size word
                ANDI.W      #$0001, D6          ; mask D6 with $0001
                CMPI.B      #0, D6
                BEQ         regToMem
                MOVE.W      D7,D6               ; copy D7 to D6 
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                ADDI.W      #$0D80, D6
                JSR         CHECK_EA         ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1
                BRA         valid_movem
                
regToMem:       MOVE.W      D7,D6               ; copy D7 to D6 
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                ADDI.W      #$0B80, D6
                JSR         CHECK_EA         ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1
                      
valid_movem:    LEA         opcode_MOVEM, A1    ; diaplay opcode_MOVEM
                MOVE.B      #14, D0
                TRAP        #15  
                MOVE.W      D7, D6              ; copy D7 to D6
                ROR.W       #6, D6              ; rotate D6 6 bits to right with size word          
                ANDI.W      #$0001, D6          ; mask D6 with $0001
                JSR         SIZE_MODE2          ; jump to subroutine SIZE_MODE2
                MOVE.W      D7, D6              ; copy D7 to D6
                ROL.W       #6, D6              ; rotate D6 6 bits to left with size word
                ANDI.W      #$0001, D6          ; mask D6 with $0001
                JSR         D_RED               ; jump to subroutine D_RED
                BRA         done_opcode         ; branch to done_opcode  
              
jumpTo_LEA:     MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1
                
                MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$0980, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1          
                
                LEA         opcode_LEA, A1      ; display opcode_LEA
                MOVE.B      #14, D0
                TRAP        #15
                LEA         space_2, A1         ; diaplay space_2
                MOVE.B      #14, D0
                TRAP        #15 
                MOVE.W      D7, D6              ; copy D7 to D6    
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                JSR         MODE_XN             ; jump to subroutine MODE_XN  
                LEA         comma, A1           ; diaplay comma
                MOVE.B      #14, D0
                TRAP        #15
                MOVE.W      D7, D6              ; copy D7 to D6
                ROR.W       #8, D6              ; rotate D6 8 bits to right with size word 
                ROR.W       #1, D6              ; rotate D6 1 bits to right with size word 
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                MOVE.B      D6, (regNum)        ; copy D6 to (redNum)
                JSR         AN_                 ; jump to subroutine AN_
                BRA         done_opcode         ; branch to done_opcode
                
******************************************************************************                    
jumpTo_0005:    MOVE.W      D7, D6              ; copy D7 to D6  
                ROL.W       #7, D6              ; rotate D6 7 bits to left with size word
                ROL.W       #3, D6              ; rotate D6 3 bits to left with size word        
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                CMPI.W      #$0003, D6          ; mask D6 with $0003 ********
                BLT         jumpTo_ADDQ         ; branch to jumpTo_ADDQ if D6 less than 3
                BRA         jumpTo_inv          ; branch to jumpTo_inv

jumpTo_ADDQ:    MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1
                
                MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$3F80, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1          
                
                LEA         opcode_ADDQ, A1     ; display opcode_ADDQ
                MOVE.B      #14, D0
                TRAP        #15 
                MOVE.W      D7, D6              ; copy D7 to D6              
                ROR.W       #6, D6              ; rotate D6 6 bits to right with size word 
                ANDI.W      #$0003, D6          ; mask D6 with $0003
                JSR         SIZE_MODE1          ; jump to subroutine SIZE_MODE1
                LEA         space_1, A1         ; diaplay space_1
                MOVE.B      #14, D0
                TRAP        #15                 
                MOVE.W      D7, D6              ; copy D7 to D6
                ROR.W       #8, D6              ; rotate D6 8 bits to right with size word
                ROR.W       #1, D6              ; rotate D6 1 bits to right with size word
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                JSR         DATA_               ; jump to subroutine DATA_
                LEA         comma, A1           ; diaplay comma
                MOVE.B      #14, D0
                TRAP        #15 
                MOVE.W      D7, D6              ; copy D7 to D6    
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                JSR         MODE_XN             ; jump to subroutine MODE_XN
                BRA         done_opcode         ; branch to done_opcode
 
******************************************************************************                  
jumpTo_0006:    MOVE.W      D7, D6              ; copy D7 to D6
                ROL.W       #8, D6              ; rotate D6 8 bits to left with size word                                      
                ANDI.W      #$000F, D6          ; mask D6 with $000F
*               CMPI.B      #$0001,D6           ; compare D6 with #$0001
*               BLE         update_Word          ; branch to update_Word if D6 is equals or less than 1
                CMPI.W      #$0004, D6          ; compare D6 with $0004
                BEQ         jumpTo_BCC          ; branch to jumpTo_BCC if D6 equals 4
                CMPI.W      #$000E, D6          ; compare D6 with $000E
                BEQ         jumpTo_BGT          ; branch to jumpTo_BGT if D6 equals E
                CMPI.W      #$000F, D6          ; compare D6 with $000F
                BEQ         jumpTo_BLE          ; branch to jumpTo_BLE if D6 equals F
                BRA         jumpTo_inv

jumpTo_BCC:     LEA         opcode_BCC, A1      ; display opcode_BCC
                MOVE.B      #14, D0
                TRAP        #15    
                BRA         displacement
                
jumpTo_BGT:     LEA         opcode_BGT, A1      ; diaplay opcode_BGT
                MOVE.B      #14, D0
                TRAP        #15       
                BRA         displacement
                
jumpTo_BLE:     LEA         opcode_BLE, A1      ; diaplay opcode_BLE
                MOVE.B      #14, D0
                TRAP        #15      
                BRA         displacement
                
displacement:   LEA         space_4, A1         ; display space_4
                MOVE.B      #14, D0
                TRAP        #15
                LEA         ea_absShort, A1     ; display ea_absShort
                MOVE.B      #14, D0
                TRAP        #15 
                MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$00FF,D6           ; mask D6 with $00FF
                CMPI.W      #$00,D6             ; mask D6 with $00
                BEQ         dis_16bits          ; branch to dis_16bits if D6 equals to $00
                CMPI.W      #$FF,D6             ; mask D6 with $FF
                BEQ         dis_32bits          ; branch to dis_32bits if D6 equals to $00   
                MOVEA.L     D6,A2               ; copy D6 to A2
                JSR         PRNT_BYTE           ; jump to subroutine PRNT_BYTE
                BRA         done_opcode         ; branch to done_opcode

dis_16bits:     MOVE.L      A6,A4
                LEA         (2,A4),A4
                MOVE.W      (A4),D6 
                MOVEA.L     D6,A2               ; copy D6 to A2 point to
                JSR         PRNT_WORD           ; jump to subroutine PRNT_WORD
                LEA         (2,A6),A6           ; A6 increase 2 bytes
                BRA         done_opcode         ; branch to done_opcode
                
dis_32bits:     MOVE.L      A6,A4
                LEA         (2,A4),A4
                MOVE.L      (A4),D6 
                MOVEA.L     D6,A2               ; copy D6 to A2 point to
                JSR         PRNT_LONG           ; jump to subroutine PRINTADDR
                LEA         (4,A6),A6           ; A6 increase 3 bytes
                BRA         done_opcode         ; branch to done_opcode
 
******************************************************************************                  
jumpTo_0007:    LEA         opcode_MOVEQ, A1    ; display opcode_MOVEQ
                MOVE.B      #14, D0
                TRAP        #15 
                LEA         space_2, A1         ; display space_2
                MOVE.B      #14, D0
                TRAP        #15     
                MOVE.W      D7, D6              ; copy D7 to D6              
                ANDI.W      #$00FF, D6          ; mask D6 with $00FF
                JSR         DATA_2              ; jump to subroutine DATA_2
                LEA         comma, A1           ; diaplay comma
                MOVE.B      #14, D0
                TRAP        #15
                MOVE.W      D7, D6              ; copy D7 to D6
                ROR.W       #8, D6              ; rotate D6 8 bits to right with size word 
                ROR.W       #1, D6              ; rotate D6 1 bits to right with size word 
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                MOVE.B      D6, (regNum)        ; copy D6 to (redNum)
                JSR         DN_                 ; jump to subroutine DN_
                BRA         done_opcode         ; branch to done_opcode 
******************************************************************************                  
jumpTo_0008:    MOVE.W      D7, D6              ; copy D7 to D6 
                ROL.W       #7, D6              ; rotate D6 7 bits to left with size word
                ROL.W       #3, D6              ; rotate D6 3 bits to left with size word                                
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                CMPI.W      #$0003, D6          ; compare D6 with $0003
                BEQ         jumpTo_DIVU         ; branch to jumpTo_DIVU if D6 equals to $0003
                CMPI.W      #$0007, D6 
                BEQ         jumpTo_inv 
                
                MOVE.W      D7, D6              ; copy D7 to D6  
                ROL.W       #7, D6              ; rotate D6 7 bits to left with size word
                ROL.W       #5, D6              ; rotate D6 5 bits to left with size word                              
                ANDI.W      #$001F, D6          ; mask D6 with $001F
                CMPI.W      #$0010, D6          ; compare D6 with $0010
                BNE         jumpTo_OR           ; branch to jumpTo_OR if D6 doesn't equal to $0010               
                BRA         jumpTo_inv          ; branch to jumpTo_inv              
                
jumpTo_DIVU:    MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to $1
                
                MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$2FC0, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1          
                
                LEA         opcode_DIVU, A1     ; display opcode_DIVU
                MOVE.B      #14, D0
                TRAP        #15    
                MOVE.W      D7, D6              ; copy D7 to D6 
                ROR.W       #6, D6              ; rotate D6 6 bits to right with size word
                ANDI.W      #$0003, D6          ; mask D6 with $0003
                JSR         SIZE_MODE3          ; jump to subroutine SIZE_MODE3 
                LEA         space_1, A1         ; display space_1
                MOVE.B      #14, D0
                TRAP        #15 
                MOVE.W      D7, D6              ; copy D7 to D6              
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                JSR         MODE_XN             ; jump to subroutine MODE_XN
                LEA         comma, A1           ; display comma
                MOVE.B      #14, D0
                TRAP        #15
                MOVE.W      D7, D6              ; copy D7 to D6 
                ROR.W       #8, D6              ; rotate D6 8 bits to right with size word 
                ROR.W       #1, D6              ; rotate D6 1 bits to right with size word 
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                MOVE.B      D6, (regNum)        ; copy D6 to (redNum)
                JSR         DN_                 ; jump to subroutine DN_
                BRA         done_opcode         ; branch to done_opcode      
                              
jumpTo_OR:      MOVE.W      D7,D6               ; copy D7 to D6 
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to $1
                MOVE.W      D7, D6              ; copy D7 to D6              
                ROR.W       #8, D6              ; rotate D6 8 bits to right with size word
                ANDI.W      #$0001, D6          ; mask D6 with $0001
                CMPI.B      #0, D6
                BEQ         check_or1           ; source
                CMPI.B      #1, D6
                BEQ         check_or2
                BRA         valid_or
                
check_or1:      MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$2F80, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1 
                BRA         valid_or
       
check_or2:      MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$0F80, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1 
                
valid_or:       LEA         opcode_OR, A1       ; display opcode_OR
                MOVE.B      #14, D0
                TRAP        #15     
                MOVE.W      D7, D6              ; copy D7 to D6            
                ROR.W       #6, D6              ; rotate D6 6 bits to right with size word 
                ANDI.W      #$0003, D6          ; mask D6 with $0003
                JSR         SIZE_MODE1          ; jump to subroutine SIZE_MODE1
                LEA         space_3, A1         ; display space_3
                MOVE.B      #14, D0
                TRAP        #15 
                MOVE.W      D7, D6              ; copy D7 to D6              
                ROR.W       #8, D6              ; rotate D6 8 bits to right with size word
                ANDI.W      #$0001, D6          ; mask D6 with $0001
                JSR         D_ORANGE            ; jump to subroutine D_ORANGE
                BRA         done_opcode         ; branch to done_opcode
                 
******************************************************************************                  
jumpTo_0009:    MOVE.W      D7, D6              ; copy D7 to D6          
                ROL.W       #7, D6              ; rotate D6 7 bits to left with size word
                ROL.W       #5, D6              ; rotate D6 5 bits to left with size word                     
                ANDI.W      #$001F, D6          ; mask D6 with $001F
                CMPI.W      #$0010, D6          ; compare D6 with $0010
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D6 equals to $0010
                CMPI.W      #$0014, D6          ; compare D6 with $0014
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D6 equals to $0014
                CMPI.W      #$0018, D6          ; compare D6 with $0018
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D6 equals to $0018
                BRA         jumpTO_SUB          ; branch to jumpTo_SUB
                             
jumpTo_SUB:     MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; mask D3 with $0001
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to $0001
                MOVE.W      D7,D6                
                ROR.W       #6, D6
                ANDI.W      #$0003, D6
                CMPI.B      #$003, D6
                BEQ         jumpTo_inv
                MOVE.W      D7, D6              ; copy D7 to D6
                ROR.W       #8, D6              ; rotate D6 8 bits to right with size word
                ANDI.W      #$0001, D6          ; mask D6 with $0001
                CMPI.B      #1, D6
                BEQ         check_sub
                
                MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$3F80, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1 
                
                MOVE.W      D7,D6               ; copy D7 to D6
                ROR.W       #3, D6
                ANDI.W      #$007,D6 
                CMPI.B      #1, D6
                BEQ         sub_a_not_byte               
                BRA         valid_sub
                
sub_a_not_byte: MOVE.W      D7,D6               ; copy D7 to D6
                ROR.W       #6, D6
                ANDI.W      #$003,D6 
                CMPI.B      #0, D6
                BEQ         jumpTo_inv               
                BRA         valid_sub
                
check_sub:      MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$0F80, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1 
                
valid_sub:      LEA         opcode_SUB, A1      ; display opcode_SUB
                MOVE.B      #14, D0
                TRAP        #15                
                MOVE.W      D7, D6              ; copy D7 to D6       
                ROR.W       #6, D6              ; rotate D6 6 bits to right with size word
                ANDI.W      #$0003, D6          ; mask D6 with $0003
                JSR         SIZE_MODE1          ; jump to subroutine SIZE_MODE1
                LEA         space_2, A1         ; display space_2
                MOVE.B      #14, D0
                TRAP        #15 
                MOVE.W      D7, D6              ; copy D7 to D6              
                ROR.W       #8, D6              ; rotate D6 8 bits to right with size word
                ANDI.W      #$0001, D6          ; mask D6 with $0001
                JSR         D_ORANGE            ; jump to subroutine D_ORANGE
                BRA         done_opcode         ; branch to done_opcode 
******************************************************************************                  
jumpTo_000A:    BRA         jumpTo_inv
******************************************************************************                  
jumpTo_000B:    MOVE.W      D7, D6              ; copy D7 to D6 
                ROL.W       #8, D6              ; rotate D6 8 bits to left with size word                           
                ANDI.W      #$0001, D6          ; mask D6 with $0001 
                CMPI.W      #$0000, D6          ; compare D6 with $0000
                BEQ         jumpTo_CMP          ; branch to jumpTo_CMP if D6 equals to $0000
                BRA         jumpTo_inv          ; branch to jumpTo_inv                
                                
jumpTo_CMP:     MOVE.W      D7,D6               ; copy D7 to D6
                ROR.W       #6,D6
                ANDI.W      #0007,D6
                CMPI.B      #3,D6
                BEQ         jumpTo_inv
               
                MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; mask D3 with $0001
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to $0001
                
                MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$3F80, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1          
                
                LEA         opcode_CMP, A1      ; display opcode_CMP
                MOVE.B      #14, D0
                TRAP        #15       
                MOVE.W      D7, D6              ; copy D7 to D6 
                ROR.W       #6, D6              ; rotate D6 8 bits to right with size word
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                JSR         SIZE_MODE1          ; jump to subroutine SIZE_MODE1
                LEA         space_2, A1         ; display space_2
                MOVE.B      #14, D0
                TRAP        #15     
                MOVE.W      D7, D6              ; copy D7 to D6
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                JSR         MODE_XN             ; jump to subroutine MODE_XN
                LEA         comma, A1           ; display comma
                MOVE.B      #14, D0
                TRAP        #15
                MOVE.W      D7, D6              ; copy D7 to D6
                ROR.W       #8, D6              ; rotate D6 8 bits to right with size word
                ROR.W       #1, D6              ; rotate D6 1 bits to right with size word
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                MOVE.B      D6, (regNum)        ; copy D6 to (redNum)
                JSR         DN_                 ; jump to subroutine DN_
                BRA         done_opcode         ; branch to done_opcode                   
******************************************************************************                  
jumpTo_000C:    MOVE.W      D7, D6              ; copy D7 to D6
                ROL.W       #7, D6              ; rotate D6 7 bits to left with size word 
                ROL.W       #3, D6              ; rotate D6 3 bits to left with size word                       
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                CMPI.W      #$0007, D6          ; compare D6 with $0007
                BEQ         jumpTo_MULS         ; branch to jumpTo_MULS if D6 equals to $0007
                CMPI.W      #$003, D6
                BEQ         jumpTo_inv
                MOVE.W      D7, D6              ; copy D7 to D6
                ROL.W       #7, D6              ; rotate D6 7 bits to left with size word 
                ROL.W       #5, D6              ; rotate D6 3 bits to left with size word                       
                ANDI.W      #$0001F, D6
                CMPI.W      #$0010, D6          ; compare D6 with $0004
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D6 equals to $0004
                
                MOVE.W      D7, D6              ; copy D7 to D6
                ROL.W       #7, D6              ; rotate D6 7 bits to left with size word 
                ANDI.W      #$0001, D6
                CMPI.B      #1, D6
                BEQ         next_exgcheck
                BRA         jumpTo_AND 
next_exgcheck:  MOVE.W      D7, D6              ; copy D7 to D6
                ROL.W       #7, D6              ; rotate D6 7 bits to left with size word 
                ROL.W       #5, D6              ; rotate D6 5 bits to left with size word                       
                ANDI.W      #$0003, D6          ; mask D6 with $0003
                CMPI.W      #$0000, D6          ; compare D6 with $0000
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D6 equals to $0000
                BRA         jumpTo_AND          ; branch to jumpTo_AND

jumpTo_MULS:    MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; mask D3 with $0001
                
                MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$2FC0, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1          
                
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to $0001
                LEA         opcode_MULS, A1     ; display opcode_MULS
                MOVE.B      #14, D0
                TRAP        #15   

                MOVE.W      D7, D6              ; copy D7 to D6 
                ROR.W       #6, D6              ; rotate D6 6 bits to right with size word
                ANDI.W      #$0003, D6          ; mask D6 with $0003
                JSR         SIZE_MODE3          ; jump to subroutine SIZE_MODE3 
                LEA         space_1, A1         ; display space_1
                MOVE.B      #14, D0
                TRAP        #15
                 
                MOVE.W      D7, D6              ; copy D7 to D6               
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                JSR         MODE_XN             ; jump to subroutine MODE_XN
                LEA         comma, A1           ; display comma
                MOVE.B      #14, D0
                TRAP        #15
                MOVE.W      D7, D6              ; copy D7 to D6
                ROR.W       #8, D6              ; rotate D6 8 bits to right with size word
                ROR.W       #1, D6              ; rotate D6 1 bits to right with size word
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                MOVE.B      D6, (regNum)        ; copy D6 to (redNum)
                JSR         DN_                 ; jump to subroutine DN_
                BRA         done_opcode         ; branch to done_opcode 

jumpTo_AND:     MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; mask D3 with $0001
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to $0001
                MOVE.W      D7, D6               
                ROR.W       #8, D6              ; rotate D6 8 bits to right with size word
                ANDI.W      #$0001, D6          ; mask D6 with $0001
                CMPI.B      #0, D6
                BEQ         check_and1          ; source
                CMPI.B      #1, D6
                BEQ         check_and2
                BRA         valid_and
check_and1:     MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$2F80, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1 
                BRA         valid_and
       
check_and2:     MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$0F80, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1 
               
valid_and:      LEA         opcode_AND, A1      ; display opcode_AND
                MOVE.B      #14, D0
                TRAP        #15  
                MOVE.W      D7, D6              ; copy D7 to D6
                ROR.W       #6, D6              ; rotate D6 6 bits to right with size word
                ANDI.W      #$0003, D6          ; mask D6 with $0003
                JSR         SIZE_MODE1          ; jump to subroutine SIZE_MODE1
                LEA         space_2, A1         ; display space_2
                MOVE.B      #14, D0
                TRAP        #15 
                MOVE.W      D7, D6              ; copy D7 to D6              
                ROR.W       #8, D6              ; rotate D6 8 bits to right with size word
                ANDI.W      #$0001, D6          ; mask D6 with $0001
                JSR         D_ORANGE            ; jump to subroutine D_ORANGE
                BRA         done_opcode         ; branch to done_opcode
                  
******************************************************************************                  
jumpTo_000D:    MOVE.W      D7, D6              ; copy D7 to D6  
                ROL.W       #8, D6              ; rotate D6 8 bits to left with size word
                ROL.W       #2, D6              ; rotate D6 2 bits to left with size word                       
                ANDI.W      #$0003, D6          ; mask D6 with $0003
                CMPI.W      #$0003, D6          ; compare D6 with $0003
                BEQ         jumpTo_ADDA         ; branch to jumpTo_ADDA if D6 equals to $0003
                
                MOVE.W      D7, D6              ; copy D7 to D6 
                ROL.W       #7, D6              ; rotate D6 7 bits to left with size word
                ROL.W       #5, D6              ; rotate D6 5 bits to left with size word                        
                ANDI.W      #$001F, D6          ; mask D6 with $001F
                CMPI.W      #$0014, D6          ; compare D6 with $0014
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D6 equals to $0014
                CMPI.W      #$0018, D6          ; compare D6 with $0018
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D6 equals to $0018
                BRA         jumpTo_ADD          ; branch to jumpTo_ADD

jumpTo_ADD:     MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; mask D3 with $0001
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to $0001
                MOVE.W      D7, D6              ; copy D7 to D6 
                ROR.W       #8, D6              ; rotate D6 8 bits to right with size word
                ANDI.W      #$0001, D6          ; mask D6 with $0001
                CMPI.B      #0, D6              ; destination
                BEQ         check_add1
                CMPI.B      #1, D6              ; destination
                BEQ         check_add2
                BRA         valid_add
                
add_a_not_byte: MOVE.W      D7,D6               ; copy D7 to D6
                ROR.W       #6, D6
                ANDI.W      #$003,D6 
                CMPI.B      #0, D6
                BEQ         jumpTo_inv               
                BRA         valid_sub
                                
check_add1:     MOVE.W      D7,D6               ; copy D7 to D6
                ROR.W       #3, D6
                ANDI.W      #$007,D6 
                CMPI.B      #$1, D6
                BEQ         add_a_not_byte  
                MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$03F,D6 
                CMPI.B      #$3C, D6
                BEQ         jumpTo_ADDI 

                MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$3F80, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv
                BRA         valid_add
       
check_add2:     MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$0F80, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv  

valid_add:      LEA         opcode_ADD, A1      ; display opcode_ADD
                MOVE.B      #14, D0
                TRAP        #15    
                MOVE.W      D7, D6              ; copy D7 to D6 
                ROR.W       #6, D6              ; rotate D6 6 bits to right with size word
                ANDI.W      #$0003, D6          ; mask D6 with $0003
                JSR         SIZE_MODE1          ; jump to subroutine SIZE_MODE1
                LEA         space_2, A1         ; display space_2
                MOVE.B      #14, D0
                TRAP        #15                 ; branch to jumpTo_inv if D3 equals to 1 
                MOVE.W      D7, D6              ; copy D7 to D6              
                ROR.W       #8, D6              ; rotate D6 8 bits to right with size word
                ANDI.W      #$0001, D6          ; mask D6 with $0001
                JSR         D_ORANGE            ; jump to subroutine D_ORANGE
                BRA         done_opcode         ; branch to done_opcode

jumpTo_ADDA:    MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; mask D3 with $0001
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to $0001
           
                LEA         opcode_ADDA, A1     ; display opcode_ADDA
                MOVE.B      #14, D0
                TRAP        #15     
                MOVE.W      D7, D6              ; copy D7 to D6 
                ROR.W       #8, D6              ; rotate D6 8 bits to right with size word
                ANDI.W      #$0001, D6          ; mask D3 with $0001
                JSR         SIZE_MODE2          ; jump to subroutine SIZE_MODE2
                LEA         space_1, A1         ; display space_1
                MOVE.B      #14, D0
                TRAP        #15      
                MOVE.W      D7, D6              ; copy D7 to D6   
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                JSR         MODE_XN             ; jump to subroutine MODE_XN
                LEA         comma, A1           ; display comma
                MOVE.B      #14, D0
                TRAP        #15
                MOVE.W      D7, D6              ; copy D7 to D6
                ROR.W       #8, D6              ; rotate D6 8 bits to right with size word
                ROR.W       #1, D6              ; rotate D6 1 bits to right with size word
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                MOVE.B      D6, (regNum)        ; copy D6 to (redNum)
                JSR         AN_                 ; jump to subroutine AN_
                BRA         done_opcode         ; branch to done_opcode
 
******************************************************************************   
jumpTo_000E:    MOVE.W      D7, D6              ; copy D7 to D6
                ROR.W       #6, D6              ; rotate D6 6 bits to right with size word
                ANDI.W      #$0003, D6          ; mask D6 with $0003
                CMPI.B      #3, D6              ; mask D6 with $0003
                BEQ         mem_shift           ; branch to mem_shift if D6 equals to $0003
                 
reg_shift:      MOVE.W      D7,D6               ; copy D7 to D6
                ROR.W       #3,D6               ; rotate D6 3 bits to right with size word
                ANDI.W      #0003,D6            ; mask D6 with $0003
                CMPI.W      #0000,D6            ; compare D6 with $0000
                BEQ         jumpTo_AS_R           ; branch to jumpTo_AS if D6 equals to $0000
                CMPI.W      #0001,D6            ; compare D6 with $0001
                BEQ         jumpTo_LS_R           ; branch to jumpTo_LS if D6 equals to $0001
                CMPI.W      #0003,D6            ; compare D6 with $0003
                BEQ         jumpTo_RO_R           ; branch to jumpTo_RO if D6 equals to $0003
                BRA         jumpTo_inv          ; branch to jumpTo_inv
                
                
mem_shift:      MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with $003F
                JSR         CHK_EA_MXN          ; jump to subroutine CHK_EA_MXN
                CMPI.B      #1, D3              ; mask D3 with $0001
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to $0001
                MOVE.W      D7, D6              ; copy D7 to D6
                ROL.W       #7, D6              ; rotate D6 7 bits to left with size word                        
                ANDI.W      #$0003, D6          ; mask D6 with $0003
                CMPI.W      #$0000, D6          ; compare D6 with $0000
                BEQ         jumpTo_AS           ; branch to jumpTo_AS if D6 equals to $0000
                CMPI.W      #$0001, D6          ; compare D6 with $0001
                BEQ         jumpTo_LS           ; branch to jumpTo_LS if D6 equals to $0001
                CMPI.W      #$0003, D6          ; compare D6 with $0003
                BEQ         jumpTo_RO           ; branch to jumpTo_RO if D6 equals to $0003  
                BRA         jumpTo_inv          ; branch to jumpTo_inv
                                
jumpTo_AS:      MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$0F80, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1                          
jumpTo_AS_R:    LEA         opcode_AS, A1       ; display opcode_AS
                MOVE.B      #14, D0
                TRAP        #15             
                BRA         dir_mem             ; branch to dir_mem 

jumpTo_LS:      MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$0F80, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1          
jumpTo_LS_R:    LEA         opcode_LS, A1       ; display opcode_LS
                MOVE.B      #14, D0
                TRAP        #15      
                BRA         dir_mem             ; branch to dir_mem

jumpTo_RO:      MOVE.W      D7,D6               ; copy D7 to D6
                ANDI.W      #$003F,D6           ; mask D6 with #003F
                ADDI.W      #$0F80, D6          
                JSR         CHECK_EA
                CMPI.B      #1, D3              ; compare D3 with 1
                BEQ         jumpTo_inv          ; branch to jumpTo_inv if D3 equals to 1                          
jumpTo_RO_R:    LEA         opcode_RO, A1       ; display opcode_RO
                MOVE.B      #14, D0
                TRAP        #15     
                BRA         dir_mem             ; branch to dir_mem 
                
dir_mem:        MOVE.W      D7, D6              ; copy D7 to D6
                ROL.W       #8, D6              ; rotate D6 8 bits to left with size word
                ANDI.W      #$0001, D6          ; mask D6 with $0001
                JSR         D_GREEN             ; jump to subroutine D_GREEN
                MOVE.W      D7,D6               ; copy D7 to D6
                ROR.W       #6,D6               ; rotate D6 6 bits to right with size word
                ANDI.W      #0003,D6            ; mask D6 with $0003
                MOVE.W      D6,D5               ; copy D6 to D5
                CMPI.W      #0003,D6            ; compare D6 with $0003
                BEQ         PRINT_MODE_XN       ; branch to PRINT_MODE_XN if D6 equals to $0003
                JSR         SIZE_MODE1          ; jump to subroutine SIZE_MODE1
                LEA         space_2, A1         ; display space_2
                MOVE.B      #14, D0
                TRAP        #15 
                MOVE.W      D5,D6               ; copy D5 to D6
                CMPI.W      #3,D6               ; compare D6 with $0003
                JSR         M_BLUE              ; jump to subroutine M_BLUE
                LEA         comma, A1           ; display comma
                MOVE.B      #14, D0
                TRAP        #15
                MOVE.W      D7, D6              ; copy D7 to D6
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                MOVE.B      D6, (regNum)        ; copy D6 to (redNum)
                JSR         DN_                 ; jump to subroutine DN_
                BRA         done_opcode         ; branch to done_opcode              

PRINT_MODE_XN:  MOVE.W      D7,D6               ; copy D7 to D6
                ROR.W       #6,D6               ; rotate D6 6 bits to right with size word
                ANDI.W      #3,D6               ; mask D6 with $0003
                JSR         SIZE_MODE3          ; jump to subroutine SIZE_MODE3
                LEA         space_2, A1         ; display space_2
                MOVE.B      #14, D0
                TRAP        #15 
                MOVE.W      D7, D6              ; copy D7 to D6
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                JSR         MODE_XN             ; jump to subroutine MODE_XN
                BRA         done_opcode         ; branch to done_opcode        
             
******************************************************************************                  
jumpTo_000F:    BRA         jumpTo_inv               
******************************************************************************
******************************************************************************
jumpTo_inv:     LEA         inv_opcode, A1      ; display inv_opcode
                MOVE.B      #9, D1  
                MOVE.B      #1, D0         
                TRAP        #15
                LEA         ea_absShort, A1
                MOVE.B      #14, D0         
                TRAP        #15   
                MOVEA.L     D7, A2              ; copy D7 to (A2)
                JSR         PRNT_WORD2           ; jump to subroutine PRNT_WORD
                
done_opcode:    LEA         endl, A1            ; display a empty line
                MOVE.B      #14, D0
                TRAP        #15
                LEA         (2,A6),A6           ; A6 increase 2 bytes
                MOVEM.L     (SP)+, A1-A2/D0-D3   
                RTS
******************************************************************************  
*******************************************************************************
PRNT_WORD2:     MOVEM.L     D0-D3, -(SP)
                LEA         printLocation, A1   ; display printLocation
                CLR.L       (A1)
                CLR         D1
                MOVE.W      A2, D1
                CLR.L       D3
                CLR         D2
              
w2_checkChar:   ADDI.B      #1, D2              ; add D2 with 1
                CMPI.B      #4, D2              ; compare D2 with 4
                BGT         w2_done_print        ; branch to w_done_print if D2 is greater than 4
                ROL.W       #4, D1              ; roate D1 4 bits to left with size word
                MOVE.B      D1, D3              ; copy D1 to D3
                ANDI.B      #%00001111, D3      ; mask D3 with $0F
                CMPI.B      #$9, D3             ; compare D3 with $9
                BGT         w2_addrIsLet         ; branch to w_addrIsLet if D3 is greater than $9
                
w2_addrIsNum:   ADDI.B      #$30, D3            ; add D3 with $30
                BRA         w2_saveChar          ; branch to w_saveChar
                
w2_addrIsLet:   ADDI.B      #$37, D3            ; add D3 with $37
                BRA         w2_saveChar          ; branch to w_saveChar
                                
w2_saveChar:    MOVE.B      D3, (A1)+           ; copy D3 to (A1)+
                BRA         w2_checkChar         ; branch to w_checkChar

w2_done_print:  LEA         printLocation, A1
                MOVE.W      #4, D1
                MOVE.B      #1, D0
                TRAP        #15
                
                MOVEM.L     (SP)+, D0-D3
                RTS 
 
                   
























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
