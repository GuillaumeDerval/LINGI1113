;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5595 (Oct 18 2013) (UNIX)
; This file was generated Fri Oct 18 13:49:38 2013
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f97j60

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _DisplayString
	global _DisplayWORD
	global _strlcpy
	global _globalcount
	global _clockoffset
	global _alarmtime
	global _mode
	global _position
	global _editValues
	global _HighISR
	global _updateMode
	global _LowISR
	global _activateTimer
	global _init_board
	global _DisplayTimeNumber
	global _DisplayTime
	global _DisplayEditTime
	global _main

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern __gptrget1
	extern __gptrput1
	extern _EBSTCONbits
	extern _MISTATbits
	extern _EFLOCONbits
	extern _MACON1bits
	extern _MACON2bits
	extern _MACON3bits
	extern _MACON4bits
	extern _MACLCON1bits
	extern _MACLCON2bits
	extern _MICONbits
	extern _MICMDbits
	extern _EWOLIEbits
	extern _EWOLIRbits
	extern _ERXFCONbits
	extern _EIEbits
	extern _ESTATbits
	extern _ECON2bits
	extern _EIRbits
	extern _EDATAbits
	extern _SSP2CON2bits
	extern _SSP2CON1bits
	extern _SSP2STATbits
	extern _ECCP2DELbits
	extern _ECCP2ASbits
	extern _ECCP3DELbits
	extern _ECCP3ASbits
	extern _RCSTA2bits
	extern _TXSTA2bits
	extern _CCP5CONbits
	extern _CCP4CONbits
	extern _T4CONbits
	extern _ECCP1DELbits
	extern _BAUDCON2bits
	extern _BAUDCTL2bits
	extern _BAUDCONbits
	extern _BAUDCON1bits
	extern _BAUDCTLbits
	extern _BAUDCTL1bits
	extern _PORTAbits
	extern _PORTBbits
	extern _PORTCbits
	extern _PORTDbits
	extern _PORTEbits
	extern _PORTFbits
	extern _PORTGbits
	extern _PORTHbits
	extern _PORTJbits
	extern _LATAbits
	extern _LATBbits
	extern _LATCbits
	extern _LATDbits
	extern _LATEbits
	extern _LATFbits
	extern _LATGbits
	extern _LATHbits
	extern _LATJbits
	extern _DDRAbits
	extern _TRISAbits
	extern _DDRBbits
	extern _TRISBbits
	extern _DDRCbits
	extern _TRISCbits
	extern _DDRDbits
	extern _TRISDbits
	extern _DDREbits
	extern _TRISEbits
	extern _DDRFbits
	extern _TRISFbits
	extern _DDRGbits
	extern _TRISGbits
	extern _DDRHbits
	extern _TRISHbits
	extern _DDRJbits
	extern _TRISJbits
	extern _OSCTUNEbits
	extern _MEMCONbits
	extern _PIE1bits
	extern _PIR1bits
	extern _IPR1bits
	extern _PIE2bits
	extern _PIR2bits
	extern _IPR2bits
	extern _PIE3bits
	extern _PIR3bits
	extern _IPR3bits
	extern _EECON1bits
	extern _RCSTAbits
	extern _RCSTA1bits
	extern _TXSTAbits
	extern _TXSTA1bits
	extern _PSPCONbits
	extern _T3CONbits
	extern _CMCONbits
	extern _CVRCONbits
	extern _ECCP1ASbits
	extern _CCP3CONbits
	extern _ECCP3CONbits
	extern _CCP2CONbits
	extern _ECCP2CONbits
	extern _CCP1CONbits
	extern _ECCP1CONbits
	extern _ADCON2bits
	extern _ADCON1bits
	extern _ADCON0bits
	extern _SSP1CON2bits
	extern _SSPCON2bits
	extern _SSP1CON1bits
	extern _SSPCON1bits
	extern _SSP1STATbits
	extern _SSPSTATbits
	extern _T2CONbits
	extern _T1CONbits
	extern _RCONbits
	extern _WDTCONbits
	extern _ECON1bits
	extern _OSCCONbits
	extern _T0CONbits
	extern _STATUSbits
	extern _INTCON3bits
	extern _INTCON2bits
	extern _INTCONbits
	extern _STKPTRbits
	extern _stdin
	extern _stdout
	extern _LCDText
	extern _MAADR5
	extern _MAADR6
	extern _MAADR3
	extern _MAADR4
	extern _MAADR1
	extern _MAADR2
	extern _EBSTSD
	extern _EBSTCON
	extern _EBSTCS
	extern _EBSTCSL
	extern _EBSTCSH
	extern _MISTAT
	extern _EFLOCON
	extern _EPAUS
	extern _EPAUSL
	extern _EPAUSH
	extern _MACON1
	extern _MACON2
	extern _MACON3
	extern _MACON4
	extern _MABBIPG
	extern _MAIPG
	extern _MAIPGL
	extern _MAIPGH
	extern _MACLCON1
	extern _MACLCON2
	extern _MAMXFL
	extern _MAMXFLL
	extern _MAMXFLH
	extern _MICON
	extern _MICMD
	extern _MIREGADR
	extern _MIWR
	extern _MIWRL
	extern _MIWRH
	extern _MIRD
	extern _MIRDL
	extern _MIRDH
	extern _EHT0
	extern _EHT1
	extern _EHT2
	extern _EHT3
	extern _EHT4
	extern _EHT5
	extern _EHT6
	extern _EHT7
	extern _EPMM0
	extern _EPMM1
	extern _EPMM2
	extern _EPMM3
	extern _EPMM4
	extern _EPMM5
	extern _EPMM6
	extern _EPMM7
	extern _EPMCS
	extern _EPMCSL
	extern _EPMCSH
	extern _EPMO
	extern _EPMOL
	extern _EPMOH
	extern _EWOLIE
	extern _EWOLIR
	extern _ERXFCON
	extern _EPKTCNT
	extern _EWRPT
	extern _EWRPTL
	extern _EWRPTH
	extern _ETXST
	extern _ETXSTL
	extern _ETXSTH
	extern _ETXND
	extern _ETXNDL
	extern _ETXNDH
	extern _ERXST
	extern _ERXSTL
	extern _ERXSTH
	extern _ERXND
	extern _ERXNDL
	extern _ERXNDH
	extern _ERXRDPT
	extern _ERXRDPTL
	extern _ERXRDPTH
	extern _ERXWRPT
	extern _ERXWRPTL
	extern _ERXWRPTH
	extern _EDMAST
	extern _EDMASTL
	extern _EDMASTH
	extern _EDMAND
	extern _EDMANDL
	extern _EDMANDH
	extern _EDMADST
	extern _EDMADSTL
	extern _EDMADSTH
	extern _EDMACS
	extern _EDMACSL
	extern _EDMACSH
	extern _EIE
	extern _ESTAT
	extern _ECON2
	extern _EIR
	extern _EDATA
	extern _SSP2CON2
	extern _SSP2CON1
	extern _SSP2STAT
	extern _SSP2ADD
	extern _SSP2BUF
	extern _ECCP2DEL
	extern _ECCP2AS
	extern _ECCP3DEL
	extern _ECCP3AS
	extern _RCSTA2
	extern _TXSTA2
	extern _TXREG2
	extern _RCREG2
	extern _SPBRG2
	extern _CCP5CON
	extern _CCPR5
	extern _CCPR5L
	extern _CCPR5H
	extern _CCP4CON
	extern _CCPR4
	extern _CCPR4L
	extern _CCPR4H
	extern _T4CON
	extern _PR4
	extern _TMR4
	extern _ECCP1DEL
	extern _ERDPT
	extern _ERDPTL
	extern _ERDPTH
	extern _BAUDCON2
	extern _BAUDCTL2
	extern _SPBRGH2
	extern _BAUDCON
	extern _BAUDCON1
	extern _BAUDCTL
	extern _BAUDCTL1
	extern _SPBRGH
	extern _SPBRGH1
	extern _PORTA
	extern _PORTB
	extern _PORTC
	extern _PORTD
	extern _PORTE
	extern _PORTF
	extern _PORTG
	extern _PORTH
	extern _PORTJ
	extern _LATA
	extern _LATB
	extern _LATC
	extern _LATD
	extern _LATE
	extern _LATF
	extern _LATG
	extern _LATH
	extern _LATJ
	extern _DDRA
	extern _TRISA
	extern _DDRB
	extern _TRISB
	extern _DDRC
	extern _TRISC
	extern _DDRD
	extern _TRISD
	extern _DDRE
	extern _TRISE
	extern _DDRF
	extern _TRISF
	extern _DDRG
	extern _TRISG
	extern _DDRH
	extern _TRISH
	extern _DDRJ
	extern _TRISJ
	extern _OSCTUNE
	extern _MEMCON
	extern _PIE1
	extern _PIR1
	extern _IPR1
	extern _PIE2
	extern _PIR2
	extern _IPR2
	extern _PIE3
	extern _PIR3
	extern _IPR3
	extern _EECON1
	extern _EECON2
	extern _RCSTA
	extern _RCSTA1
	extern _TXSTA
	extern _TXSTA1
	extern _TXREG
	extern _TXREG1
	extern _RCREG
	extern _RCREG1
	extern _SPBRG
	extern _SPBRG1
	extern _PSPCON
	extern _T3CON
	extern _TMR3L
	extern _TMR3H
	extern _CMCON
	extern _CVRCON
	extern _ECCP1AS
	extern _CCP3CON
	extern _ECCP3CON
	extern _CCPR3
	extern _CCPR3L
	extern _CCPR3H
	extern _CCP2CON
	extern _ECCP2CON
	extern _CCPR2
	extern _CCPR2L
	extern _CCPR2H
	extern _CCP1CON
	extern _ECCP1CON
	extern _CCPR1
	extern _CCPR1L
	extern _CCPR1H
	extern _ADCON2
	extern _ADCON1
	extern _ADCON0
	extern _ADRES
	extern _ADRESL
	extern _ADRESH
	extern _SSP1CON2
	extern _SSPCON2
	extern _SSP1CON1
	extern _SSPCON1
	extern _SSP1STAT
	extern _SSPSTAT
	extern _SSP1ADD
	extern _SSPADD
	extern _SSP1BUF
	extern _SSPBUF
	extern _T2CON
	extern _PR2
	extern _TMR2
	extern _T1CON
	extern _TMR1L
	extern _TMR1H
	extern _RCON
	extern _WDTCON
	extern _ECON1
	extern _OSCCON
	extern _T0CON
	extern _TMR0L
	extern _TMR0H
	extern _STATUS
	extern _FSR2L
	extern _FSR2H
	extern _PLUSW2
	extern _PREINC2
	extern _POSTDEC2
	extern _POSTINC2
	extern _INDF2
	extern _BSR
	extern _FSR1L
	extern _FSR1H
	extern _PLUSW1
	extern _PREINC1
	extern _POSTDEC1
	extern _POSTINC1
	extern _INDF1
	extern _WREG
	extern _FSR0L
	extern _FSR0H
	extern _PLUSW0
	extern _PREINC0
	extern _POSTDEC0
	extern _POSTINC0
	extern _INDF0
	extern _INTCON3
	extern _INTCON2
	extern _INTCON
	extern _PROD
	extern _PRODL
	extern _PRODH
	extern _TABLAT
	extern _TBLPTR
	extern _TBLPTRL
	extern _TBLPTRH
	extern _TBLPTRU
	extern _PC
	extern _PCL
	extern _PCLATH
	extern _PCLATU
	extern _STKPTR
	extern _TOS
	extern _TOSL
	extern _TOSH
	extern _TOSU
	extern _ultoa
	extern _strlen
	extern _LCDInit
	extern _LCDUpdate
	extern __modslong
	extern ___slong2fs
	extern ___fsdiv
	extern ___fsadd
	extern ___fs2slong
	extern __divslong
	extern __mullong
	extern ___fssub
	extern __mulint
	extern __modsint
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCLATH	equ	0xffa
PCLATU	equ	0xffb
WREG	equ	0xfe8
BSR	equ	0xfe0
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTINC0	equ	0xfee
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1
r0x06	res	1
r0x07	res	1
r0x08	res	1
r0x09	res	1
r0x0a	res	1
r0x0b	res	1
r0x0c	res	1
r0x0d	res	1
r0x0e	res	1
r0x0f	res	1
r0x10	res	1
r0x11	res	1
r0x12	res	1
r0x13	res	1
r0x14	res	1
r0x15	res	1

