#define __18F97J60
#define __SDCC__
#define THIS_INCLUDES_THE_MAIN_FUNCTION

#include <string.h>
#include <stdlib.h>

#include "Include/HardwareProfile.h"
#include "Include/LCDBlocking.h"
#include "clock.h"

// With Timer1, we computed that 1532 overflows from timer0  occured in 
// 16 seconds (Timer1). This equals to 95.75 overflow per second.
#define TIMER0_OVERFLOW_PER_SECOND 95.75

// Main variables
long globalcount = 0; //tick count
long alarmtime; //for alarm
int mode; //mode. 0=display,1=edit alarm,2=edit clock,3=alarm on

// Variables for editing modes
long editValues[3]; //values for edit
int position = 0; //position. 0=hours,1=minutes,2=seconds

/*
 * Manage high priority interrupts
 */
void HighISR(void) interrupt 1
{
    if(INTCONbits.T0IF)
    {
        // clear timer0 overflow bit and increment globalcount
        INTCONbits.T0IF=0;
        globalcount++;
        if(globalcount==8272800) globalcount = 0;
    }
}

/*
 * Set the mode in which program is running
 * Mode 0 : Display time
 * Mode 1 : Edit alarm
 * Mode 2 : Edit clock
 * Mode 3 : Alarm on
 */
void setMode(int new_mode)
{
    long seconds;
    
    if(new_mode != mode)
    {
        if(new_mode == 0)
        {
            mode = 0;
            LATJbits.LATJ0=0;
        }
        else if(new_mode == 1)
        {
            mode = 1;
            position = 0;
            seconds = alarmtime == -1 ? 0 : alarmtime;
            editValues[2] = seconds%60;
            editValues[1] = (seconds/60)%60;
            editValues[0] = (seconds/60/60)%24;
        }
        else if(new_mode == 2)
        {
            mode = 2;
            position = 0;
            seconds = globalcount/TIMER0_OVERFLOW_PER_SECOND;
            editValues[2] = seconds%60;
            editValues[1] = (seconds/60)%60;
            editValues[0] = (seconds/60/60)%24;
        }
        else
        {
            mode = 3;
        }
    }
}

/*
 * Manage events (when buttons are pressed)
 */
void updateMode(int button)
{
    long seconds;
    
    if(mode == 0)
    {
        // Switching to edit alarm/clock mode
        setMode(button);
    }
    else if(mode == 1 || mode == 2)
    {
        // Move the cursor to the next position
        if(button == 1)
            editValues[position] = (editValues[position] + 1) % ((position == 0) ? 24 : 60);
        else
        {
            if(position == 2)
            {
                // Values are all edited, resume to mode 0
                seconds = editValues[0]*60*60 + editValues[1]*60+ editValues[2];
                if(mode == 2)
                    // Save new time
                    globalcount = seconds*TIMER0_OVERFLOW_PER_SECOND;
                else
                    // Save new alarm
                    alarmtime = seconds;
                setMode(0);
            }
            else
                // Move the cursor
                position++;
        }
        
    }
    else
    {
        alarmtime = -1;
        setMode(0);
    }
}

/*
 * Manage low priority interrupts (buttons)
 */ 
void LowISR(void) interrupt 2
{
    if(INTCON3bits.INT1IF)
    {
        INTCON3bits.INT1IF = 0;
        updateMode(2);
    }
    
    if(INTCON3bits.INT3IF)
    {
        INTCON3bits.INT3IF = 0;
        updateMode(1);
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
    
    LATJbits.LATJ0      = 0; // switch LED off
    LATJbits.LATJ1      = 0; // switch LED off
    LATJbits.LATJ2      = 0; // switch LED off
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

void DisplayTime(BYTE pos)
{
    int th,tm,ts;
    long seconds = globalcount/TIMER0_OVERFLOW_PER_SECOND;
    if(mode==0 || mode == 3)
    {
        ts = seconds%60;
        tm = (seconds/60)%60;
        th = (seconds/60/60)%24;
    }
    else
    {
        ts = editValues[2];
        tm = editValues[1];
        th = editValues[0];
        
    }
    DisplayTimeNumber(pos+0,th);
    LCDText[pos+2]=':';
    DisplayTimeNumber(pos+3,tm);
    LCDText[pos+5]=':';
    DisplayTimeNumber(pos+6,ts);
    if((mode == 1 || mode==2) && seconds % 2 == 0)
    {
        LCDText[pos+position*3]=' ';
        LCDText[pos+position*3+1]=' ';
    }
    LCDUpdate();
}

void main()
{
    // Variables to compute actual time
    long actual_time;
    long prev_actual_time = -1;
    
    // Variables to compute edition time
    long edit_time;
    long prev_edit_time = -1;
    
    init_board();
    
    globalcount = 8271000; // tick count = 0
    alarmtime = -1; // alarm is not set
    setMode(2); // default mode = display
    
    LCDInit();
    activateTimer();
    
    while(1)
    {
        // Computes actual/edit time
        actual_time = globalcount/TIMER0_OVERFLOW_PER_SECOND;
        edit_time = editValues[0]*60*60+editValues[1]*60+editValues[2];
        
        // If actual/edit time has changed
        if(actual_time != prev_actual_time || edit_time != prev_edit_time)
        {
            prev_actual_time = actual_time;
            prev_edit_time = edit_time;
            
            DisplayTime(4);
            
            // Check if alarm is on
            if(mode==3)
            {
                LATJbits.LATJ0^=1; // led blinks
                // If alarm has been on for 30 seconds, switch it off
                if(actual_time==alarmtime+30)
                {
                    alarmtime = -1;
                    setMode(0);
                }
            }
            else if(actual_time==alarmtime) // triggers alarm
                setMode(3);
                
            // Displaying mode
            switch(mode)
            {
                case 0:
                    DisplayString(16, "               ");
                    break;
                case 1:
                    DisplayString(16, "Definir Alarme");
                    break;
                case 2:
                    DisplayString(16, "Definir Heure");
                    break;
                case 3:
                    DisplayString(16, "ALARME! ALARME!");
                    break;
            }
        }
    }
}
