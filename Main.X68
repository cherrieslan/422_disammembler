*******************************************************************************
* Title      :  Disassembler
* Written by :  Team Hard_Weird
*               Chayanne Jaye Mediran
*               Lan Yang
*               Piseth  Ngorn
* Date       :
* Description:  This program develops a disassembler which scans a section of
*               memory and attempts to convert the memory's contents to a
*               listing of valid assembly language instructions.
*******************************************************************************
                ORG     $1000        
                
                INCLUDE     'variables_and_strings.x68'
                INCLUDE     'opcode_subroutine.x68'
                INCLUDE     'ea_subroutine.x68'
                INCLUDE     'io_subroutine.x68' 

*******************************************************************************                              
* MAIN:                                           
*******************************************************************************                
MAIN:           JSR        PROMPT       ; display the prompt and get input  
                JSR        READMEMORY   ; read the memory and print out the instruciton        
                JMP        FINISH       ; finish the program
                 
*******************************************************************************                
FINISH:
                END         MAIN        ; last line of source

































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