udata_led_0	udata
_globalcount	res	4

udata_led_1	udata
_mode	res	2

udata_led_2	udata
_position	res	2

udata_led_3	udata
_clockoffset	res	4

udata_led_4	udata
_alarmtime	res	4

udata_led_5	udata
_editValues	res	12

udata_led_6	udata
_DisplayTimeNumber_WDigit_1_1	res	3

udata_led_7	udata
_DisplayWORD_WDigit_1_1	res	6

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; ; Starting pCode block for absolute section
; ;-----------------------------------------
S_led_ivec_0x1_HighISR	code	0X000008
ivec_0x1_HighISR:
	GOTO	_HighISR

; ; Starting pCode block for absolute section
; ;-----------------------------------------
S_led_ivec_0x2_LowISR	code	0X000018
ivec_0x2_LowISR:
	GOTO	_LowISR

; I code from now on!
; ; Starting pCode block
S_led__main	code
_main:
;	.line	186; led.c	init_board();
	CALL	_init_board
;	.line	188; led.c	LATJbits.LATJ0=0; // switch LED off
	BCF	_LATJbits, 0
;	.line	189; led.c	LATJbits.LATJ1=0; // switch LED off
	BCF	_LATJbits, 1
;	.line	190; led.c	LATJbits.LATJ2=0; // switch LED off
	BCF	_LATJbits, 2
	BANKSEL	_globalcount
;	.line	192; led.c	globalcount = 0;  // tick count = 0
	CLRF	_globalcount, B
	BANKSEL	(_globalcount + 1)
	CLRF	(_globalcount + 1), B
	BANKSEL	(_globalcount + 2)
	CLRF	(_globalcount + 2), B
	BANKSEL	(_globalcount + 3)
	CLRF	(_globalcount + 3), B
	BANKSEL	_clockoffset
;	.line	193; led.c	clockoffset = 0;  // clockoffset is 0
	CLRF	_clockoffset, B
	BANKSEL	(_clockoffset + 1)
	CLRF	(_clockoffset + 1), B
	BANKSEL	(_clockoffset + 2)
	CLRF	(_clockoffset + 2), B
	BANKSEL	(_clockoffset + 3)
	CLRF	(_clockoffset + 3), B
;	.line	194; led.c	alarmtime = -1;   // alarm is not set
	MOVLW	0xff
	BANKSEL	_alarmtime
	MOVWF	_alarmtime, B
	BANKSEL	(_alarmtime + 1)
	MOVWF	(_alarmtime + 1), B
	BANKSEL	(_alarmtime + 2)
	MOVWF	(_alarmtime + 2), B
	BANKSEL	(_alarmtime + 3)
	MOVWF	(_alarmtime + 3), B
	BANKSEL	_mode
;	.line	195; led.c	mode = 0;         // default mode = display
	CLRF	_mode, B
	BANKSEL	(_mode + 1)
	CLRF	(_mode + 1), B
;	.line	197; led.c	LCDInit();
	CALL	_LCDInit
;	.line	198; led.c	activateTimer();
	CALL	_activateTimer
;	.line	200; led.c	last = -1;
	MOVLW	0xff
	MOVWF	r0x00
	MOVWF	r0x01
	MOVWF	r0x02
	MOVWF	r0x03
