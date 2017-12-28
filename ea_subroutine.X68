            
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
*   D3: Flag for invalid for ea
*   D4: Opcode size
*   D5: Register number
*   D6: Bit manipulator
*   D7: Data                            
*******************************************************************************
SIZE_MODE1:     CMPI.B      #$00, D6            ; compare D6 with $00
                BEQ         byteSizeM1          ; branch to byteSizeM1 if D6 equals to 0
                CMPI.B      #$01, D6            ; compare D6 with $01
                BEQ         wordSizeM1          ; branch to wordSizeM1 if D6 equals to $01
                CMPI.B      #$02, D6            ; compare D6 with $02
                BEQ         longSizeM1          ; branch to longSizeM1 if D6 equals to $02
                
byteSizeM1:     JSR         BYTE_               ; jump to subroutine BYTE_
                BRA         done_size1          ; branch to done_size1

wordSizeM1:     JSR         WORD_               ; jump to subroutine WORD_
                BRA         done_size1          ; branch to done_size1

longSizeM1:     JSR         LONG_               ; jump to subroutine LONG_
                                    
done_size1:     CLR         D6                  ; clear D6
                RTS                 
*******************************************************************************               
SIZE_MODE2:     CMPI.B      #$0, D6             ; compare D6 with $0
                BEQ         wordSizeM2          ; branch to wordSizeM2 if D6 equals to 0
                CMPI.B      #$1, D6             ; compare D6 with $01
                BEQ         longSizeM2          ; branch to longSizeM2 if D6 equals to $1
                
wordSizeM2:     JSR         WORD_               ; jump to subroutine WORD_
                BRA         done_size2          ; branch to done_size2

longSizeM2:     JSR         LONG_               ; jump to subroutine LONG_
 
done_size2:     CLR         D6                  ; clear D6
                RTS
*******************************************************************************  
SIZE_MODE3:     CMPI.B      #$01, D6            ; compare D6 with $01
                BEQ         byteSizeM3          ; branch to byteSizeM2 if D6 equals to 0
                CMPI.B      #$03, D6            ; compare D6 with $03
                BEQ         wordSizeM3          ; branch to wordSizeM3 if D6 equals to $03
                CMPI.B      #$02, D6            ; compare D6 with $02
                BEQ         longSizeM3          ; branch to longSizeM3 if D6 equals to $02
                
byteSizeM3:     JSR         BYTE_               ; jump to subroutine BYTE_
                BRA         done_size3          ; branch to done_size3

wordSizeM3:     JSR         WORD_               ; jump to subroutine WORD_
                BRA         done_size3          ; branch to done_size3

longSizeM3:     JSR         LONG_               ; jump to subroutine LONG_
                    
done_size3:     CLR         D6                  ; clear D6
                RTS                
******************************************************************************* 
BYTE_:          LEA         printByte, A1       ; display printByte
                MOVE.B      #14, D0
                TRAP        #15
                MOVE.B      #0, D4 
                RTS

WORD_:          LEA         printWord, A1       ; display printWord
                MOVE.B      #14, D0
                TRAP        #15  
                MOVE.B      #1, D4 
                RTS

LONG_:          LEA         printLong, A1       ; display printLong
                MOVE.B      #14, D0
                TRAP        #15 
                MOVE.B      #2, D4 
                RTS             
******************************************************************************* 
MODE_XN:        MOVE.W      D6, D5              ; copy D6 to D5
                ANDI.W      #$0007, D5          ; mask D5 with $0007 
                MOVE.B      D5, (regNum)        ; copy D5 to (regNum)
                ROR.W       #3, D6              ; rotate D6 3 bits to right with size word
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                CMPI.B      #7, D6              ; compare D6 with 7
                BEQ         other_mode_xn       ; branch to other_mode_xn if D6 equals to 7
                                
                CMPI.B      #$000, D6           ; compare D6 with $000
                BEQ         dataReg             ; branch to dataReg if D6 equals to 0
                CMPI.B      #$001, D6           ; compare D6 with $001
                BEQ         addrReg             ; branch to addrReg if D6 equals to $001

                CMPI.B      #$002, D6           ; compare D6 with $002
                BEQ         addrIndirect        ; branch to addrIndirect if D6 equals to 0
                CMPI.B      #$003, D6           ; compare D6 with $003
                BEQ         addrPostInc         ; branch to addrPostInc if D6 equals to 0
                CMPI.B      #$004, D6           ; compare D6 with $004
                BEQ         addrPreDec          ; branch to addrPreDec if D6 equals to 0
                MOVE.B      #1, D3              ; copy 1 to D3
                        
dataReg:        JSR         DN_                 ; jump to subroutine DN_
                BRA         done_mode_xn        ; branch to done_mode_xn
                      
addrReg:        JSR         AN_                 ; jump to subroutine AN_
                BRA         done_mode_xn        ; branch to done_mode_xn

addrIndirect:   JSR         AINDIRECT_          ; jump to subroutine AINDIRECT_
                BRA         done_mode_xn        ; branch to done_mode_xn

addrPostInc:    JSR         APOSTINC_           ; jump to subroutine APOSTINC_
                BRA         done_mode_xn        ; branch to done_mode_xn

addrPreDec:     JSR         APREDEC_            ; jump to subroutine APREDEC_
                BRA         done_mode_xn        ; branch to done_mode_xn
  
