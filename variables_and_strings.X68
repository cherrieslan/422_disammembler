               
*----------------------------Variables and Constants---------------------------
lineBuffer      DS.L    3
printLocation   DS.L    3
startAddr       DS.L    1   ; reads ASCII
endAddr         DS.L    1
regNum          DS.B    1
*-----------------------------------EQUates------------------------------------
minRange        EQU     $005000
maxRange        EQU     $00FFFF

CR              EQU     $0D  ; carriage return
LF              EQU     $0A  ; line feed
HT              EQU     $09  ; horizontal tab       
SP              EQU     $20  ; space
FSLASH          EQU     $2F   ; /     
*------------------------------------Opcode Strings----------------------------
opcode_NOP      DC.B    HT,'NOP',0
opcode_RTS      DC.B    HT,'RTS',0
opcode_CLR      DC.B    HT,'CLR',0
opcode_CMP      DC.B    HT,'CMP',0
opcode_AND      DC.B    HT,'AND',0
opcode_OR       DC.B    HT,'OR',0
opcode_JSR      DC.B    HT,'JSR  ',HT,0
opcode_LEA      DC.B    HT,'LEA  ',HT,0
opcode_ADD      DC.B    HT,'ADD',0
opcode_ADDA     DC.B    HT,'ADDA',0
opcode_ADDI     DC.B    HT,'ADDI',0
opcode_ADDQ     DC.B    HT,'ADDQ',0
opcode_SUB      DC.B    HT,'SUB',0
opcode_DIVU     DC.B    HT,'DIVU',0
opcode_MULS     DC.B    HT,'MULS',0
opcode_MOVEQ    DC.B    HT,'MOVEQ',HT,0
opcode_MOVEM    DC.B    HT,'MOVEM',0
opcode_MOVEA    DC.B    HT,'MOVEA',0
opcode_MOVE     DC.B    HT,'MOVE',0
opcode_AS       DC.B    HT,'AS',0
opcode_LS       DC.B    HT,'LS',0
opcode_RO       DC.B    HT,'RO',0
opcode_right    DC.B    'R',0
opcode_left     DC.B    'L',0
opcode_BCC      DC.B    HT,'BCC',HT,0
opcode_BGT      DC.B    HT,'BGT',HT,0
opcode_BLE      DC.B    HT,'BLE',HT,0
inv_opcode      DC.B    HT,'DATA   ',HT,0
space_1         DC.B    ' ',0
space_2         DC.B    '  ',0
space_3         DC.B    '   ',0
space_4         DC.B    '    ',0
*--------------------------------------characters------------------------------
ea_slash        DC.B    '/',0
ea_dataReg      DC.B    'D',0
ea_addrReg      DC.B    'A',0
ea_addrInd      DC.B    '(A',0 
ea_addrInd2     DC.B    ')',0
ea_addrPost     DC.B    '(A',0 
ea_addrPost2    DC.B    ')+',0 
ea_addrPre      DC.B    '-(A',0 
ea_addrPre2     DC.B    ')',0 
ea_absShort     DC.B    '$',0
ea_absLong      DC.B    '$',0
ea_immediate    DC.B    '#$',0 
ea_immNum       DC.B    '#',0   
endl            DC.B    '',CR,LF,0 
comma           DC.B    ', ',0
printByte       DC.B    '.B',HT,0
printWord       DC.B    '.W',HT,0
printLong       DC.B    '.L',HT,0

*--------------------------------------Strings---------------------------------
welcomeMsg      DC.B    '********************************************************************************',CR,LF
                DC.B    '              Disassembler for the Motorola MC68000 Microprocessor',CR,LF
                DC.B    '********************************************************************************',CR,LF                
                DC.B    '             Team Hard_Weird - CSS 422 Final Project - (Winter 2017)',CR,LF
                DC.B    '********************************************************************************',CR,LF,0
                               
inputMsg        DC.B     CR,LF,'Enter the address in memory between 5000 to FFFF to disassemble (hexadecimal).',CR,LF,0
startInpMsg     DC.B     'START Address: ',0
endInpMsg       DC.B     'END Address  : ',0 
nextScreen      DC.B     CR,LF,'Press [ENTER] to print, [BACKSPACE] to read new memory or [ESC] to quit.',CR,LF,0
exitMsg         DC.B     CR,LF,'Do you want to read another blocks of memory (Y/N)?',CR,LF,0 
endingMsg       DC.B    CR,LF,'********************************************************************************',CR,LF
                DC.B    '              Thank you for using Team Hard_Weirds Disassembler.',CR,LF
                DC.B    '********************************************************************************',CR,LF,0                
                    
*-----------------------------------Error Messages-----------------------------
errInpNum       DC.B    CR,LF,'Invalid Input: The numbers must be between 0-9 in hexadecimal format.',CR,LF,0
errInpLetter    DC.B    CR,LF,'Invalid Input: The letters must be between A-F in hexadecimal format.',CR,LF,0
errInpSize      DC.B    CR,LF,'Invalid Input: The size of the address must be between 16-bits to 24-bits.',CR,LF,0
errInpEmpty     DC.B    CR,LF,'Invalid Input: The size of the address cannot be empty.',CR,LF,0
errUnevenAddr   DC.B    CR,LF,'Invalid Input: The address must not be an uneven addressing.',CR,LF,0
errAddrRange    DC.B    CR,LF,'Invalid Input: The start address must not be greater than end address.',CR,LF,0
errOutOfRange   DC.B    CR,LF,'Invalid Input: The address inputted is out of range in the memory allowed',CR,LF
                DC.B    'to disassemble.',CR,LF,0
        




























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