;	.line	201; led.c	lastedit = -1;
	MOVLW	0xff
	MOVWF	r0x04
	MOVWF	r0x05
	MOVWF	r0x06
	MOVWF	r0x07
_00218_DS_:
	BANKSEL	(_globalcount + 3)
;	.line	204; led.c	n = clockoffset + globalcount/TIMER0_OVERFLOW_PER_SECOND;
	MOVF	(_globalcount + 3), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_globalcount + 2)
	MOVF	(_globalcount + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_globalcount + 1)
	MOVF	(_globalcount + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_globalcount
	MOVF	_globalcount, W, B
	MOVWF	POSTDEC1
	CALL	___slong2fs
	MOVWF	r0x08
	MOVFF	PRODL, r0x09
	MOVFF	PRODH, r0x0a
	MOVFF	FSR0L, r0x0b
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x42
	MOVWF	POSTDEC1
	MOVLW	0xbe
	MOVWF	POSTDEC1
	MOVLW	0xa3
	MOVWF	POSTDEC1
	MOVLW	0xd7
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	CALL	___fsdiv
	MOVWF	r0x08
	MOVFF	PRODL, r0x09
	MOVFF	PRODH, r0x0a
	MOVFF	FSR0L, r0x0b
	MOVLW	0x08
	ADDWF	FSR1L, F
	BANKSEL	(_clockoffset + 3)
	MOVF	(_clockoffset + 3), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_clockoffset + 2)
	MOVF	(_clockoffset + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_clockoffset + 1)
	MOVF	(_clockoffset + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_clockoffset
	MOVF	_clockoffset, W, B
	MOVWF	POSTDEC1
	CALL	___slong2fs
	MOVWF	r0x0c
	MOVFF	PRODL, r0x0d
	MOVFF	PRODH, r0x0e
	MOVFF	FSR0L, r0x0f
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x0f, W
	MOVWF	POSTDEC1
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	CALL	___fsadd
	MOVWF	r0x08
	MOVFF	PRODL, r0x09
	MOVFF	PRODH, r0x0a
	MOVFF	FSR0L, r0x0b
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	CALL	___fs2slong
	MOVWF	r0x08
	MOVFF	PRODL, r0x09
	MOVFF	PRODH, r0x0a
	MOVFF	FSR0L, r0x0b
	MOVLW	0x04
	ADDWF	FSR1L, F
	BANKSEL	(_editValues + 4)
;	.line	205; led.c	nedit = editValues[0]+editValues[1]+editValues[2];
	MOVF	(_editValues + 4), W, B
	BANKSEL	_editValues
	ADDWF	_editValues, W, B
	MOVWF	r0x0c
	BANKSEL	(_editValues + 5)
	MOVF	(_editValues + 5), W, B
	BANKSEL	(_editValues + 1)
	ADDWFC	(_editValues + 1), W, B
	MOVWF	r0x0d
	BANKSEL	(_editValues + 6)
	MOVF	(_editValues + 6), W, B
	BANKSEL	(_editValues + 2)
	ADDWFC	(_editValues + 2), W, B
	MOVWF	r0x0e
	BANKSEL	(_editValues + 7)
	MOVF	(_editValues + 7), W, B
	BANKSEL	(_editValues + 3)
	ADDWFC	(_editValues + 3), W, B
	MOVWF	r0x0f
	BANKSEL	(_editValues + 8)
	MOVF	(_editValues + 8), W, B
	ADDWF	r0x0c, F
	BANKSEL	(_editValues + 9)
	MOVF	(_editValues + 9), W, B
	ADDWFC	r0x0d, F
	BANKSEL	(_editValues + 10)
	MOVF	(_editValues + 10), W, B
	ADDWFC	r0x0e, F
	BANKSEL	(_editValues + 11)
	MOVF	(_editValues + 11), W, B
	ADDWFC	r0x0f, F
;	.line	206; led.c	if(n != last || nedit != lastedit)
	MOVF	r0x08, W
	XORWF	r0x00, W
	BNZ	_00229_DS_
	MOVF	r0x09, W
	XORWF	r0x01, W
	BNZ	_00229_DS_
	MOVF	r0x0a, W
	XORWF	r0x02, W
	BNZ	_00229_DS_
	MOVF	r0x0b, W
	XORWF	r0x03, W
	BZ	_00230_DS_
_00229_DS_:
	BRA	_00214_DS_
_00230_DS_:
	MOVF	r0x0c, W
	XORWF	r0x04, W
	BNZ	_00214_DS_
	MOVF	r0x0d, W
	XORWF	r0x05, W
	BNZ	_00214_DS_
	MOVF	r0x0e, W
	XORWF	r0x06, W
	BNZ	_00214_DS_
	MOVF	r0x0f, W
	XORWF	r0x07, W
	BNZ	_00214_DS_
	BRA	_00218_DS_
_00214_DS_:
;	.line	208; led.c	last = n;
	MOVFF	r0x08, r0x00
	MOVFF	r0x09, r0x01
	MOVFF	r0x0a, r0x02
	MOVFF	r0x0b, r0x03
;	.line	209; led.c	lastedit = nedit;
	MOVFF	r0x0c, r0x04
	MOVFF	r0x0d, r0x05
	MOVFF	r0x0e, r0x06
	MOVFF	r0x0f, r0x07
	BANKSEL	_alarmtime
;	.line	211; led.c	if(alarmtime != -1 && last >= alarmtime)
	MOVF	_alarmtime, W, B
	XORLW	0xff
	BNZ	_00234_DS_
	BANKSEL	(_alarmtime + 1)
	MOVF	(_alarmtime + 1), W, B
	XORLW	0xff
	BNZ	_00234_DS_
	BANKSEL	(_alarmtime + 2)
	MOVF	(_alarmtime + 2), W, B
	XORLW	0xff
	BNZ	_00234_DS_
	BANKSEL	(_alarmtime + 3)
	MOVF	(_alarmtime + 3), W, B
	XORLW	0xff
	BZ	_00202_DS_
_00234_DS_:
	MOVF	r0x0b, W
	ADDLW	0x80
	MOVWF	PRODL
	BANKSEL	(_alarmtime + 3)
	MOVF	(_alarmtime + 3), W, B
	ADDLW	0x80
	SUBWF	PRODL, W
	BNZ	_00235_DS_
	BANKSEL	(_alarmtime + 2)
	MOVF	(_alarmtime + 2), W, B
	SUBWF	r0x0a, W
	BNZ	_00235_DS_
	BANKSEL	(_alarmtime + 1)
	MOVF	(_alarmtime + 1), W, B
	SUBWF	r0x09, W
	BNZ	_00235_DS_
	BANKSEL	_alarmtime
	MOVF	_alarmtime, W, B
	SUBWF	r0x08, W
_00235_DS_:
	BNC	_00202_DS_
;	.line	213; led.c	mode = 3;
	MOVLW	0x03
	BANKSEL	_mode
	MOVWF	_mode, B
	BANKSEL	(_mode + 1)
	CLRF	(_mode + 1), B
;	.line	214; led.c	alarmtime = -1;
	MOVLW	0xff
	BANKSEL	_alarmtime
	MOVWF	_alarmtime, B
	BANKSEL	(_alarmtime + 1)
	MOVWF	(_alarmtime + 1), B
	BANKSEL	(_alarmtime + 2)
	MOVWF	(_alarmtime + 2), B
	BANKSEL	(_alarmtime + 3)
	MOVWF	(_alarmtime + 3), B
_00202_DS_:
	BANKSEL	_mode
;	.line	217; led.c	if(mode == 0 || mode == 3)
	MOVF	_mode, W, B
	BANKSEL	(_mode + 1)
	IORWF	(_mode + 1), W, B
	BZ	_00210_DS_
	BANKSEL	_mode
	MOVF	_mode, W, B
	XORLW	0x03
	BNZ	_00236_DS_
	BANKSEL	(_mode + 1)
	MOVF	(_mode + 1), W, B
	BZ	_00210_DS_
_00236_DS_:
	BRA	_00211_DS_
_00210_DS_:
;	.line	219; led.c	DisplayTime(4, last);
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_DisplayTime
	MOVLW	0x05
	ADDWF	FSR1L, F
	BANKSEL	_mode
;	.line	220; led.c	if(mode == 0)
	MOVF	_mode, W, B
	BANKSEL	(_mode + 1)
	IORWF	(_mode + 1), W, B
	BNZ	_00205_DS_
;	.line	221; led.c	DisplayString(16, "ALARME! ALARME!");
	MOVLW	UPPER(__str_0)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_0)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_0)
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	CALL	_DisplayString
	MOVLW	0x04
	ADDWF	FSR1L, F
	BRA	_00218_DS_