other_mode_xn:  CMPI.B      #$000, D5           ; compare D5 with $000
                BEQ         absShort            ; branch to absShort if D5 equals to 0
                CMPI.B      #$001, D5           ; compare D5 with $001
                BEQ         absLong             ; branch to absLong if D5 equals to $001
                CMPI.B      #$004, D5           ; compare D5 with $004
                BEQ         immediate_ea        ; branch to immediate_ea if D5 equals to $004
                MOVE.B      #1, D3              ; copy 3 to D3      
                
absShort:       JSR         ABSSHORT_           ; jump to subroutine ABSSHORT_
                BRA         done_mode_xn        ; branch to done_mode_xn

absLong:        JSR         ABSLONG_            ; jump to subroutine ABSLONG_
                BRA         done_mode_xn        ; branch to done_mode_xn

immediate_ea:   JSR         IMM_                ; jump to subroutine IMM_
                              
done_mode_xn:   CLR         D5                  ; clear D5
                CLR         D6                  ; clear D6
                RTS
                            
******************************************************************************* 
XN_MODE:        MOVE.W      D6, D5              ; copy D6 to D5
                ROR.W       #3, D5              ; rotate D5 3 bits to right with size word
                ANDI.W      #$0007, D5          ; mask D5 with $0007
                MOVE.B      D5, (regNum)        ; copy D5 to (regNum)
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                CMPI.B      #7, D6              ; compare D6 with 7    
                BEQ         other_xn_mode       ; branch to other_mode_xn if D6 equals to 7

                CMPI.B      #$000, D6           ; compare D6 with $000
                BEQ         dataReg2            ; branch to dataReg2 if D6 equals to $000
                CMPI.B      #$001, D6           ; compare D6 with $001
                BEQ         addrReg2            ; branch to addrReg2 if D6 equals to $001
                CMPI.B      #$002, D6           ; compare D6 with $002
                BEQ         addrIndirect2       ; branch to addrIndirect2 if D6 equals to $002
                CMPI.B      #$003, D6           ; compare D6 with $003
                BEQ         addrPostInc2        ; branch to addrPostInc2 if D6 equals to $003
                CMPI.B      #$004, D6           ; compare D6 with $004
                BEQ         addrPreDec2         ; branch to addrPreDec2 if D6 equals to $004
                MOVE.B      #1, D3              ; flag for invalid ea     
                                           
dataReg2:       JSR         DN_                 ; jump to subroutine DN_
                BRA         done_mode_xn        ; branch to done_mode_xn
                      
addrReg2:       JSR         AN_                 ; jump to subroutine 
                BRA         done_mode_xn        ; branch to done_mode_xn

addrIndirect2:  JSR         AINDIRECT_          ; jump to subroutine 
                BRA         done_mode_xn        ; branch to done_mode_xn

addrPostInc2:   JSR         APOSTINC_           ; jump to subroutine 
                BRA         done_mode_xn        ; branch to done_mode_xn

addrPreDec2:    JSR         APREDEC_            ; jump to subroutine 
                BRA         done_mode_xn        ; branch to done_mode_xn
  
other_xn_mode:  CMPI.B      #$000, D5           ; compare D5 with $000
                BEQ         absShort2           ; branch to absShort2 if D5 equals to 0
                CMPI.B      #$001, D5           ; compare D5 with $001
                BEQ         absLong2            ; branch to absLong2 if D5 equals to $001
                CMPI.B      #$004, D5           ; compare D5 with $004
                BEQ         immediate_ea2       ; branch to immediate_ea2 if D5 equals to $004
                MOVE.B      #1, D3              ; flag for invalid ea
                
absShort2:      JSR         ABSSHORT_           ; jump to subroutine ABSSHORT_
                BRA         done_mode_xn        ; branch to done_mode_xn
    
absLong2:       JSR         ABSLONG_            ; jump to subroutine ABSLONG_
                BRA         done_mode_xn        ; branch to done_mode_xn
    
immediate_ea2:  JSR         IMM_                ; jump to subroutine IMM_       
                   
done_xn_mode:   CLR         D5                  ; clear D5
                CLR         D6                  ; clear D6
                RTS
******************************************************************************* 
DN_:            MOVEM.W     D0-D1/D6, -(SP)
                LEA         ea_dataReg, A1      ; print ea_dataReg  
                MOVE.B      #14, D0
                TRAP        #15
                LEA         regNum, A1          ; print regNum
                ADDI.B      #$30, (regNum)
                MOVE.W      #1, D1
                MOVE.B      #1, D0
                TRAP        #15
                CLR         D6
                MOVEM.W     (SP)+, D0-D1/D6
                RTS
                
AN_:            MOVEM.W     D0-D1/D6, -(SP)
                LEA         ea_addrReg, A1      ; print ea_addrReg
                MOVE.B      #14, D0
                TRAP        #15
                LEA         regNum, A1          ; print regNum
                ADDI.B      #$30, (regNum)
                MOVE.W      #1, D1
                MOVE.B      #1, D0
                TRAP        #15
                CLR         D6
                MOVEM.W     (SP)+, D0-D1/D6
                RTS
                
AINDIRECT_:     LEA         ea_addrInd, A1      ; print ea_addrInd
                MOVE.B      #14, D0
                TRAP        #15
                LEA         regNum, A1          ; print regNum
                ADDI.B      #$30, (regNum)
                MOVE.W      #1, D1
                MOVE.B      #1, D0
                TRAP        #15
                LEA         ea_addrInd2, A1     ; print ea_addrInd2   
                MOVE.B      #14, D0
                TRAP        #15
                CLR         D6
                RTS
                 
