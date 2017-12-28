                            
*******************************************************************************                              
* PROMPT: Asks user input         
* Saved Registers: 
*   A0: Load start address
*   A1: Load end address, used for string display
*   A2: Load min range address
*   A3: Load max range address
*   D0: Traps
*   D1: Address size 
*   D2: Addresses count  
*   D3: Temp variable for read console       
*******************************************************************************
PROMPT:         MOVEM.L     A0-A3/D0-D4, -(SP)
                LEA         welcomeMsg, A1     ; display the welcome msg
                MOVE.B      #14, D0             
                TRAP        #15

askUserInput:   LEA         inputMsg, A1       ; display the user instruction
                MOVE.B      #14, D0               
                TRAP        #15 
                
startPrompt:    LEA         startInpMsg, A1    ; ask user for start address
                MOVE.B      #14, D0               
                TRAP        #15
                CLR         D2
                BSR         READCONSOLE        ; gets the user input    
                CMPI.B      #1, D2             ; flag (0) if error occurs in reading start address
                BNE         startPrompt        ; ask for start address again
                LEA         startAddr, A0      ; successfully inputted correct address           
                BSR         ASCIITOHEX         ; translate ascii to hex and load to startAddr variable   
               
endPrompt:      LEA         endInpMsg, A1      ; ask user for end addresss
                MOVE.B      #14, D0            
                TRAP        #15                               
                BSR         READCONSOLE        ; gets the user input  
                CMP.B       #2,D2              ; flag (1) if error occurs in reading end address
                BNE         endPrompt          ; ask for end address again
                LEA         endAddr, A0        ; successfully inputted correct address
                BSR         ASCIITOHEX         ; translate ascii to hex and load to endAddr variable
               
                MOVE.L      (startAddr), A0    ; loads start address to A0 for comparison purposes
                MOVE.L      (endAddr), A1      ; loads end address to A1 for comparison purposes                                       
                LEA         minRange, A2      
                LEA         maxRange, A3
                CMPA.L      A2, A0             ; compares  start address and min range 
                BLT         dispOutOfRan       ; A0 < A2, start address is less than min range
                CMPA.L      A3, A1             ; compare end address and max range
                BGT         dispOutOfRan       ; A1 > A0, end address is greater than max range
                CMPA.L      A1, A0             ; compares start and end address
                BGT         dispErrRange       ; A1 >= A0, start address is greater and equal to end addr     
                BLE         donePrompt
                
dispErrRange:   LEA         errAddrRange, A1   ; display size empty message
                MOVE.B      #14, D0
                TRAP        #15 
                BRA         askUserInput       ; ask user for input again
                
dispOutOfRan:   LEA         errOutOfRange, A1  ; display size empty message
                MOVE.B      #14, D0
                TRAP        #15 
                BRA         askUserInput        ; ask used for input again        
              
donePrompt:     LEA         endl, A1
                MOVE.B      #14, D0
                TRAP        #15
                MOVEM.L     (SP)+, A0-A3/D0-D4
                RTS                     
             

*******************************************************************************                              
* READCONSOLE: 
* Parameters:
*   A0: Load start address
*   A1: Load line buffer, used for string display
*   A2: Load min range address
*   A3: Load max range address
*   D0: Traps
*   D1: Address size 
*   D2: Addresses count  
*   D3: Temp variable for read console                             
*******************************************************************************
READCONSOLE:    LEA         lineBuffer, A1     ; saves ascii input to memory
                MOVE.B      #2, D0             ; reads the console
                TRAP        #15
                CMPI.W      #6, D1             ; compare address to 32-bits
                BGT         dispInvSize        ; address is greater than 32-bits
                CMPI.W      #4, D1             ; compare address to 16-bits
                BLT         dispInvSize        ; address is less than 16-bits
                CMPI.W      #0, D1             ; compare address to empty string
                BLE         dispInpEmpty       ; address is empty

                CLR.L       D3                 ; initialized D3 = 0
                MOVE.B      D1, D3             ; copy size to D3 to manipulate
                DIVU        #2, D3             ; divide address size by 2
                SWAP        D3                 ; gets the remainder
                CMPI.W      #0, D3             ; compare if remainder is 0
                BNE         dispUneven         ; remainder is not zero so address is uneven
                ADDI.B      #1, D2             ; tracker two addr fill out correctly                                                               
                BRA         doneRead
                                             