_00205_DS_:
;	.line	223; led.c	DisplayString(16, "               ");
	MOVLW	UPPER(__str_1)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_1)
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	CALL	_DisplayString
	MOVLW	0x04
	ADDWF	FSR1L, F
	BRA	_00218_DS_
_00211_DS_:
;	.line	227; led.c	DisplayEditTime(4, last);
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_DisplayEditTime
	MOVLW	0x05
	ADDWF	FSR1L, F
	BANKSEL	_mode
;	.line	228; led.c	if(mode == 1)
	MOVF	_mode, W, B
	XORLW	0x01
	BNZ	_00238_DS_
	BANKSEL	(_mode + 1)
	MOVF	(_mode + 1), W, B
	BZ	_00239_DS_
_00238_DS_:
	BRA	_00208_DS_
_00239_DS_:
;	.line	229; led.c	DisplayString(16, "Definir Heure");
	MOVLW	UPPER(__str_2)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_2)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_2)
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	CALL	_DisplayString
	MOVLW	0x04
	ADDWF	FSR1L, F
	BRA	_00218_DS_
_00208_DS_:
;	.line	231; led.c	DisplayString(16, "Definir Alarme");
	MOVLW	UPPER(__str_3)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_3)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_3)
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	CALL	_DisplayString
	MOVLW	0x04
	ADDWF	FSR1L, F
	BRA	_00218_DS_
	RETURN	

; ; Starting pCode block
S_led__strlcpy	code
_strlcpy:
;	.line	306; led.c	size_t strlcpy(char *dst, const char *src, size_t siz)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVFF	r0x0a, POSTDEC1
	MOVFF	r0x0b, POSTDEC1
	MOVFF	r0x0c, POSTDEC1
	MOVFF	r0x0d, POSTDEC1
	MOVFF	r0x0e, POSTDEC1
	MOVFF	r0x0f, POSTDEC1
	MOVFF	r0x10, POSTDEC1
	MOVFF	r0x11, POSTDEC1
	MOVFF	r0x12, POSTDEC1
	MOVFF	r0x13, POSTDEC1
	MOVFF	r0x14, POSTDEC1
	MOVFF	r0x15, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
	MOVLW	0x07
	MOVFF	PLUSW2, r0x05
	MOVLW	0x08
	MOVFF	PLUSW2, r0x06
	MOVLW	0x09
	MOVFF	PLUSW2, r0x07
;	.line	308; led.c	char       *d = dst;
	MOVFF	r0x00, r0x08
	MOVFF	r0x01, r0x09
	MOVFF	r0x02, r0x0a
;	.line	309; led.c	const char *s = src;
	MOVFF	r0x03, r0x0b
	MOVFF	r0x04, r0x0c
	MOVFF	r0x05, r0x0d
;	.line	310; led.c	size_t      n = siz;
	MOVFF	r0x06, r0x0e
	MOVFF	r0x07, r0x0f
;	.line	313; led.c	if (n != 0)
	MOVF	r0x06, W
	IORWF	r0x07, W
	BTFSC	STATUS, 2
	BRA	_00278_DS_
;	.line	315; led.c	while (--n != 0)
	MOVFF	r0x03, r0x10
	MOVFF	r0x04, r0x11
	MOVFF	r0x05, r0x12
	MOVFF	r0x06, r0x13
	MOVFF	r0x07, r0x14
_00274_DS_:
	MOVLW	0xff
	ADDWF	r0x13, F
	BTFSS	STATUS, 0
	DECF	r0x14, F
	MOVF	r0x13, W
	IORWF	r0x14, W
	BZ	_00293_DS_
;	.line	317; led.c	if ((*d++ = *s++) == '\0')
	MOVFF	r0x10, FSR0L
	MOVFF	r0x11, PRODL
	MOVF	r0x12, W
	CALL	__gptrget1
	MOVWF	r0x15
	INCF	r0x10, F
	BTFSC	STATUS, 0
	INCF	r0x11, F
	BTFSC	STATUS, 0
	INCF	r0x12, F
	MOVFF	r0x15, POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput1
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVF	r0x15, W
	BNZ	_00274_DS_
_00293_DS_:
;	.line	318; led.c	break;
	MOVFF	r0x10, r0x0b
	MOVFF	r0x11, r0x0c
	MOVFF	r0x12, r0x0d
	MOVFF	r0x00, r0x08
	MOVFF	r0x01, r0x09
	MOVFF	r0x02, r0x0a
	MOVFF	r0x13, r0x0e
	MOVFF	r0x14, r0x0f
_00278_DS_:
;	.line	323; led.c	if (n == 0)
	MOVF	r0x0e, W
	IORWF	r0x0f, W
	BNZ	_00285_DS_
;	.line	325; led.c	if (siz != 0)
	MOVF	r0x06, W
	IORWF	r0x07, W
	BZ	_00292_DS_
;	.line	326; led.c	*d = '\0';          /* NUL-terminate dst */
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, PRODL
	MOVF	r0x0a, W
	CALL	__gptrput1
_00292_DS_:
;	.line	327; led.c	while (*s++)
	MOVFF	r0x0b, r0x00
	MOVFF	r0x0c, r0x01
	MOVFF	r0x0d, r0x02
_00281_DS_:
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x06
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVF	r0x06, W
	BNZ	_00281_DS_
	MOVFF	r0x00, r0x0b
	MOVFF	r0x01, r0x0c
	MOVFF	r0x02, r0x0d
_00285_DS_:
;	.line	331; led.c	return (s - src - 1);       /* count does not include NUL */
	MOVF	r0x03, W
	SUBWF	r0x0b, W
	MOVWF	r0x03
	MOVF	r0x04, W
	SUBWFB	r0x0c, W
	MOVWF	r0x04
	MOVLW	0xff
	ADDWF	r0x03, F
	BTFSS	STATUS, 0
	DECF	r0x04, F
	MOVFF	r0x04, PRODL
	MOVF	r0x03, W
	MOVFF	PREINC1, r0x15
	MOVFF	PREINC1, r0x14
	MOVFF	PREINC1, r0x13
	MOVFF	PREINC1, r0x12
	MOVFF	PREINC1, r0x11
	MOVFF	PREINC1, r0x10
	MOVFF	PREINC1, r0x0f
	MOVFF	PREINC1, r0x0e
	MOVFF	PREINC1, r0x0d
	MOVFF	PREINC1, r0x0c
	MOVFF	PREINC1, r0x0b
	MOVFF	PREINC1, r0x0a
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_led__DisplayWORD	code
_DisplayWORD:
;	.line	254; led.c	void DisplayWORD(BYTE pos, WORD w) //WORD is a 16 bits unsigned
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	262; led.c	ultoa(w, WDigit, radix);
	CLRF	r0x03
	CLRF	r0x04
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVLW	HIGH(_DisplayWORD_WDigit_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_DisplayWORD_WDigit_1_1)
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_ultoa
	MOVLW	0x07
	ADDWF	FSR1L, F