APOSTINC_:      LEA         ea_addrPost, A1     ; print ea_addrPost
                MOVE.B      #14, D0
                TRAP        #15
                LEA         regNum, A1          ; print regNum
                ADDI.B      #$30, (regNum)
                MOVE.W      #1, D1
                MOVE.B      #1, D0
                TRAP        #15
                LEA         ea_addrPost2, A1    ; print ea_addrPost2   
                MOVE.B      #14, D0
                TRAP        #15  
                CLR         D6
                RTS        
  
APREDEC_:       LEA         ea_addrPre, A1      ; print ea_addrPre
                MOVE.B      #14, D0
                TRAP        #15
                LEA         regNum, A1          ; print regNum
                ADDI.B      #$30, (regNum)
                MOVE.W      #1, D1
                MOVE.B      #1, D0
                TRAP        #15
                LEA         ea_addrPre2, A1     ; print ea_addrPre2
                MOVE.B      #14, D0
                TRAP        #15 
                CLR         D6
                RTS
                
ABSSHORT_:      LEA         ea_absShort, A1     ; print ea_absShort
                MOVE.B      #14, D0
                TRAP        #15
                MOVEA.L     A6, A4              ; copy A6 to A4
                LEA         (2,A4),A4           ; increase A4 with 2 bytes
                MOVE.L      (A4), D1            ; copy (A4) to D1
                ROR.L       #8, D1              ; roate D1 8 bits to right with size long
                ROR.L       #8, D1              ; roate D1 8 bits to right with size long
                MOVEA.L     D1, A2              
                JSR         PRNT_WORD           ; jump to subroutine PRNT_WORD
                LEA         (2,A6),A6           ; increase A6 with 2 bytes
                CLR         D6
                RTS
                
ABSLONG_:       LEA         ea_absLong, A1      ; print ea_absLong   
                MOVE.B      #14, D0
                TRAP        #15
                MOVEA.L     A6, A4              ; copy A6 to A4
                LEA         (2,A4),A4           ; increase A4 with 2 bytes
                MOVEA.L     (A4), A2            ; copy (A4) to A2
                JSR         PRNT_LONG           ; jump to subroutine PRINTADDR
                LEA         (4,A6),A6           ; increase A6 with 4 bytes
                CLR         D6
                RTS
                
IMM_:           LEA         ea_immediate, A1    ; print ea_immediate
                MOVE.B      #14, D0
                TRAP        #15    
                MOVEA.L     A6, A4              ; copy A6 to A4
                LEA         (2,A4),A4           ; increase A4 with 2 bytes
                MOVE.L      (A4), D1            ; copy (A4) to D1
                        
                CMPI.B      #0, D4              ; compare D4 with 0
                BEQ         prnt_Imm_byte       ; branch to prnt_Imm_byte if D4 equals to 0
                CMPI.B      #1, D4              ; compare D4 with 1
                BEQ         prnt_Imm_word       ; branch to prnt_Imm_byte if D4 equals to 1
                CMPI.B      #2, D4              ; compare D4 with 2
                BEQ         prnt_Imm_long       ; branch to prnt_Imm_byte if D4 equals to 2
                
prnt_Imm_byte:  ROR.L       #8, D1              ; roate D1 8 bits to right with size long
                ROR.L       #8, D1              ; roate D1 8 bits to right with size long
                MOVEA.L     D1, A2 
                JSR         PRNT_BYTE           ; jump to subroutine PRNT_BYTE
                LEA        (2,A6),A6            ; increase A6 with 2 bytes
                BRA         done_IMM_           ; branch to done_IMM_

prnt_Imm_word:  ROR.L       #8, D1              ; roate D1 8 bits to right with size long
                ROR.L       #8, D1              ; roate D1 8 bits to right with size long
                MOVEA.L     D1, A2 
                JSR         PRNT_WORD           ; jump to subroutine PRNT_WORD
                LEA        (2,A6),A6            ; increase A6 with 2 bytes
                BRA         done_IMM_           ; branch to done_IMM_

prnt_Imm_long:  MOVEA.L     (A4), A2            ; copy (A4) to A2
                JSR         PRNT_LONG          ; jump to subroutine PRINTADDR
                LEA        (4,A6),A6            ; increase A6 with 4 bytes
                
done_IMM_:      RTS
*******************************************************************************
DATA_:          LEA         ea_immNum, A1       ; print ea_immNum 
                MOVE.B      #14, D0
                TRAP        #15 
                CMPI.B      #0, D6              ; compare D6 with 0
                BEQ         add_8               ; branch to add_8 if D6 equals to 0
                MOVE.B      D6, D1              ; print D3
                MOVE.B      #3, D0
                TRAP        #15
                BRA         done_DATA_          ; branch to done_DATA_
               
add_8:          ADDI.B      #8, D6              ; add D6 with $8
                MOVE.B      D6, D1
                MOVE.B      #3, D0
                TRAP        #15 
       
done_DATA_:     CLR         D6
                RTS
*******************************************************************************
DATA_2:         LEA         ea_immediate, A1    ; print ea_immediate
                MOVE.B      #14, D0
                TRAP        #15 
                MOVEA.L     D6, A2
                JSR         PRNT_BYTE           ; jump to subroutine PRNT)BYTE
                CLR         D6
                RTS  

*******************************************************************************    
D_ORANGE:       CMPI.B      #0, D6              ; compare D6 with 0
                BEQ         d_O_DN_             ; branch to d_O_DN_ if D6 equals to 0
                CMPI.B      #1, D6              ; compare D6 with 1
                BEQ         d_O_EA_             ; branch to d_O_EA_ if D6 equals to 1