dispInvSize:    LEA         errInpSize, A1     ; display size invalid error
                MOVE.B      #14, D0         
                TRAP        #15
                BRA         doneRead
                                
dispInpEmpty:   LEA         errInpEmpty, A1    ; display size empty error
                MOVE.B      #14, D0
                TRAP        #15 
                BRA         doneRead  
                
dispUneven:     LEA         errUnevenAddr, A1  ; display uneven message error
                MOVE.B      #14, D0
                TRAP        #15 
                BRA         doneRead                 
                                                                         
doneRead:       RTS
                
*******************************************************************************                              
* ASCIITOHEX:
* Paremeters:
*   A0: Load start address
*   A1: Load line buffer, used for string display
*   A2: Load min range address
*   A3: Load max range address
*   D0: Traps
*   D1: Address size
*Saved Registers:  
*   D2: Addresses count  
*   D3: Temp variable for read console                           
*******************************************************************************
ASCIITOHEX:     MOVEM.L     D2-D3, -(SP)    
                CLR.L       D2                 ; clears address counter
                CLR.L      (A0)                ; clears the content of address
                CMP.B       #4, D1             ; compare address to 16-bits
                BEQ         sixteenbits        ; address is 16-bits
                CMP.B       #6, D1             ; compare address to 24-bits
                BEQ         twofourbits        ; address is 24-bits

sixteenbits:    ADDA.W      #2, A0             ; shift 2 bytes in the address to save input
                BRA         checkNext   
twofourbits:    ADDA.W      #1, A0             ; shift 1 byte in the address to save input
             
checkNext:      CLR         D0                 ; clear traps holder
                MOVE.B      (A1)+, D0          ; saves the current character to convert
                CMP.B       D2, D1             ; checks if all bytes been converted
                BEQ         doneConvert        
                ADD.B       #1, D2             ; update tracker of converted bytes
                CMP.B       #$39, D0           ; compare char to 39 (num 9)              
                BLE         charIsNum   
                CMP.B       #$61, D0           ; compare is char is a lowercase
                BLT         charIsUppLet
                BGE         charIsLowLet
                
charIsNum:      SUB.B       #$30, D0            ; subtract 30 to get to the num
                CMP.B       #$0, D0             ; compare num with 0
                BLT         dispInvNum        
                CMP.B       #$9, D0             ; compare num with 9
                BGT         dispInvNum                 
                BRA         saveData            ; saves valid data

charIsLowLet:   SUB.B       #$61, D0            ; subract 61 to get to lowercase letter
                BRA         convLet              
charIsUppLet:   SUB.B       #$41, D0            ; subtract 41 to get to uppercase letter 
convLet:        ADD.B       #10, D0             ; then add 10 to convert to letter
                CMP.B       #$A, D0             ; compare letter with A
                BLT         dispInvLet
                CMP.B       #$F, D0             ; compare letter with F
                BGT         dispInvLet           
                BRA         saveData            ; saves valid data
                
dispInvNum:     LEA         errInpNum, A1       ; display invalid num
                MOVE.B      #14, D0
                TRAP        #15  
                BRA         doneRead              
 
dispInvLet:     LEA         errInpLetter, A1    ; display invalid letter
                MOVE.B      #14, D0
                TRAP        #15 
                BRA         doneRead               
                
saveData:       CLR.L       D3                  ; clear temp variable
                MOVE.B      D2, D3              ; copy length of address into temp
                DIVU        #2, D3              ; divide size by 2 (mod operation)
                SWAP        D3                  ; gets remainder
                CMPI.W      #0, D3              ; compare if remainder is 0
                BEQ         evenChar
                
                ASL.B       #4, D0              ; shift 4 bits to left of current addr if on uneven byte in address
                MOVE.B      D0, (A0)            ; saves the modified data 
                BRA         checkNext
                            