;	.line	263; led.c	for(j = 0; j < strlen((char*)WDigit); j++)
	CLRF	r0x01
_00256_DS_:
	MOVLW	HIGH(_DisplayWORD_WDigit_1_1)
	MOVWF	r0x03
	MOVLW	LOW(_DisplayWORD_WDigit_1_1)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_strlen
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVFF	r0x01, r0x04
	CLRF	r0x05
	MOVF	r0x05, W
	ADDLW	0x80
	MOVWF	PRODL
	MOVF	r0x03, W
	ADDLW	0x80
	SUBWF	PRODL, W
	BNZ	_00266_DS_
	MOVF	r0x02, W
	SUBWF	r0x04, W
_00266_DS_:
	BC	_00259_DS_
;	.line	265; led.c	LCDText[LCDPos++] = WDigit[j];
	MOVFF	r0x00, r0x02
	INCF	r0x00, F
	CLRF	r0x03
	MOVLW	LOW(_LCDText)
	ADDWF	r0x02, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x03, F
	MOVLW	LOW(_DisplayWORD_WDigit_1_1)
	ADDWF	r0x01, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_DisplayWORD_WDigit_1_1)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	INDF0, r0x04
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	r0x04, INDF0
;	.line	263; led.c	for(j = 0; j < strlen((char*)WDigit); j++)
	INCF	r0x01, F
	BRA	_00256_DS_
_00259_DS_:
;	.line	267; led.c	if(LCDPos < 32u)
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00267_DS_
	MOVLW	0x20
	SUBWF	r0x01, W
_00267_DS_:
	BC	_00255_DS_
;	.line	268; led.c	LCDText[LCDPos] = 0;
	CLRF	r0x01
	MOVLW	LOW(_LCDText)
	ADDWF	r0x00, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
_00255_DS_:
;	.line	269; led.c	LCDUpdate();
	CALL	_LCDUpdate
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_led__DisplayString	code
_DisplayString:
;	.line	237; led.c	void DisplayString(BYTE pos, char* text)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	239; led.c	BYTE l= strlen(text)+1;
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_strlen
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x03
	ADDWF	FSR1L, F
	INCF	r0x04, F
;	.line	240; led.c	BYTE max= 32-pos;
	MOVF	r0x00, W
	SUBLW	0x20
	MOVWF	r0x05
;	.line	241; led.c	strlcpy((char*)&LCDText[pos], text,(l<max)?l:max );
	CLRF	r0x06
	MOVLW	LOW(_LCDText)
	ADDWF	r0x00, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x06, F
	MOVF	r0x06, W
	MOVWF	r0x06
	MOVF	r0x00, W
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x07
	MOVF	r0x05, W
	SUBWF	r0x04, W
	BNC	_00247_DS_
	MOVFF	r0x05, r0x04
_00247_DS_:
	CLRF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_strlcpy
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	242; led.c	LCDUpdate();
	CALL	_LCDUpdate
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_led__DisplayEditTime	code
_DisplayEditTime:
;	.line	160; led.c	void DisplayEditTime(BYTE pos, long seconds)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVFF	r0x0a, POSTDEC1
	MOVFF	r0x0b, POSTDEC1
	MOVFF	r0x0c, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
;	.line	163; led.c	ts = editValues[2]%60;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	BANKSEL	(_editValues + 11)
	MOVF	(_editValues + 11), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_editValues + 10)
	MOVF	(_editValues + 10), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_editValues + 9)
	MOVF	(_editValues + 9), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_editValues + 8)
	MOVF	(_editValues + 8), W, B
	MOVWF	POSTDEC1
	CALL	__modslong
	MOVWF	r0x05
	MOVFF	PRODL, r0x06
	MOVFF	PRODH, r0x07
	MOVFF	FSR0L, r0x08
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	164; led.c	tm = editValues[1]%60;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	BANKSEL	(_editValues + 7)
	MOVF	(_editValues + 7), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_editValues + 6)
	MOVF	(_editValues + 6), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_editValues + 5)
	MOVF	(_editValues + 5), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_editValues + 4)
	MOVF	(_editValues + 4), W, B
	MOVWF	POSTDEC1
	CALL	__modslong
	MOVWF	r0x07
	MOVFF	PRODL, r0x08
	MOVFF	PRODH, r0x09
	MOVFF	FSR0L, r0x0a
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	165; led.c	th = editValues[0]%24;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x18
	MOVWF	POSTDEC1
	BANKSEL	(_editValues + 3)
	MOVF	(_editValues + 3), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_editValues + 2)
	MOVF	(_editValues + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_editValues + 1)
	MOVF	(_editValues + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_editValues
	MOVF	_editValues, W, B
	MOVWF	POSTDEC1
	CALL	__modslong
	MOVWF	r0x09
	MOVFF	PRODL, r0x0a
	MOVFF	PRODH, r0x0b
	MOVFF	FSR0L, r0x0c
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	166; led.c	DisplayTimeNumber(pos+0,th);
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_DisplayTimeNumber
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	167; led.c	LCDText[pos+2]=':';
	MOVLW	0x02
	ADDWF	r0x00, W
	MOVWF	r0x09
	CLRF	r0x0a
	MOVLW	LOW(_LCDText)
	ADDWF	r0x09, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x0a, F
	MOVFF	r0x09, FSR0L
	MOVFF	r0x0a, FSR0H
	MOVLW	0x3a
	MOVWF	INDF0
;	.line	168; led.c	DisplayTimeNumber(pos+3,tm);
	MOVLW	0x03
	ADDWF	r0x00, W
	MOVWF	r0x09
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	CALL	_DisplayTimeNumber
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	169; led.c	LCDText[pos+5]=':';
	MOVLW	0x05
	ADDWF	r0x00, W
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	LOW(_LCDText)
	ADDWF	r0x07, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVLW	0x3a
	MOVWF	INDF0
;	.line	170; led.c	DisplayTimeNumber(pos+6,ts);
	MOVLW	0x06
	ADDWF	r0x00, W
	MOVWF	r0x07
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	CALL	_DisplayTimeNumber
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	171; led.c	if(seconds % 2 == 0)
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__modslong
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVFF	PRODH, r0x03
	MOVFF	FSR0L, r0x04
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	IORWF	r0x02, W
	IORWF	r0x03, W
	IORWF	r0x04, W
	BNZ	_00195_DS_
	BANKSEL	_position
;	.line	173; led.c	LCDText[pos+position*3]=' ';
	MOVF	_position, W, B
	MOVWF	r0x01
; ;multiply lit val:0x03 by variable r0x01 and store in r0x01
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	MOVF	r0x01, W
	MULLW	0x03
	MOVFF	PRODL, r0x01
	MOVF	r0x01, W
	ADDWF	r0x00, F
	MOVLW	LOW(_LCDText)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	BTFSC	r0x00, 7
	SETF	r0x02
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x20
	MOVWF	INDF0
;	.line	174; led.c	LCDText[pos+position*3+1]=' ';
	INCF	r0x00, F
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_LCDText)
	ADDWF	r0x00, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x20
	MOVWF	INDF0