d_O_DN_:        MOVE.W      D7, D6              ; copy D7 to D6             
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                JSR         MODE_XN             ; jump to subroutine MODE_XN
                LEA         comma, A1           ; display comma
                MOVE.B      #14, D0
                TRAP        #15
                MOVE.W      D7, D6              ; copy D7 to D6 
                ROR.W       #8, D6              ; roate D1 8 bits to right with size word
                ROR.W       #1, D6              ; roate D1 1 bits to right with size word
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                MOVE.B      D6, (regNum)        ; copy D6 to (regNum)
                JSR         DN_                 ; jump to subroutine DN_
                BRA         d_done_O            ; branch to d_done_O
                
d_O_EA_:        MOVE.W      D7, D6              ; copy D7 to D6
                ROR.W       #8, D6              ; roate D1 8 bits to right with size word
                ROR.W       #1, D6              ; roate D1 1 bits to right with size word
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                MOVE.B      D6, (regNum)        ; copy D6 to (regNum)
                JSR         DN_                 ; jump to subroutine DN_
                LEA         comma, A1           ; display comma
                MOVE.B      #14, D0
                TRAP        #15
                MOVE.W      D7, D6              ; copy D7 to D6  
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                JSR         MODE_XN             ; jump to subroutine MODE_XN
                
d_done_O:       CLR         D6
                RTS
*******************************************************************************                
D_RED:          CMPI.B      #0, D6              ; compare D6 with 0
                BEQ         d_O_R2M_            ; branch to d_O_R2M_ if D6 equals to 0
                CMPI.B      #1, D6              ; compare D6 with 1
                BEQ         d_O_M2R_            ; branch to d_O_M2R_ if D6 equals to 1
                CLR         D0
              
d_O_R2M_:       MOVEA.L     A6, A4              ; copy A6 to A4
                LEA         (2, A4), A4         ; increase A4 with 2 bytes
                MOVE.W      (A4), D5
                CLR         D1     
                MOVE.W      D7, D6
                ANDI.W      #$003F, D6
                CMPI.B      #$38, D6
                BEQ         control_ea
                CMPI.B      #$39, D6
                BEQ         control_ea
                ROR.W       #3, D6
                ANDI.W      #$007, D6
                CMPI.B      #2, D6
                BEQ         control_ea    
                
                MOVE.W      D5, D6              ; copy D5 to D6      
                ROR.W       #8, D6              ; roate D1 8 bits to right with size word
                ANDI.L      #$000000FF, D6      ; mask D6 with $000000FF
                CMPI.B      #0, D6              ; compare D6 with 0
                BEQ         no_D1               ; branch to no_D1 if D6 equals to 0
                MOVE.B      #0, D1              ; copy 0 to D1
                JSR         REGLIST_DN          ; jump to subroutine REGLIST_DN
                MOVE.W      D5, D6              ; copy D5 to D6
                ANDI.L      #$000000FF, D6      ; mask D6 with $000000FF
                CMPI.B      #0, D6              ; compare D6 with 0
                BEQ         no_A1               ; branch to no_A1 if D6 equals to 0
                LEA         ea_slash, A1        ; display ea_slash
                MOVE.B      #14, D0
                TRAP        #15    
              
no_D1:          MOVE.W      D5, D6              ; copy D5 to D6
                ANDI.L      #$000000FF, D6      ; mask D6 with $000000FF
                MOVE.B      #0, D1              ; copy 0 to D1
                JSR         REGLIST_AN          ; jump to subroutine REGLIST_AN
                
no_A1:          LEA         comma, A1           ; display comma
                MOVE.B      #14, D0
                TRAP        #15
                MOVE.W      D7, D6              ; copy D7 to D6        
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                JSR         MODE_XN             ; jump to subroutine MODE_XN
                BRA         d_done_R            ; branch to d_done_R
                
control_ea:     MOVE.W      D5, D6              ; copy D5 to D6      
                ROR.W       #8, D6              ; roate D1 8 bits to right with size word
                ANDI.L      #$000000FF, D6      ; mask D6 with $000000FF
                CMPI.B      #0, D6              ; compare D6 with 0
                BEQ         no_A3               ; branch to no_D1 if D6 equals to 0
                MOVE.B      #1, D1              ; copy 0 to D1
                JSR         REGLIST_AN          ; jump to subroutine REGLIST_DN
                MOVE.W      D5, D6              ; copy D5 to D6
                ANDI.L      #$000000FF, D6      ; mask D6 with $000000FF
                CMPI.B      #0, D6              ; compare D6 with 0
                BEQ         no_D3               ; branch to no_A1 if D6 equals to 0
                LEA         ea_slash, A1        ; display ea_slash
                MOVE.B      #14, D0
                TRAP        #15    
                
no_A3:          MOVE.W      D5, D6              ; copy D5 to D6
                ANDI.L      #$000000FF, D6      ; mask D6 with $000000FF
                MOVE.B      #1, D1              ; copy 0 to D1
                JSR         REGLIST_DN          ; jump to subroutine REGLIST_AN

no_D3:          LEA         comma, A1           ; display comma
                MOVE.B      #14, D0
                TRAP        #15
                MOVE.W      D7, D6              ; copy D7 to D6        
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                CMPI.B      #$38, D6
                BEQ         notreg_mode
                CMPI.B      #$39, D6
                BEQ         notreg_mode
                BRA         regmode