evenChar:       ADD.B       D0, (A0)+           ; and add to the modified data
                BRA         checkNext
                                                     
doneConvert:    MOVEM.L     (SP)+, D2-D3
                RTS
                
*******************************************************************************                              
* PRINTADDR:
* Paremeters:
*   A1: Load printLocation
*   A5: Load end address
*   A2: Load addr to print
*   D0: Traps
*   D1: Data  
*   D2: Counter
*   D3: Bits Manipulator                          
*******************************************************************************
PRINTADDR:      MOVEM.L     D0-D3, -(SP)
                LEA         printLocation, A1   
                CLR         (A1)
                MOVE.L      A2, D1              ; copy A2 to D1
                CLR.L       D3
                CLR         D2
              
checkNextChar:  ADDI.B      #1, D2              ; mask D2 with 1
                CMPI.B      #8, D2              ; compare 8 with D2
                BGT         done_print          ; branch to done_print if D2 is greater than 8
                ROL.L       #4, D1              ; rotate left 4 bits of D1 with long size
                MOVE.B      D1, D3              ; copy D1 to D3
                ANDI.B      #%00001111, D3      ; mask D3 with $0F
                CMPI.B      #$9, D3             ; compare 9 with D3
                BGT         addrIsLet           ; branch to addrIsLet if D3 is greater than 9
                
addrIsNum:      ADDI.B      #$30, D3            ; mask D3 with $30
                BRA         saveChar            ; branch to saveChar
                
addrIsLet:      ADDI.B      #$37, D3            ; mask D3 with $37
                BRA         saveChar            ; branch to saveChar
                                
saveChar:       MOVE.B      D3, (A1)+           ; copy D3 to (A1), then increase (A1)
                BRA         checkNextChar       ; branch to checkNextChar

done_print:     LEA         printLocation, A1
                MOVE.W      #8, D1
                MOVE.B      #1, D0
                TRAP        #15
                MOVEM.L     (SP)+, D0-D3
                RTS 
*******************************************************************************                              
* PRNT_LONG:
* Paremeters:
*   A1: Load printLocation
*   A5: Load end address
*   A2: Load addr to print
*   D0: Traps
*   D1: Data  
*   D2: Counter
*   D3: Bits Manipulator                          
*******************************************************************************
PRNT_LONG:      MOVEM.L     D0-D3, -(SP)
                LEA         printLocation, A1   
                CLR         (A1)
                MOVE.L      A2, D1              ; copy A2 to D1
                CLR.L       D3
                CLR         D2
              
cNextChar:      ADDI.B      #1, D2              ; mask D2 with 1
                CMPI.B      #8, D2              ; compare 8 with D2
                BGT         l_done_print          ; branch to done_print if D2 is greater than 8
                ROL.L       #4, D1              ; rotate left 4 bits of D1 with long size
                MOVE.B      D1, D3              ; copy D1 to D3
                ANDI.B      #%00001111, D3      ; mask D3 with $0F
                CMPI.B      #$9, D3             ; compare 9 with D3
                BGT         IsLet           ; branch to addrIsLet if D3 is greater than 9
                
IsNum:          ADDI.B      #$30, D3            ; mask D3 with $30
                BRA         l_saveChar            ; branch to saveChar
                
IsLet:          ADDI.B      #$37, D3            ; mask D3 with $37
                BRA         l_saveChar            ; branch to saveChar
                                
l_saveChar:     MOVE.B      D3, (A1)+           ; copy D3 to (A1), then increase (A1)
                BRA         cNextChar       ; branch to checkNextChar

l_done_print:   MOVE.B      #3, D4
                JSR         REMOVEZEROS
                MOVEM.L     (SP)+, D0-D3
                RTS 
*******************************************************************************  
* Paremeters:
*   A1: Load printLocation
*   A5: Load end address
*   A2: Load addr to print
*   D0: Traps
*   D1: Data  
*   D2: Counter
*   D3: Bits Manipulator                          
*******************************************************************************
PRNT_WORD:      MOVEM.L     D0-D3, -(SP)
                LEA         printLocation, A1   ; display printLocation
                CLR.L       (A1)
                CLR         D1
                MOVE.W      A2, D1
                CLR.L       D3
                CLR         D2
              
