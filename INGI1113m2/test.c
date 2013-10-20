#define __18F97J60
#define __SDCC__
#define THIS_INCLUDES_THE_MAIN_FUNCTION

#include <string.h>
#include <stdlib.h>

#include "Include/HardwareProfile.h"
#include "Include/LCDBlocking.h"
#include "clock.h"

long timer0count; // Number of timer0 overflows
long result; // Result variable

//Timer Interrupt
void HighISR(void) interrupt 1
{
    if(INTCONbits.T0IF)
    {
        INTCONbits.T0IF=0; // clear timer0 overflow bit
        timer0count++;
    }
    
    if(PIR1bits.TMR1IF)
    {
        PIR1bits.TMR1IF=0; // clear timer1 overflow bit
        T1CONbits.TMR1ON=0; // switch it off
        result=timer0count;
    }
}

// initialize board
void init_board(void)
{
    TRISJbits.TRISJ0    = 0;   // configure PORTJ0 for output (LED)
    TRISJbits.TRISJ1    = 0;   // configure PORTJ1 for output (LED)
    TRISJbits.TRISJ2    = 0;   // configure PORTJ1 for output (LED)
    
    RCONbits.IPEN       = 1;
    INTCONbits.TMR0IE   = 1;   //activate interruptions
    INTCONbits.GIE      = 1;   //activate High Priority
    INTCONbits.PEIE     = 1;   //activate Low Priority
    
    INTCON2bits.TMR0IP  = 1;   //Timer 0 high priority
    IPR1bits.TMR1IP     = 1;   //Timer 1 high priority
}

//Timer 0
void activateTimer0()
{
    T0CONbits.T08BIT=0; // use timer0 16-bit counter
    T0CONbits.T0CS=0; // use timer0 instruction cycle clock
    T0CONbits.PSA=1; // disable timer0 prescaler
    T0CONbits.T0PS0=0;
    T0CONbits.T0PS1=0;
    T0CONbits.T0PS2=0; //set prescaler at 1/64.
    TMR0H=0x00;
    TMR0L=0x00;
    INTCONbits.T0IF=0; // clear timer0 overflow bit
}

//Timer 1
void activateTimer1()
{
    T1CONbits.RD16=0; //write 8 bits
    T1CONbits.T1RUN=0; //use cristal
    T1CONbits.T1CKPS0=1;
    T1CONbits.T1CKPS1=1; //1:8 prescale (16sec for 1 overflow)
    T1CONbits.T1OSCEN=1; //activate
    T1CONbits.T1SYNC=1;
    T1CONbits.TMR1CS=1;
    T1CONbits.TMR1ON=1; //activate
    PIR1bits.TMR1IF=0;
    TMR1H=0x00;
    TMR1L=0x00;
}

void main(void)
{
    init_board();
    
    LATJbits.LATJ0=0; // switch LED off
    LATJbits.LATJ1=0; // switch LED off
    LATJbits.LATJ2=0; // switch LED off
    
    timer0count = 0;  // tick count = 0
    result = 0;
    
    LCDInit();
    activateTimer0();
    activateTimer1();
    
    while(1)
    {
        if(result != 0)
        {
            DisplayWORD(0, result);
        }
        else
        {
            DisplayString(0,"Wait 16sec...");
        }
    }
}