notreg_mode:    LEA         (2, A6), A6       
                JSR         MODE_XN             ; jump to subroutine MODE_XN
                LEA         (-2, A6), A6 
                BRA         d_done_R 
                
regmode:        JSR         MODE_XN  
                BRA         d_done_R            ; branch to d_done_R
                
d_O_M2R_:       MOVE.W      D7, D6              ; copy D7 to D6 
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                CMPI.B      #$38, D6
                BEQ         notreg_mode2
                CMPI.B      #$39, D6
                BEQ         long_notreg
                BRA         regmode2
                
notreg_mode2:   LEA         (2, A6), A6       
                JSR         MODE_XN             ; jump to subroutine MODE_XN
                LEA         (-4, A6), A6 
                BRA         bra_comma
long_notreg:    LEA         (2, A6), A6       
                JSR         MODE_XN             ; jump to subroutine MODE_XN
                LEA         (-6, A6), A6             
bra_comma:      LEA         comma, A1           ; display comma
                MOVE.B      #14, D0
                TRAP        #15                
                MOVEA.L     A6, A4
                LEA         (2, A4), A4         ; increase A4 with 2 bytes
                MOVE.W      (A4), D5            ; copy (A4) to D5                
                CLR         D1     
                MOVE.W      D5, D6              ; copy D5 to D6
                ROR.W       #8, D6              ; roate D1 8 bits to right with size word
                ANDI.L      #$000000FF, D6      ; mask D6 with $000000FF
                CMPI.B      #0, D6              ; compare D6 with 0
                BEQ         no_A4               ; branch to no_A2 if D6 equals to 0
                MOVE.B      #1, D1              ; copy 1 to D1
                JSR         REGLIST_AN          ; jump to subroutine REGLIST_AN
                MOVE.W      D7, D6              ; copy D7 to D6 
                ANDI.W      #$003F, D6          ; mask D6 with $003F              
                MOVE.W      D5, D6              ; copy D5 to D6
                ANDI.L      #$000000FF, D6      ; mask D6 with $000000FF
                CMPI.B      #0, D6              ; compare D6 with 0   
                           
                BEQ         not_reg_done            ; branch to d_done_R if D6 equals to 0
                LEA         ea_slash, A1        ; print ea_slash
                MOVE.B      #14, D0
                TRAP        #15 
              
no_A4:          MOVE.W      D5, D6              ; copy D5 to D6
                ANDI.L      #$000000FF, D6      ; mask D6 with $000000FF
                MOVE.B      #1, D1              ; copy 1 to D1
                JSR         REGLIST_DN          ; jump to subroutine REGLIST_DN
                BRA         not_reg_done
                
regmode2:       JSR         MODE_XN             ; jump to subroutine MODE_XN
                LEA         comma, A1           ; display comma
                MOVE.B      #14, D0
                TRAP        #15                
                MOVEA.L     A6, A4
                LEA         (2, A4), A4         ; increase A4 with 2 bytes
                MOVE.W      (A4), D5            ; copy (A4) to D5                
                CLR         D1     
                MOVE.W      D5, D6              ; copy D5 to D6
                ROR.W       #8, D6              ; roate D1 8 bits to right with size word
                ANDI.L      #$000000FF, D6      ; mask D6 with $000000FF
                CMPI.B      #0, D6              ; compare D6 with 0
                BEQ         no_A2               ; branch to no_A2 if D6 equals to 0
                MOVE.B      #1, D1              ; copy 1 to D1
                JSR         REGLIST_AN          ; jump to subroutine REGLIST_AN
                MOVE.W      D7, D6              ; copy D7 to D6 
                ANDI.W      #$003F, D6          ; mask D6 with $003F              
                MOVE.W      D5, D6              ; copy D5 to D6
                ANDI.L      #$000000FF, D6      ; mask D6 with $000000FF
                CMPI.B      #0, D6              ; compare D6 with 0
                BEQ         d_done_R            ; branch to d_done_R if D6 equals to 0
                LEA         ea_slash, A1        ; print ea_slash
                MOVE.B      #14, D0
                TRAP        #15 

no_A2:          MOVE.W      D5, D6              ; copy D5 to D6
                ANDI.L      #$000000FF, D6      ; mask D6 with $000000FF
                MOVE.B      #1, D1              ; copy 1 to D1
                JSR         REGLIST_DN          ; jump to subroutine REGLIST_DN
                BRA         d_done_R
long_regUpdate: LEA         (2, A6), A6 
                BRA         d_done_R               
not_reg_done:   LEA         (2, A6), A6   
                MOVE.W      D7, D6              ; copy D7 to D6 
                ANDI.W      #$003F, D6          ; mask D6 with $003F
                CMPI.B      #$39, D6
                BEQ         long_regUpdate

d_done_R:       LEA         (2, A6), A6         ; increase A6 with 2 bytes
                CLR         D6
                RTS    
*******************************************************************************  
REGLIST_DN:     MOVEM.L     D0-D5, -(SP)
                CLR         D4
                CLR         D3
                CMPI.B      #0, D6              ; compare D6 with 0
                BEQ         done_reg            ; branch to done_reg if D6 equals to 0
                CMPI.B      #0, D1              ; compare D1 with 0
                BEQ         reg_check_d1        ; branch to reg_check_d1 if D6 equals to 0
                CMPI.B      #1, D1              ; compare D1 with 1
                BEQ         reg_check_d2        ; branch to reg_check_d2 if D6 equals to 0
               