w_checkChar:    ADDI.B      #1, D2              ; add D2 with 1
                CMPI.B      #4, D2              ; compare D2 with 4
                BGT         w_done_print        ; branch to w_done_print if D2 is greater than 4
                ROL.W       #4, D1              ; roate D1 4 bits to left with size word
                MOVE.B      D1, D3              ; copy D1 to D3
                ANDI.B      #%00001111, D3      ; mask D3 with $0F
                CMPI.B      #$9, D3             ; compare D3 with $9
                BGT         w_addrIsLet         ; branch to w_addrIsLet if D3 is greater than $9
                
w_addrIsNum:    ADDI.B      #$30, D3            ; add D3 with $30
                BRA         w_saveChar          ; branch to w_saveChar
                
w_addrIsLet:    ADDI.B      #$37, D3            ; add D3 with $37
                BRA         w_saveChar          ; branch to w_saveChar
                                
w_saveChar:     MOVE.B      D3, (A1)+           ; copy D3 to (A1)+
                BRA         w_checkChar         ; branch to w_checkChar

w_done_print:   MOVE.B      #2, D4
                JSR         REMOVEZEROS
                
                MOVEM.L     (SP)+, D0-D3
                RTS 
 
*******************************************************************************
PRNT_BYTE:      MOVEM.L     D0-D3, -(SP)
                LEA         printLocation, A1   ; display printLocation
                CLR.L       (A1)
                CLR         D1
                MOVE.L      A2, D1              ; copy A1 wo D1
                ANDI.L      #$000000FF, D1      ; mask D1 with $000000FF
                CLR.L       D3
                CLR         D2
              
b_checkChar:    ADDI.B      #1, D2              ; add D2 with 1
                CMPI.B      #2, D2              ; compare D2 with 2
                BGT         b_done_print        ; branch to b_done_print if D2 is greater than 2
                ROL.B       #4, D1              ; roate D1 4 bits to left with size word
                MOVE.B      D1, D3              ; copy D1 to D3
                ANDI.B      #%00001111, D3      ; mask D3 with $0F
                CMPI.B      #$9, D3             ; compare D3 with $9
                BGT         b_addrIsLet         ; branch to b_addrIsLet if D3 is greater than $9
                
b_addrIsNum:    ADDI.B      #$30, D3            ; add $30 to D3
                BRA         b_saveChar          ; branch to b_saveChar
                
b_addrIsLet:    ADDI.B      #$37, D3            ; add $37 to D3
                BRA         b_saveChar          ; branch to b_saveChar
                                
b_saveChar:     MOVE.B      D3, (A1)+           ; copy D3 to (A1)+ 
                BRA         b_checkChar         ; branch to b_checkChar

b_done_print:   MOVE.B      #1, D4
                JSR         REMOVEZEROS
                
                MOVEM.L     (SP)+, D0-D3
                RTS  
*******************************************************************************
REMOVEZEROS:    MOVEM.L     D0-D3/D5, -(SP)
                LEA         printLocation, A1   ; display printLocation                
                CLR.L       D0
                CLR.L       D2
                CLR.L       D3
                CLR.L       D1
                CMPI.B      #1, D4
                BEQ         modified_byte
                CMPI.B      #2, D4
                BEQ         modified_word
                CMPI.B      #3, D4
                BEQ         modified_long

modified_byte:  MOVE.B      (A1)+, D1
                ADDI.B      #1, D2
                CMPI.B      #2, D2
                BEQ         done_zeroByte
                CMPI.B      #$30, D1
                BEQ         zeros
done_zeroByte:  SUBI.B      #2, D3
                NEG         D3
                ANDI.L      #$F, D3
                CMPI.B      #0, D3
                BEQ         last_zero 
mod_byte:       LEA         printLocation, A1
                CLR.L       D1
                CLR.L       D2           
                MOVE.W      (A1), D1            
mod_byte2:      ROR.L       #8, D1               
                ADDI.B      #1, D2
                CMP.B       D2, D3
                BGT         mod_byte2                   
                MOVE.L      D1, (A1)
                BRA         p_modi_now
                