_00195_DS_:
;	.line	176; led.c	LCDUpdate();
	CALL	_LCDUpdate
	MOVFF	PREINC1, r0x0c
	MOVFF	PREINC1, r0x0b
	MOVFF	PREINC1, r0x0a
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_led__DisplayTime	code
_DisplayTime:
;	.line	146; led.c	void DisplayTime(BYTE pos, long seconds)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVFF	r0x0a, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
;	.line	149; led.c	ts = seconds%60;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__modslong
	MOVWF	r0x05
	MOVFF	PRODL, r0x06
	MOVFF	PRODH, r0x07
	MOVFF	FSR0L, r0x08
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	150; led.c	tm = (seconds/60)%60;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__divslong
	MOVWF	r0x07
	MOVFF	PRODL, r0x08
	MOVFF	PRODH, r0x09
	MOVFF	FSR0L, r0x0a
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	CALL	__modslong
	MOVWF	r0x07
	MOVFF	PRODL, r0x08
	MOVFF	PRODH, r0x09
	MOVFF	FSR0L, r0x0a
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	151; led.c	th = (seconds/60/60)%24;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0e
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__divslong
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVFF	PRODH, r0x03
	MOVFF	FSR0L, r0x04
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x18
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__modslong
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVFF	PRODH, r0x03
	MOVFF	FSR0L, r0x04
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	152; led.c	DisplayTimeNumber(pos+0,th);
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_DisplayTimeNumber
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	153; led.c	LCDText[pos+2]=':';
	MOVLW	0x02
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	LOW(_LCDText)
	ADDWF	r0x01, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x3a
	MOVWF	INDF0
;	.line	154; led.c	DisplayTimeNumber(pos+3,tm);
	MOVLW	0x03
	ADDWF	r0x00, W
	MOVWF	r0x01
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_DisplayTimeNumber
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	155; led.c	LCDText[pos+5]=':';
	MOVLW	0x05
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	LOW(_LCDText)
	ADDWF	r0x01, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x3a
	MOVWF	INDF0
;	.line	156; led.c	DisplayTimeNumber(pos+6,ts);
	MOVLW	0x06
	ADDWF	r0x00, F
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_DisplayTimeNumber
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	157; led.c	LCDUpdate();
	CALL	_LCDUpdate
	MOVFF	PREINC1, r0x0a
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_led__DisplayTimeNumber	code
_DisplayTimeNumber:
;	.line	130; led.c	void DisplayTimeNumber(BYTE pos, int val)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	135; led.c	ultoa(val, WDigit, radix);
	CLRF	WREG
	BTFSC	r0x02, 7
	MOVLW	0xff
	MOVWF	r0x03
	MOVWF	r0x04
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVLW	HIGH(_DisplayTimeNumber_WDigit_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_DisplayTimeNumber_WDigit_1_1)
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_ultoa
	MOVLW	0x07
	ADDWF	FSR1L, F
;	.line	136; led.c	if(WDigit[1] == '\0') //always display two digits
	MOVFF	(_DisplayTimeNumber_WDigit_1_1 + 1), r0x01
	MOVF	r0x01, W
	BNZ	_00182_DS_
;	.line	138; led.c	WDigit[2] = WDigit[1];
	MOVF	r0x01, W
	BANKSEL	(_DisplayTimeNumber_WDigit_1_1 + 2)
	MOVWF	(_DisplayTimeNumber_WDigit_1_1 + 2), B
;	.line	139; led.c	WDigit[1] = WDigit[0];
	MOVFF	_DisplayTimeNumber_WDigit_1_1, r0x01
	MOVF	r0x01, W
	BANKSEL	(_DisplayTimeNumber_WDigit_1_1 + 1)
	MOVWF	(_DisplayTimeNumber_WDigit_1_1 + 1), B
;	.line	140; led.c	WDigit[0] = '0';
	MOVLW	0x30
	BANKSEL	_DisplayTimeNumber_WDigit_1_1
	MOVWF	_DisplayTimeNumber_WDigit_1_1, B
_00182_DS_:
;	.line	142; led.c	for(j = 0; j < 2; j++)
	CLRF	r0x01
_00174_DS_:
	MOVLW	0x02
	SUBWF	r0x01, W
	BC	_00178_DS_
;	.line	143; led.c	LCDText[(pos+j)%32] = WDigit[j];
	MOVFF	r0x00, r0x02
	CLRF	r0x03
	MOVFF	r0x01, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVF	r0x05, W
	ADDWFC	r0x03, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_LCDText)
	ADDWF	r0x02, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x03, F
	MOVLW	LOW(_DisplayTimeNumber_WDigit_1_1)
	ADDWF	r0x01, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_DisplayTimeNumber_WDigit_1_1)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	INDF0, r0x04
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	r0x04, INDF0
;	.line	142; led.c	for(j = 0; j < 2; j++)
	INCF	r0x01, F
	BRA	_00174_DS_