reg_check_d1:   ADDI.B      #1, D4              ; add D4 with 1
                CMPI.B      #8, D4              ; compare D4 with 8
                BGT         done_reg            ; branch to done_reg if D4 equals to 8
                ROL.B       #1, D6              ; roate D6 1 bits to left with size byte
                MOVE.B      D6, D5              ; copy D6 to D5
                ANDI.B      #$01, D5            ; mask D5 with $01
                CMPI.B      #1, D5              ; compare D5 with 1
                BEQ         p_reg               ; branch to p_reg if D5 equals to 1
                BNE         reg_check_d1        ; branch to reg_check_d1 if D5 doesn't equal to 1
                 
bigSize_d1:     ADDI.B      #1, D4              ; add D4 with 1
                CMPI.B      #8, D4              ; compare D4 with 8
                BGE         last_DN             ; branch to done_reg if D4 equals to 8
                ROL.B       #1, D6              ; roate D6 1 bits to left with size byte
                MOVE.B      D6, D5              ; copy D6 to D5
                ANDI.B      #$01, D5            ; mask D5 with $01
                CMPI.B      #1, D5              ; compare D5 with 1
                BEQ         p_reg_slash         ; branch to p_reg if D5 equals to 1
                BNE         bigSize_d1          ; branch to bigSize_d1 if D5 doesn't equal to 1
                
reg_check_d2:   ADDI.B      #8, D4              ; add D4 with 8
reg_check_2d2:  SUBI.B      #1, D4              ; substract 1 from D4
                CMPI.B      #0, D4              ; compare D4 with 0
                BLT         done_reg            ; branch to done_reg if D4 less than 0
                ROL.B       #1, D6              ; roate D6 1 bits to left with size byte
                MOVE.B      D6, D5              ; copy D6 to D5
                ANDI.B      #$01, D5            ; mask D5 with $01
                CMPI.B      #1, D5              ; compare D5 with 1
                BEQ         p_reg               ; branch to p_reg if D5 equals to 1
                BNE         reg_check_2d2       ; branch to reg_check_2d2 if D5 doesn't equal to 1
                
bigSize_d2:     SUBI.B      #1, D4              ; substract 1 from D4
                CMPI.B      #0, D4              ; compare D4 with 0
                BLT         done_reg            ; branch to done_reg if D4 less than 0
                ROL.B       #1, D6              ; roate D6 1 bits to left with size byte
                MOVE.B      D6, D5              ; copy D6 to D5
                ANDI.B      #$01, D5            ; mask D5 with $01
                CMPI.B      #1, D5              ; branch to p_reg_slash if D5 equals to 1
                BEQ         p_reg_slash         ; branch to p_reg_slash if D5 equals to 1
                BNE         bigSize_d2          ; branch to bigSize_d2 if D5 doesn't equal to 1
               
p_reg_slash:    LEA         ea_slash, A1        ; display ea_slash
                MOVE.B      #14, D0
                TRAP        #15                                
p_reg:          CLR         D0
                MOVE.B      D4, D0              ; copy D4 to D0
                CMPI.B      #0, D1              ; compare D4 with 0
                BEQ         sub_                ; branch to sub_ if D1 equals to 0
                BRA         print_now           ; branch to print_now
sub_:           SUBI.B      #1, D0              ; substract 1 from D0
print_now:      MOVE.B      D0, (regNum)        ; copy D0 to (regNum)
                JSR         DN_                 ; jump to subroutine DN_
                CMPI.B      #8, D4              ; compare D4 with 8
                BEQ         done_reg           ; branch to done_reg if D4 equals to 8              
                CMPI.B      #0, D1              ; compare D1 with 0
                BEQ         bigSize_d1          ; branch to bigSize_d1 if D1 equals to 0
                CMPI.B      #1, D1              ; compare D1 with 1
                BEQ         bigSize_d2          ; branch to bigSize_d2 if D1 equals to 1
                
last_DN:        ROL.B       #1, D6              ; roate D6 1 bits to left with size byte
                MOVE.B      D6, D5              ; copy D6 to D5
                ANDI.B      #$01, D5            ; mask D5 with $01
                CMPI.B      #1, D5              ; compare D5 with 1
                BEQ         p_reg_slash              ; branch to p_reg if D5 equals to 1

done_reg:       CLR         D6
                MOVEM.L    (SP)+, D0-D5
                RTS 
*******************************************************************************  
REGLIST_AN:     MOVEM.L     D0-D5, -(SP)
                CLR         D4
                CMPI.B      #0, D6              ; compare D6 with 0
                BEQ         done_reg2           ; branch to done_reg2 if D6 equals to 0
                CMPI.B      #0, D1              ; compare D1 with 0
                BEQ         reg_check_a1        ; branch to reg_check_a1 if D1 equals to 0
                CMPI.B      #1, D1              ; compare D1 with 1
                BEQ         reg_check_a2        ; branch to reg_check_a2 if D1 equals to 1
                
reg_check_a1:   ADDI.B      #1, D4              ; add D4 with 1
                CMPI.B      #8, D4              ; compare D4 with 8
                BGT         done_reg2            ; branch to done_reg2 if D4 is greater than 8
                ROL.B       #1, D6              ; roate D6 1 bits to left with size byte
                MOVE.B      D6, D5              ; copy D6 to D5
                ANDI.B      #$01, D5            ; mask D5 with $01
                CMPI.B      #1, D5              ; compare D5 with 1
                BEQ         print_reg2          ; branch to print_reg2 if D5 equals to 1
                BNE         reg_check_a1        ; branch to reg_check_a1 if D5 doesn't equal to 1
                
