#define __18F97J60
#define __SDCC__
#define THIS_INCLUDES_THE_MAIN_FUNCTION
#include "Include/HardwareProfile.h"

#include <string.h>
#include <stdlib.h>

#include "Include/LCDBlocking.h"
#include "Include/TCPIP_Stack/Delay.h"

#define LOW(a)     (a & 0xFF)
#define HIGH(a)    ((a>>8) & 0xFF)

void DisplayString(BYTE pos, char* text);
void DisplayWORD(BYTE pos, WORD w);
void DisplayIPValue(DWORD IPdw);
size_t strlcpy(char *dst, const char *src, size_t siz);

long timer0count;
long timer1count;

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
        TMR1H=0xFF;
        TMR1L=0xFF;
        PIR1bits.TMR1IF=0; // clear timer1 overflow bit
        T1CONbits.TMR1ON=0;
        timer1count=timer0count;
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
    T1CONbits.T1CKPS0=1; //1 prescale
    T1CONbits.T1CKPS1=1; //1 prescale
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
    float ratio;
    int ratioi;
    
    init_board();
    
	LATJbits.LATJ0=0; // switch LED off
	LATJbits.LATJ1=0; // switch LED off
    LATJbits.LATJ2=0; // switch LED off
    
    timer0count = 0;  // tick count = 0
    timer1count = 0;
    
    LCDInit();
    activateTimer0();
    activateTimer1();
    
    while(1)
    {
        if(timer1count != 0)
        {
            //ratio = timer0count/timer1count;
            //ratioi = (int)(ratio*1000);
            DisplayWORD(0, timer1count);
        }
        else
        {
            DisplayString(0,"tmr1: 0");
        }
    }
}
 
/*************************************************
 Function DisplayWORD:
 writes a WORD in hexa on the position indicated by
 pos. 
 - pos=0 -> 1st line of the LCD
 - pos=16 -> 2nd line of the LCD

 __SDCC__ only: for debugging
*************************************************/
#if defined(__SDCC__)
void DisplayWORD(BYTE pos, WORD w) //WORD is a 16 bits unsigned
{
    BYTE WDigit[6]; //enough for a  number < 65636: 5 digits + \0
    BYTE j;
    BYTE LCDPos=0;  //write on first line of LCD
    unsigned radix=10; //type expected by sdcc's ultoa()

    LCDPos=pos;
    ultoa(w, WDigit, radix);      
    for(j = 0; j < strlen((char*)WDigit); j++)
    {
       LCDText[LCDPos++] = WDigit[j];
    }
    if(LCDPos < 32u)
       LCDText[LCDPos] = 0;
    LCDUpdate();
}
/*************************************************
 Function DisplayString: 
 Writes an IP address to string to the LCD display
 starting at pos
*************************************************/
void DisplayString(BYTE pos, char* text)
{
   BYTE l= strlen(text)+1;
   BYTE max= 32-pos;
   strlcpy((char*)&LCDText[pos], text,(l<max)?l:max );
   LCDUpdate();

}
#endif


/*-------------------------------------------------------------------------
 *
 * strlcpy.c
 *    strncpy done right
 *
 * This file was taken from OpenBSD and is used on platforms that don't
 * provide strlcpy().  The OpenBSD copyright terms follow.
 *-------------------------------------------------------------------------
 */

/*  $OpenBSD: strlcpy.c,v 1.11 2006/05/05 15:27:38 millert Exp $    */

/*
 * Copyright (c) 1998 Todd C. Miller <Todd.Miller@courtesan.com>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
 
/*
 * Copy src to string dst of size siz.  At most siz-1 characters
 * will be copied.  Always NUL terminates (unless siz == 0).
 * Returns strlen(src); if retval >= siz, truncation occurred.
 * Function creation history:  http://www.gratisoft.us/todd/papers/strlcpy.html
 */
size_t
strlcpy(char *dst, const char *src, size_t siz)
{
    char       *d = dst;
    const char *s = src;
    size_t      n = siz;

    /* Copy as many bytes as will fit */
    if (n != 0)
    {
        while (--n != 0)
        {
            if ((*d++ = *s++) == '\0')
                break;
        }
    }

    /* Not enough room in dst, add NUL and traverse rest of src */
    if (n == 0)
    {
        if (siz != 0)
            *d = '\0';          /* NUL-terminate dst */
        while (*s++)
            ;
    }

    return (s - src - 1);       /* count does not include NUL */
}