_00178_DS_:
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_led__init_board	code
_init_board:
;	.line	107; led.c	void init_board(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	109; led.c	TRISJbits.TRISJ0    = 0;   // configure PORTJ0 for output (LED)
	BCF	_TRISJbits, 0
;	.line	110; led.c	TRISJbits.TRISJ1    = 0;   // configure PORTJ1 for output (LED)
	BCF	_TRISJbits, 1
;	.line	111; led.c	TRISJbits.TRISJ2    = 0;   // configure PORTJ1 for output (LED)
	BCF	_TRISJbits, 2
;	.line	113; led.c	RCONbits.IPEN       = 1;
	BSF	_RCONbits, 7
;	.line	114; led.c	INTCONbits.TMR0IE   = 1;   //activate interruptions
	BSF	_INTCONbits, 5
;	.line	115; led.c	INTCONbits.GIE      = 1;   //activate High Priority
	BSF	_INTCONbits, 7
;	.line	116; led.c	INTCONbits.PEIE     = 1;   //activate Low Priority
	BSF	_INTCONbits, 6
;	.line	118; led.c	INTCON2bits.TMR0IP  = 1;   //Timer 0 high priority
	BSF	_INTCON2bits, 2
;	.line	120; led.c	INTCON3bits.INT1E   = 1;   //INT1 activate
	BSF	_INTCON3bits, 3
;	.line	121; led.c	INTCON2bits.INTEDG1 = 0;   //INT1 interrupts on falling edge
	BCF	_INTCON2bits, 5
;	.line	122; led.c	INTCON3bits.INT1IP  = 0;   //INT1 low priority
	BCF	_INTCON3bits, 6
;	.line	124; led.c	INTCON3bits.INT3E   = 1;   //INT3 activate
	BSF	_INTCON3bits, 5
;	.line	125; led.c	INTCON2bits.INTEDG3 = 0;   //INT3 interrupts on falling edge
	BCF	_INTCON2bits, 3
;	.line	126; led.c	INTCON2bits.INT3IP  = 0;   //INT3 low priority
	BCF	_INTCON2bits, 1
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_led__activateTimer	code
_activateTimer:
;	.line	93; led.c	void activateTimer()
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	95; led.c	T0CONbits.T08BIT=0; // use timer0 16-bit counter
	BCF	_T0CONbits, 6
;	.line	96; led.c	T0CONbits.T0CS=0; // use timer0 instruction cycle clock
	BCF	_T0CONbits, 5
;	.line	97; led.c	T0CONbits.PSA=1; // disable timer0 prescaler
	BSF	_T0CONbits, 3
;	.line	98; led.c	T0CONbits.T0PS0=0;
	BCF	_T0CONbits, 0
;	.line	99; led.c	T0CONbits.T0PS1=0;
	BCF	_T0CONbits, 1
;	.line	100; led.c	T0CONbits.T0PS2=0; //set prescaler at 1/64.
	BCF	_T0CONbits, 2
;	.line	101; led.c	TMR0H=0x00;
	CLRF	_TMR0H
;	.line	102; led.c	TMR0L=0x00;
	CLRF	_TMR0L
;	.line	103; led.c	INTCONbits.T0IF=0; // clear timer0 overflow bit
	BCF	_INTCONbits, 2
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_led__LowISR	code
_LowISR:
;	.line	78; led.c	void LowISR(void) interrupt 2
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	80; led.c	if(INTCON3bits.INT1IF)
	BTFSS	_INTCON3bits, 0
	BRA	_00154_DS_
;	.line	82; led.c	INTCON3bits.INT1IF = 0;
	BCF	_INTCON3bits, 0
;	.line	83; led.c	updateMode(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_updateMode
	MOVLW	0x02
	ADDWF	FSR1L, F
_00154_DS_:
;	.line	86; led.c	if(INTCON3bits.INT3IF)
	BTFSS	_INTCON3bits, 2
	BRA	_00157_DS_
;	.line	88; led.c	INTCON3bits.INT3IF = 0;
	BCF	_INTCON3bits, 2
;	.line	89; led.c	updateMode(2);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_updateMode
	MOVLW	0x02
	ADDWF	FSR1L, F
_00157_DS_:
	MOVFF	PREINC1, FSR2L
	MOVFF	PREINC1, PCLATU
	MOVFF	PREINC1, PCLATH
	MOVFF	PREINC1, FSR0H
	MOVFF	PREINC1, FSR0L
	MOVFF	PREINC1, PRODH
	MOVFF	PREINC1, PRODL
	MOVFF	PREINC1, BSR
	MOVFF	PREINC1, STATUS
	MOVFF	PREINC1, WREG
	RETFIE	

; ; Starting pCode block
S_led__updateMode	code
_updateMode:
;	.line	39; led.c	void updateMode(int button)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVFF	r0x0a, POSTDEC1
	MOVFF	r0x0b, POSTDEC1
	MOVFF	r0x0c, POSTDEC1
	MOVFF	r0x0d, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	BANKSEL	_mode
;	.line	44; led.c	if(mode == 0) //display
	MOVF	_mode, W, B
	BANKSEL	(_mode + 1)
	IORWF	(_mode + 1), W, B
	BTFSS	STATUS, 2
	BRA	_00129_DS_
;	.line	46; led.c	mode = button;
	MOVFF	r0x00, _mode
	MOVFF	r0x01, (_mode + 1)
	BANKSEL	_position
;	.line	47; led.c	position = 0;
	CLRF	_position, B
	BANKSEL	(_position + 1)
	CLRF	(_position + 1), B
	BANKSEL	(_globalcount + 3)
;	.line	48; led.c	seconds = clockoffset + globalcount/TIMER0_OVERFLOW_PER_SECOND;
	MOVF	(_globalcount + 3), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_globalcount + 2)
	MOVF	(_globalcount + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_globalcount + 1)
	MOVF	(_globalcount + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_globalcount
	MOVF	_globalcount, W, B
	MOVWF	POSTDEC1
	CALL	___slong2fs
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVFF	PRODH, r0x04
	MOVFF	FSR0L, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x42
	MOVWF	POSTDEC1
	MOVLW	0xbe
	MOVWF	POSTDEC1
	MOVLW	0xa3
	MOVWF	POSTDEC1
	MOVLW	0xd7
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	___fsdiv
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVFF	PRODH, r0x04
	MOVFF	FSR0L, r0x05
	MOVLW	0x08
	ADDWF	FSR1L, F
	BANKSEL	(_clockoffset + 3)
	MOVF	(_clockoffset + 3), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_clockoffset + 2)
	MOVF	(_clockoffset + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_clockoffset + 1)
	MOVF	(_clockoffset + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_clockoffset
	MOVF	_clockoffset, W, B
	MOVWF	POSTDEC1
	CALL	___slong2fs
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVFF	PRODH, r0x08
	MOVFF	FSR0L, r0x09
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	___fsadd
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVFF	PRODH, r0x04
	MOVFF	FSR0L, r0x05
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	___fs2slong
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVFF	PRODH, r0x04
	MOVFF	FSR0L, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	49; led.c	editValues[2] = seconds%60;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__modslong
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVFF	PRODH, r0x08
	MOVFF	FSR0L, r0x09
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	BANKSEL	(_editValues + 8)
	MOVWF	(_editValues + 8), B
	MOVF	r0x07, W
	BANKSEL	(_editValues + 9)
	MOVWF	(_editValues + 9), B
	MOVF	r0x08, W
	BANKSEL	(_editValues + 10)
	MOVWF	(_editValues + 10), B
	MOVF	r0x09, W
	BANKSEL	(_editValues + 11)
	MOVWF	(_editValues + 11), B
;	.line	50; led.c	editValues[1] = (seconds/60)%60;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__divslong
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVFF	PRODH, r0x08
	MOVFF	FSR0L, r0x09
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	__modslong
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVFF	PRODH, r0x08
	MOVFF	FSR0L, r0x09
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	BANKSEL	(_editValues + 4)
	MOVWF	(_editValues + 4), B
	MOVF	r0x07, W
	BANKSEL	(_editValues + 5)
	MOVWF	(_editValues + 5), B
	MOVF	r0x08, W
	BANKSEL	(_editValues + 6)
	MOVWF	(_editValues + 6), B
	MOVF	r0x09, W
	BANKSEL	(_editValues + 7)
	MOVWF	(_editValues + 7), B
;	.line	51; led.c	editValues[0] = (seconds/60/60)%24;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0e
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__divslong
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVFF	PRODH, r0x04
	MOVFF	FSR0L, r0x05
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x18
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__modslong
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVFF	PRODH, r0x04
	MOVFF	FSR0L, r0x05
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x02, W
	BANKSEL	_editValues
	MOVWF	_editValues, B
	MOVF	r0x03, W
	BANKSEL	(_editValues + 1)
	MOVWF	(_editValues + 1), B
	MOVF	r0x04, W
	BANKSEL	(_editValues + 2)
	MOVWF	(_editValues + 2), B
	MOVF	r0x05, W
	BANKSEL	(_editValues + 3)
	MOVWF	(_editValues + 3), B
	BRA	_00131_DS_
_00129_DS_:
	BANKSEL	_mode
;	.line	53; led.c	else if(mode == 3) //alarm is on
	MOVF	_mode, W, B
	XORLW	0x03
	BNZ	_00139_DS_
	BANKSEL	(_mode + 1)
	MOVF	(_mode + 1), W, B
	BZ	_00140_DS_
_00139_DS_:
	BRA	_00126_DS_
_00140_DS_:
	BANKSEL	_mode
;	.line	55; led.c	mode = 0;
	CLRF	_mode, B
	BANKSEL	(_mode + 1)
	CLRF	(_mode + 1), B
	BRA	_00131_DS_
_00126_DS_:
;	.line	58; led.c	else if(button == 1) //next position
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00141_DS_
	MOVF	r0x01, W
	BZ	_00142_DS_
_00141_DS_:
	BRA	_00123_DS_
_00142_DS_:
	BANKSEL	_position
;	.line	60; led.c	if(position == 2) //close edit
	MOVF	_position, W, B
	XORLW	0x02
	BNZ	_00143_DS_
	BANKSEL	(_position + 1)
	MOVF	(_position + 1), W, B
	BZ	_00144_DS_
_00143_DS_:
	BRA	_00118_DS_
_00144_DS_:
;	.line	62; led.c	s = ((editValues[0]%24)*60+(editValues[1]%60))*60+(editValues[0]%60);
	MOVFF	_editValues, r0x02
	MOVFF	(_editValues + 1), r0x03
	MOVFF	(_editValues + 2), r0x04
	MOVFF	(_editValues + 3), r0x05
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x18
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__modslong
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVFF	PRODH, r0x08
	MOVFF	FSR0L, r0x09
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	CALL	__mullong
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVFF	PRODH, r0x08
	MOVFF	FSR0L, r0x09
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	BANKSEL	(_editValues + 7)
	MOVF	(_editValues + 7), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_editValues + 6)
	MOVF	(_editValues + 6), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_editValues + 5)
	MOVF	(_editValues + 5), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_editValues + 4)
	MOVF	(_editValues + 4), W, B
	MOVWF	POSTDEC1
	CALL	__modslong
	MOVWF	r0x0a
	MOVFF	PRODL, r0x0b
	MOVFF	PRODH, r0x0c
	MOVFF	FSR0L, r0x0d
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x0a, W
	ADDWF	r0x06, F
	MOVF	r0x0b, W
	ADDWFC	r0x07, F
	MOVF	r0x0c, W
	ADDWFC	r0x08, F
	MOVF	r0x0d, W
	ADDWFC	r0x09, F
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	CALL	__mullong
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVFF	PRODH, r0x08
	MOVFF	FSR0L, r0x09
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__modslong
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVFF	PRODH, r0x04
	MOVFF	FSR0L, r0x05
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x02, F
	MOVF	r0x07, W
	ADDWFC	r0x03, F
	MOVF	r0x08, W
	ADDWFC	r0x04, F
	MOVF	r0x09, W
	ADDWFC	r0x05, F
	BANKSEL	_mode