bigSize_a1:     ADDI.B      #1, D4              ; add D4 with 1
                CMPI.B      #8, D4              ; compare D4 with 8
                BGE         last_AN            ; branch to done_reg if D4 is greater than 8
                ROL.B       #1, D6              ; roate D6 1 bits to left with size byte
                MOVE.B      D6, D5              ; copy D6 to D5
                ANDI.B      #$01, D5            ; mask D5 with $01
                CMPI.B      #1, D5              ; compare D5 with 1
                BEQ         p_reg_slash2
                BNE         bigSize_a1                
              
reg_check_a2:   ADDI.B      #8, D4              ; add D4 with 8
reg_check_2a2:  SUBI.B      #1, D4              ; substract 1 from D4
                CMPI.B      #0, D4              ; compare D4 with 0
                BLT         done_reg2           ; branch to done_reg2 if D4 is gless than 0
                ROL.B       #1, D6              ; roate D6 1 bits to left with size byte
                MOVE.B      D6, D5              ; copy D6 to D5
                ANDI.B      #$01, D5            ; mask D5 with $01
                CMPI.B      #1, D5              ; compare D5 with 1
                BEQ         print_reg2          ; branch to print_reg2 if D5 equals to 1
                BNE         reg_check_2a2       ; branch to reg_check_2a2 if D5 doesn't equal to 1
                
bigSize_a2:     SUBI.B      #1, D4              ; substract 1 from D4
                CMPI.B      #0, D4              ; substract 1 from D4
                BLT         done_reg2            ; branch to done_reg if D4 is gless than 0
                ROL.B       #1, D6              ; roate D6 1 bits to left with size byte
                MOVE.B      D6, D5              ; copy D6 to D5
                ANDI.B      #$01, D5            ; mask D5 with $01
                CMPI.B      #1, D5              ; compare D5 with 1
                BEQ         p_reg_slash2        ; branch to p_reg_slash2 if D5 equals to 1
                BNE         bigSize_a2          ; branch to bigSize_a2 if D5 doesn't equal to 1
               
p_reg_slash2:   LEA         ea_slash, A1        ; display ea_slash
                MOVE.B      #14, D0
                TRAP        #15    
print_reg2:     CLR         D0
                MOVE.B      D4, D0              ; copy D4 to D0
                CMPI.B      #0, D1              ; compare D1 with 0
                BEQ         sub_2               ; branch to sub_2 if D1 equals to 0
                BRA         print_now2          ; branch to print_now2
sub_2:          SUBI.B      #1, D0              ; substract 1 from D0
print_now2:     MOVE.B      D0, (regNum)        ; copy D0 to (regNum)
                JSR         AN_                 ; jump to subroutine AN_
                CMPI.B      #8, D4              ; compare D4 with 8
                BEQ         done_reg           ; branch to done_reg if D4 equals to 8                           
                CMPI.B      #0, D1              ; compare D1 with 0
                BEQ         bigSize_a1          ; branch to bigSize_a1 if D1 equals to 0
                CMPI.B      #1, D1              ; compare D1 with 1
                BEQ         bigSize_a2          ; branch to bigSize_a2 if D1 equals to 1
                
last_AN:        ROL.B       #1, D6              ; roate D6 1 bits to left with size byte
                MOVE.B      D6, D5              ; copy D6 to D5
                ANDI.B      #$01, D5            ; mask D5 with $01
                CMPI.B      #1, D5              ; compare D5 with 1
                BEQ         p_reg_slash2        ; branch to print_reg2 i                

done_reg2:      CLR         D6
                MOVEM.L    (SP)+, D0-D5
                RTS
*******************************************************************************  
D_GREEN:        CMPI.B      #0, D6              ; compare D6 with 0
                BEQ         print_right         ; branch to print_right if D6 equals to 0
                CMPI.B      #1, D6              ; mask D6 with 1
                BEQ         print_left          ; branch to print_left if D6 equals to 1
        
print_right:    LEA         opcode_right, A1    ; display opcode_right
                MOVE.B      #14, D6
                TRAP        #15
                BRA         done_green
                
print_left:     LEA         opcode_left, A1    ; display opcode_left
                MOVE.B      #14, D6
                TRAP        #15
                
done_green:     CLR         D6
                RTS       
*******************************************************************************  
M_BLUE:         MOVE.W      D7,D6               ; copy D7 to D6
                ROR.W       #5,D6               ; roate D6 5 bits to right with size word
                ANDI.W      #0001,D6            ; mask D6 with 1
                CMPI.B      #0, D6              ; compare D6 with 0
                BEQ         p_imm               ; branch to p_imm if D6 equals to 0
                CMPI.B      #1, D6              ; compare D6 with 1
                BEQ         p_reg_b             ; branch to p_reg_b if D6 equals to 1

p_reg_b:        MOVE.W      D7,D6               ; copy D7 to D6
                ROL.W       #7,D6               ; roate D6 7 bits to left with size word
                ANDI.W      #0007,D6            ; mask D6 with 7
                MOVE.B      D6, (regNum)        ; copy D6 to (regNum)
                JSR         DN_                 ; jump to subroutine DN_
                BRA         done_BLUE           ; branch to done_BLUE
                
p_imm:          MOVE.W      D7, D6              ; copy D7 to D6
                ROL.W       #7, D6              ; roate D6 7 bits to left with size word
                ANDI.W      #$0007, D6          ; mask D6 with 7
                JSR         DATA_               ; jump to subroutine DATA_
                 