modified_word:  MOVE.B      (A1)+, D1
                ADDI.B      #1, D2
                CMPI.B      #4, D2
                BEQ         done_zeroWord
                CMPI.B      #$30, D1
                BEQ         zeros
done_zeroWord:  SUBI.B      #4, D3
                NEG         D3
                ANDI.L      #$F, D3
                CMPI.B      #0, D3
                BEQ         last_zero 
mod_word:       LEA         printLocation, A1
                CLR         D1
                CLR         D2 
                MOVE.L      (A1), D1            
mod_word2:      ROR.L       #8, D1               
                ADDI.B      #1, D2
                CMP.B       D2, D3
                BGT         mod_word2              
                MOVE.L      D1, (A1)
                BRA         p_modi_now

modified_long:  MOVE.B      (A1)+, D1
                ADDI.B      #1, D2
                CMPI.B      #8, D2
                BEQ         done_zeroLong
                CMPI.B      #$30, D1
                BEQ         zeros
done_zeroLong:  SUBI.B      #8, D3
                NEG         D3
                ANDI.L      #$F, D3
                CMPI.B      #0, D3
                BEQ         last_zero                
mod_long:       LEA         printLocation, A1
                CLR         D1
                CLR         D2 
                MOVE.L      (A1)+, D1
                MOVE.B      D3, D0
                SUBI.B      #4, D0
                CMPI.B      #4, D3
                BLE         long_word
                BGT         long_long               
long_word:      MOVE.L      (A1), D1 
                LEA         printLocation, A1   
                BRA         mod_word2
       
long_long:      CMPI.B      #4, D0
                BEQ         p_modi_now  
                MOVE.B      #4, D2
mod_long2:      LSL.L       #8, D1
                SUBI.B      #1, D2
                CMP.B       D2, D0
                BEQ         mod_long3
                BRA         mod_long2
mod_long3:      
                MOVE.L      D1, D5
                MOVE.L      (A1), D1
                CLR         D4
                CLR         D2
                MOVE.L      D1, D4
                LEA         printLocation, A1
mod_long4:      LSR.L       #8, D1
                ADDI.B      #1, D2          
                CMP.B       D2, D0
                BNE         mod_long4
                ADD.L       D1, D5
                MOVE.L      D4, D1
                MOVE.L      D5, (A1)+
                CLR         D2
                
mod_long5:      LSL.L       #8, D1               
                ADDI.B      #1, D2                
                CMP.B       D2, D0
                BEQ         mod_long5
                MOVE.L      D1, (A1)
                BRA         p_modi_now


zeros:          ADDI.B      #1, D3
                CMP.B       #1, D4
                BEQ         modified_byte
                CMPI.B      #2, D4
                BEQ         modified_word
                CMPI.B      #3, D4
                BEQ         modified_long
                
last_zero:      MOVE.B      #1, D3
                CMPI.B      #1, D4
                BEQ         mod_byte
                CMPI.B      #2, D4
                BEQ         mod_word
                CMPI.B      #3, D4
                BEQ         mod_long               

p_modi_now:     LEA         printLocation, A1 
                MOVE.W      D3, D1
                MOVE.B      #1, D0
                TRAP        #15
                MOVEM.L     (SP)+, D0-D3/D5
                RTS  
*******************************************************************************                              
* READMEMORY: 
* Parameters:
*   A1: Load print
*   A2: Load address to print
*   A5: Load end address
*   A6: Load current address, addr to read
*   D0: Traps
*   D1: Traps / input  
*   D2: Screen Counter
*   D7: Data                 
*******************************************************************************
READMEMORY:     MOVEM.L     A1-A2/D0-D3, -(SP)               
                MOVE.L      (startAddr), A6
                MOVE.L      (endAddr), A5
                               