;	.line	63; led.c	if(mode == 1) //clock set
	MOVF	_mode, W, B
	XORLW	0x01
	BNZ	_00145_DS_
	BANKSEL	(_mode + 1)
	MOVF	(_mode + 1), W, B
	BZ	_00146_DS_
_00145_DS_:
	BRA	_00115_DS_
_00146_DS_:
	BANKSEL	(_globalcount + 3)
;	.line	64; led.c	clockoffset = s - globalcount/TIMER0_OVERFLOW_PER_SECOND;
	MOVF	(_globalcount + 3), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_globalcount + 2)
	MOVF	(_globalcount + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_globalcount + 1)
	MOVF	(_globalcount + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_globalcount
	MOVF	_globalcount, W, B
	MOVWF	POSTDEC1
	CALL	___slong2fs
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVFF	PRODH, r0x08
	MOVFF	FSR0L, r0x09
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x42
	MOVWF	POSTDEC1
	MOVLW	0xbe
	MOVWF	POSTDEC1
	MOVLW	0xa3
	MOVWF	POSTDEC1
	MOVLW	0xd7
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	___fsdiv
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVFF	PRODH, r0x08
	MOVFF	FSR0L, r0x09
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	___slong2fs
	MOVWF	r0x0a
	MOVFF	PRODL, r0x0b
	MOVFF	PRODH, r0x0c
	MOVFF	FSR0L, r0x0d
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	CALL	___fssub
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVFF	PRODH, r0x08
	MOVFF	FSR0L, r0x09
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	___fs2slong
	BANKSEL	_clockoffset
	MOVWF	_clockoffset, B
	MOVFF	PRODL, (_clockoffset + 1)
	MOVFF	PRODH, (_clockoffset + 2)
	MOVFF	FSR0L, (_clockoffset + 3)
	MOVLW	0x04
	ADDWF	FSR1L, F
	BRA	_00116_DS_
_00115_DS_:
;	.line	66; led.c	alarmtime = s;
	MOVFF	r0x02, _alarmtime
	MOVFF	r0x03, (_alarmtime + 1)
	MOVFF	r0x04, (_alarmtime + 2)
	MOVFF	r0x05, (_alarmtime + 3)
_00116_DS_:
	BANKSEL	_mode
;	.line	67; led.c	mode = 0;
	CLRF	_mode, B
	BANKSEL	(_mode + 1)
	CLRF	(_mode + 1), B
	BRA	_00131_DS_
_00118_DS_:
	BANKSEL	_position
;	.line	70; led.c	position++;
	INCF	_position, F, B
	BNC	_10272_DS_
	BANKSEL	(_position + 1)
	INCF	(_position + 1), F, B
_10272_DS_:
	BRA	_00131_DS_
_00123_DS_:
;	.line	72; led.c	else if(button == 2) //next value
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00147_DS_
	MOVF	r0x01, W
	BZ	_00148_DS_
_00147_DS_:
	BRA	_00131_DS_
_00148_DS_:
	BANKSEL	(_position + 1)
;	.line	74; led.c	editValues[position]++;
	MOVF	(_position + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_position
	MOVF	_position, W, B
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_editValues)
	ADDWF	r0x00, F
	MOVLW	HIGH(_editValues)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	POSTINC0, r0x02
	MOVFF	POSTINC0, r0x03
	MOVFF	POSTINC0, r0x04
	MOVFF	INDF0, r0x05
	INCF	r0x02, F
	BTFSC	STATUS, 0
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	r0x02, POSTINC0
	MOVFF	r0x03, POSTINC0
	MOVFF	r0x04, POSTINC0
	MOVFF	r0x05, INDF0
_00131_DS_:
	MOVFF	PREINC1, r0x0d
	MOVFF	PREINC1, r0x0c
	MOVFF	PREINC1, r0x0b
	MOVFF	PREINC1, r0x0a
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_led__HighISR	code
_HighISR:
;	.line	28; led.c	void HighISR(void) interrupt 1
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	30; led.c	if(INTCONbits.T0IF)
	BTFSS	_INTCONbits, 2
	BRA	_00109_DS_
;	.line	32; led.c	INTCONbits.T0IF=0; // clear timer0 overflow bit
	BCF	_INTCONbits, 2
	BANKSEL	_globalcount
;	.line	33; led.c	globalcount++;
	INCF	_globalcount, F, B
	BNC	_20273_DS_
	BANKSEL	(_globalcount + 1)
	INCF	(_globalcount + 1), F, B
_20273_DS_:
	BNC	_30274_DS_
	BANKSEL	(_globalcount + 2)
	INCF	(_globalcount + 2), F, B
_30274_DS_:
	BNC	_40275_DS_
	BANKSEL	(_globalcount + 3)
	INCF	(_globalcount + 3), F, B
_40275_DS_:
;	.line	34; led.c	if(globalcount % 95 == 0)
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x5f
	MOVWF	POSTDEC1
	BANKSEL	(_globalcount + 3)
	MOVF	(_globalcount + 3), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_globalcount + 2)
	MOVF	(_globalcount + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_globalcount + 1)
	MOVF	(_globalcount + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_globalcount
	MOVF	_globalcount, W, B
	MOVWF	POSTDEC1
	CALL	__modslong
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	IORWF	r0x01, W
	IORWF	r0x02, W
	IORWF	r0x03, W
	BNZ	_00109_DS_
;	.line	35; led.c	LATJbits.LATJ0^=1;
	CLRF	r0x00
	BTFSC	_LATJbits, 0
	INCF	r0x00, F
	MOVLW	0x01
	XORWF	r0x00, F
	MOVF	r0x00, W
	ANDLW	0x01
	MOVWF	PRODH
	MOVF	_LATJbits, W
	ANDLW	0xfe
	IORWF	PRODH, W
	MOVWF	_LATJbits
_00109_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	MOVFF	PREINC1, PCLATU
	MOVFF	PREINC1, PCLATH
	MOVFF	PREINC1, FSR0H
	MOVFF	PREINC1, FSR0L
	MOVFF	PREINC1, PRODH
	MOVFF	PREINC1, PRODL
	MOVFF	PREINC1, BSR
	MOVFF	PREINC1, STATUS
	MOVFF	PREINC1, WREG
	RETFIE	

; ; Starting pCode block
__str_0:
	DB	0x41, 0x4c, 0x41, 0x52, 0x4d, 0x45, 0x21, 0x20, 0x41, 0x4c, 0x41, 0x52
	DB	0x4d, 0x45, 0x21, 0x00
; ; Starting pCode block
__str_1:
	DB	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
__str_2:
	DB	0x44, 0x65, 0x66, 0x69, 0x6e, 0x69, 0x72, 0x20, 0x48, 0x65, 0x75, 0x72
	DB	0x65, 0x00
; ; Starting pCode block
__str_3:
	DB	0x44, 0x65, 0x66, 0x69, 0x6e, 0x69, 0x72, 0x20, 0x41, 0x6c, 0x61, 0x72
	DB	0x6d, 0x65, 0x00


; Statistics:
; code size:	 5204 (0x1454) bytes ( 3.97%)
;           	 2602 (0x0a2a) words
; udata size:	   37 (0x0025) bytes ( 0.96%)
; access size:	   22 (0x0016) bytes


	end
