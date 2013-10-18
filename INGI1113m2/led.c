#define __18F97J60
#define __SDCC__
#define THIS_INCLUDES_THE_MAIN_FUNCTION
#include "Include/HardwareProfile.h"

#include <string.h>
#include <stdlib.h>

#include "Include/LCDBlocking.h"
#include "Include/TCPIP_Stack/Delay.h"

//With Timer1, we computed that 1531 times a 16-bit overflow from timer0 equals to 16 seconds (Timer1). This equals to 95.75 overflow per second.
#define TIMER0_OVERFLOW_PER_SECOND 95.75

long globalcount; //tick count
long clockoffset; //for clock
long alarmtime;   //for alarm
int mode; //mode. 0=display,1=edit clock,2=edit alarm,3=alarm on
int position; //position. 0=hours,1=minutes,2=seconds
long editValues[3]; //values for edit

// Fonction
size_t strlcpy(char *dst, const char *src, size_t siz);
void DisplayWORD(BYTE pos, WORD w);
void DisplayString(BYTE pos, char* text);

void HighISR(void) interrupt 1
{
    if(INTCONbits.T0IF)
    {
        INTCONbits.T0IF=0; // clear timer0 overflow bit
        globalcount++;
        if(globalcount % 95 == 0)
            LATJbits.LATJ0^=1;
    }
}

void updateMode(int button)
{
    int i;
    long s;
    
    if(mode == 0) //display
    {
        mode = button;
        position = 0;
        for(i = 0; i < 3; i++)
            editValues[i]=0;
    }
    else if(mode == 3) //alarm is on
    {
        mode = 0;
    }
    //mode == 1 || mode == 2
    else if(button == 1) //next position
    {
        if(position == 2) //close edit
        {
            s = ((editValues[0]%24)*60+(editValues[1]%60))*60+(editValues[0]%60);
            if(mode == 1) //clock set
                clockoffset = s - globalcount/TIMER0_OVERFLOW_PER_SECOND;
            else
                alarmtime = s;
            mode = 0;
        }
        else
            position++;
    }
    else if(button == 2) //next value
    {
        editValues[position]++;
    }
}

void LowISR(void) interrupt 2
{
    if(INTCON3bits.INT1IF)
    {
        INTCON3bits.INT1IF = 0;
        updateMode(1);
    }
    
    if(INTCON3bits.INT3IF)
    {
        INTCON3bits.INT3IF = 0;
        updateMode(2);
    }
}

void activateTimer()
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
    
    INTCON3bits.INT1E   = 1;   //INT1 activate
    INTCON2bits.INTEDG1 = 0;   //INT1 interrupts on falling edge
    INTCON3bits.INT1IP  = 0;   //INT1 low priority
    
    INTCON3bits.INT3E   = 1;   //INT3 activate
    INTCON2bits.INTEDG3 = 0;   //INT3 interrupts on falling edge
    INTCON2bits.INT3IP  = 0;   //INT3 low priority
}

//Val < 60
void DisplayTimeNumber(BYTE pos, int val)
{
    BYTE WDigit[3]; //enough for a  number < 60: 2 digits + \0
    BYTE j;
    unsigned radix=10; //type expected by sdcc's ultoa()
    ultoa(val, WDigit, radix);
    if(WDigit[1] == '\0') //always display two digits
    {
        WDigit[2] = WDigit[1];
        WDigit[1] = WDigit[0];
        WDigit[0] = '0';
    }
    for(j = 0; j < 2; j++)
        LCDText[(pos+j)%32] = WDigit[j];
}

void DisplayTime(BYTE pos, long seconds)
{
    int th,tm,ts;
    ts = seconds%60;
    tm = (seconds/60)%60;
    th = (seconds/60/60)%24;
    DisplayTimeNumber(pos+0,th);
    LCDText[pos+2]=':';
    DisplayTimeNumber(pos+3,tm);
    LCDText[pos+5]=':';
    DisplayTimeNumber(pos+6,ts);
    LCDUpdate();
}

void DisplayEditTime(BYTE pos, long seconds)
{
    int th,tm,ts;
    ts = editValues[2]%60;
    tm = editValues[1]%60;
    th = editValues[0]%60;
    DisplayTimeNumber(pos+0,th);
    LCDText[pos+2]=':';
    DisplayTimeNumber(pos+3,tm);
    LCDText[pos+5]=':';
    DisplayTimeNumber(pos+6,ts);
    if(seconds % 2 == 0)
    {
        LCDText[pos+position*3]=' ';
        LCDText[pos+position*3+1]=' ';
    }
    LCDUpdate();
}

void main()
{
    long last;
    long lastedit;
    long n;
    long nedit;
    
	init_board();
    
	LATJbits.LATJ0=0; // switch LED off
	LATJbits.LATJ1=0; // switch LED off
    LATJbits.LATJ2=0; // switch LED off
    
    globalcount = 0;  // tick count = 0
    clockoffset = 0;  // clockoffset is 0
    alarmtime = -1;   // alarm is not set
    mode = 0;         // default mode = display
    
    LCDInit();
    activateTimer();
    
    last = -1;
    lastedit = -1;
    while(1)
    {
        n = clockoffset + globalcount/TIMER0_OVERFLOW_PER_SECOND;
        nedit = editValues[0]+editValues[1]+editValues[2];
        if(n != last || nedit != lastedit)
        {
            last = n;
            lastedit = nedit;
            
            if(alarmtime != -1 && last >= alarmtime)
            {
                mode = 3;
                alarmtime = -1;
            }
            
            if(mode == 0 || mode == 3)
            {
                DisplayTime(4, last);
                if(mode == 0)
                    DisplayString(16, "ALARME! ALARME!");
                else
                    DisplayString(16, "               ");
            }
            else //mode == 1 || mode == 2
            {
                DisplayEditTime(4, last);
                if(mode == 1)
                    DisplayString(16, "Definir Heure");
                else
                    DisplayString(16, "Definir Alarme");
            }
        }
    }
}

void DisplayString(BYTE pos, char* text)
{
    BYTE l= strlen(text)+1;
    BYTE max= 32-pos;
    strlcpy((char*)&LCDText[pos], text,(l<max)?l:max );
    LCDUpdate();
}

/*************************************************
 Function DisplayWORD:
 writes a WORD in hexa on the position indicated by
 pos.
 - pos=0 -> 1st line of the LCD
 - pos=16 -> 2nd line of the LCD
 
 __SDCC__ only: for debugging
 *************************************************/
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
size_t strlcpy(char *dst, const char *src, size_t siz)
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