done_BLUE:      CLR         D6
                RTS                  

***********************************************************************
CHK_EA_MXN:     MOVE.W      D6, D5              ; copy D6 to D5
                ANDI.W      #$0007, D5          ; mask D5 with $0007
                ROR.W       #3, D6              ; roate D6 3 bits to right with size word
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                CMPI.B      #$005, D6           ; compare D6 with 5
                BEQ         inv_ea_mxn          ; branch to update_men_W if D6 equals to 5
                CMPI.B      #$006, D6           ; compare D6 with 6
                BEQ         inv_ea_mxn        ; branch to update_men_B if D6 equals to 6
                CMPI.B      #7, D6              ; compare D6 with 7
                BEQ         o_ea_mxn            ; branch to o_ea_mxn if D6 equals to 7
                BRA         done_mxn            ; branch to done_mxn
                                  
o_ea_mxn:       CMPI.B      #$002, D5           ; compare D5 with 2
                BEQ         inv_ea_mxn        ; branch to update_mem_W if D5 equals to 2
                CMPI.B      #$003, D5           ; compare D5 with 3
                BEQ         inv_ea_mxn        ; branch to update_mem_B if D5 equals to 3
                BRA         done_mxn            ; branch to done_mxn
                
inv_ea_mxn:     MOVE.B      #1, D3
done_mxn:       RTS
***********************************************************************
CHK_EA_XNM:     MOVE.W      D6, D5              ; copy D6 to D5      
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                CMPI.B      #$005, D6           ; compare D6 with 5
                BEQ         inv_ea_xnm          ; branch to update_men_W2 if D6 equals to 5
                CMPI.B      #$006, D6           ; compare D6 with 6
                BEQ         inv_ea_xnm       ; branch to update_men_B2 if D6 equals to 6
                CMPI.B      #7, D6              ; compare D6 with 7
                BEQ         o_ea_xnm            ; branch to o_ea_mxn if D6 equals to 7
                BRA         done_xnm            ; branch to done_mxn
                                  
o_ea_xnm:       ROR.W       #3, D5              ; roate D5 3 bits to right with size word
                ANDI.W      #$0007, D5          ; mask D5 with $0007
                CMPI.B      #$002, D5           ; compare D5 with 2
                BEQ         inv_ea_xnm       ; branch to update_mem_W2 if D5 equals to 2
                CMPI.B      #$003, D5           ; compare D5 with 3
                BEQ         inv_ea_xnm       ; branch to update_mem_B2 if D5 equals to 3
                BRA         done_xnm            ; branch to done_mxn
                
inv_ea_xnm:     MOVE.B      #1, D3
done_xnm:       RTS
***********************************************************************
CHECK_EA:       MOVEM.L     D4-D7, -(SP)
                CLR         D4                
                MOVE.W      D6, D5              ; copy D6 to D5
                MOVE.W      D6, D7              ; valid ea
                ANDI.W      #$0007, D5          ; mask D5 with $0007
                ROR.W       #3, D6         `     ; roate D6 3 bits to right with size word
                ANDI.W      #$0007, D6          ; mask D6 with $0007
                CMPI.B      #7, D6              ; compare D6 with 7
                BEQ         chk_ea_other        ; branch to o_ea_mxn if D6 equals to 7
               
                CMPI.B      #$000, D6           ; compare D6 with $000
                BEQ         dataReg3             ; branch to dataReg if D6 equals to 0    
                CMPI.B      #$001, D6           ; compare D6 with $001
                BEQ         addrReg3             ; branch to addrReg if D6 equals to $001
                CMPI.B      #$002, D6           ; compare D6 with $002
                BEQ         addrIndirect3        ; branch to addrIndirect if D6 equals to 0
                CMPI.B      #$003, D6           ; compare D6 with $003
                BEQ         addrPostInc3         ; branch to addrPostInc if D6 equals to 0
                CMPI.B      #$004, D6           ; compare D6 with $004
                BEQ         addrPreDec3          ; branch to addrPreDec if D6 equals to 0

dataReg3:       MOVE.B      #$80, D4               
                BRA         check_IsValid
addrReg3:       MOVE.B      #$40, D4
                BRA         check_IsValid
addrIndirect3:  MOVE.B      #$20, D4
                BRA         check_IsValid         
addrPostInc3:   MOVE.B      #$10, D4
                BRA         check_IsValid
addrPreDec3:    MOVE.B      #$8, D4
                BRA         check_IsValid

chk_ea_other:   CMPI.B      #$000, D5           ; compare D5 with 2
                BEQ         absShort3        ; branch to update_mem_W if D5 equals to 2
                CMPI.B      #$001, D5           ; compare D5 with 3
                BEQ         absLong3        ; branch to update_mem_B if D5 equals to 3
                CMPI.B      #$004, D5           ; compare D5 with 3
                BEQ         immediate3 
               
absShort3:      MOVE.B      #$4, D4
                BRA         check_IsValid
absLong3:       MOVE.B      #$2, D4
                BRA         check_IsValid
immediate3:     MOVE.B      #$1, D4
                BRA         check_IsValid
                    
check_IsValid:  ROR.W       #6, D7
                AND.W       D4, D7
                CMP.W       D4, D7
                BNE         ea_isNorValid
                BRA         done_chk_ea
                
ea_isNorValid:  MOVE.B      #1, D3
             
done_chk_ea:    MOVEM.L     (SP)+, D4-D7
                RTS                     
             
************************************************************************


































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
