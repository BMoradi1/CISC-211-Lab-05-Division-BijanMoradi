/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */

.global dividend,divisor,quotient,mod,we_have_a_problem
.type dividend,%gnu_unique_object
.type divisor,%gnu_unique_object
.type quotient,%gnu_unique_object
.type mod,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
dividend:          .word     0  
divisor:           .word     0  
quotient:          .word     0  
mod:               .word     0 
we_have_a_problem: .word     0

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: 
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    mov r0,r0
.endif
    
    /** note to profs: asmFunc.s solution is in Canvas at:
     *    Canvas Files->
     *        Lab Files and Coding Examples->
     *            Lab 5 Division
     * Use it to test the C test code */
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    /*load our dividend and devisor from the registers set by the C test code*/
    LDR r2, = dividend
    STR r0, [r2]
    LDR r2, = divisor
    STR r1, [r2]
    MOV r4, 0
    LDR r2, = we_have_a_problem
    STR r4, [r2]
    LDR r2, = quotient
    STR r4, [r2]
    LDR r2, = mod
    STR r4, [r2]
    
    /*lab assignment says if either input is 0, then it is not valid. inputs are still in R0/R1 registers.*/
    CMP r0, 0 /*compare r0, and 0*/
    BEQ error /*check if equal flag is set, if so there is an error*/
    CMP r1, 0
    BEQ error
    /*lets use r5 to store the quotent*/
    mov r5, 0 /*make sure theres nothing in there*/
    
    loop:
	CMP r0,r1
	BCC cleanup /*used BCC as using a signed conditon leads to overflow flag issues when the input is greater than the highest signed number*/
	ADD r5,r5,1
	SUB r0,r0,r1
	B loop
    cleanup:
	/*store the quotent*/
	LDR r2, = quotient
	STR r5, [r2]
	/*store the mod/remainder*/
	LDR r2, = mod
	STR r0, [r2]
	LDR r0, = quotient
	B done
    error:
	LDR r2, = we_have_a_problem
	MOV r3, 1
	STR r3, [r2] /*set we have a problem to 1 as specified by the lab*/
	LDR r0, = quotient /* Set r0 to the mem location of the quotent as specified by the lab*/
	B done
	
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 /* this is a do-nothing line to deal with IDE mem display bug */

screen_shot:    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