nextOpCode:     CLR         D7                  ; clears data
                CMPA.L      A5, A6              ; checks if all memory are read
                BGT         printExit           ; branch to printExit if all memory are read
                ADDI.B      #1, D2              ; mask D2 with 1
                CMPI.B      #20, D2             ; compare $14 with D2
                BEQ         printNextScrn       ; branch to printNextScrn if D2 equals to $14
                MOVEA.L     A6, A2              ; copy A6 to A2
                BSR         PRINTADDR           ; branch to subroutine PRINTADDR
                MOVE.W      (A6), D7            ; saves the opcode to D7
                JSR         READOPCODE          ; jump to subroutine READOPCODE
                BRA         nextOpcode          ; branch to nextOpcode

nextOpcode2:    CLR         D7                  ; clears data
                CMPA.L      A5, A6              ; checks if all memory are read
                BGT         printExit2           ; branch to printExit if all memory are read
                ADDI.B      #1, D2              ; mask D2 with 1
                CMPI.B      #30, D2             ; compare $14 with D2
                BEQ         printNextScrn       ; branch to printNextScrn if D2 equals to $14
                MOVEA.L     A6, A2              ; copy A6 to A2
                BSR         PRINTADDR           ; branch to subroutine PRINTADDR
                MOVE.W      (A6), D7            ; saves the opcode to D7
                JSR         READOPCODE          ; jump to subroutine READOPCODE
                BRA         nextOpcode2                                  

printNextScrn:  CLR         D1                  ; clears D1
                CLR         D2                  ; clears D2
                LEA         nextScreen, A1      ; load nextScreen to A1
                MOVE.B      #14, D0             ; copy 14 to D0
                TRAP        #15                 ; display string at (A1)
                LEA         lineBuffer, A1      ; saves ascii input to memory
                CLR         (A1)
                MOVE.B      #5, D0              ; reads the console
                TRAP        #15
                CMPI.W      #$D, D1
                BEQ         nextOpcode2
                CMPI.W      #$1B, D1
                BEQ         done_Read
                CMPI.W      #$08, D1
                BEQ         readNewMem
                BRA         printNextScrn              
               
printExit:      CLR         D1                
p_morelines:    LEA         endl, A1
                MOVE.B      #14, D0
                TRAP        #15            
                ADDI.B      #1, D2              ; mask D2 with 1
                CMPI.B      #19, D2             ; compare $13 with D2
                BNE         p_morelines         ; branch to p_morelines if $13 equals to D2
                LEA         exitMsg, A1         ; display exitMsg
                MOVE.B      #14, D0
                TRAP        #15
                BRA         print_exit
                
printExit2:     CLR         D1                
p_morelines2:   LEA         endl, A1
                MOVE.B      #14, D0
                TRAP        #15 
                ADDI.B      #1, D2              ; mask D2 with 1
                CMPI.B      #29, D2             ; compare $13 with D2
                BNE         p_morelines2 
                LEA         exitMsg, A1         ; display exitMsg
                MOVE.B      #14, D0
                TRAP        #15
                BRA         print_exit
                
print_exit:     LEA         lineBuffer, A1      ; saves ascii input to memory
                MOVE.B      #2, D0              ; reads the console
                TRAP        #15
                CMPI.W      #1, D1              ; compare D1 with 1
                BNE         printExit           ; branch to printExit if D1 equals to 1
                MOVE.B      (A1), D1            ; copy (A1) to D1
                CMPI.B      #$4E, D1            ; compares to Q  
                BEQ         done_Read           ; branch to done_Read if D1 equals to $51
                CMPI.B      #$6E, D1            ; compares to q
                BEQ         done_Read           ; branch to done_Read if D1 equals to $71
                CMPI.B      #$59, D1            ; compares to N 
                BEQ         readNewMem          ; branch to readNewMem if D1 equals to $4E
                CMPI.B      #$79, D1            ; compares to n
                BEQ         readNewMem          ; branch to readNewMem if D1 equals to $6E
                BNE         printExit           ; branch to printExit if D1 doesn't equals to $6E
 
readNewMem:     CLR         D2
                JSR         MAIN                ; jump to subroutine MAIN
                            
done_Read:      LEA         endingMsg, A1
                MOVE.B      #14, D0
                TRAP        #15
                MOVEM.L     (SP)+, A1-A2/D0-D3
                RTS
*******************************************************************************































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
