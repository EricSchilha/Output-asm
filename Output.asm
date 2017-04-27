;OUTPUT			v3.1	April 22nd, 2017
;===============================================================================
;Description:	Output test program. Initializes the PIC16F886 I/O pins for LED
;				output on the CHRP 3.0, and demonstrates port output.

;Configure MPLAB and the microcongtroller

	include	"p18f25k50.inc"		;Include processor definitions

	config	PLLSEL = PLL3X, CFGPLLEN = ON, CPUDIV = CLKDIV3, LS48MHZ = SYS48X8, FOSC = INTOSCIO, PCLKEN = ON, FCMEN = OFF, IESO = OFF
	config	nPWRTEN = OFF, BOREN = SBORDIS, BORV = 190, nLPBOR = OFF, WDTEN = SWON, WDTPS = 32768
	config	CCP2MX = RC1, PBADEN = OFF, T3CMX = RC0, SDOMX = RC7, MCLRE = ON, STVREN = ON, LVP = ON, XINST = OFF
	config	CP0 = OFF, CP1 = OFF, CP2 = OFF, CP3 = OFF, CPB = OFF, CPD = OFF
	config	WRT0 = OFF, WRT1 = OFF, WRT2 = OFF, WRT3 = OFF, WRTC = OFF, WRTB = OFF, WRTD = OFF
	config	EBTR0 = OFF, EBTR1 = OFF, EBTR2 = OFF, EBTR3 = OFF, EBTRB = OFF

;Start the program at the reset vector

				org	00h		;Reset vector - start of program memory
				goto	initPorts	;Jump to initialize routine
				org	10h		;Continue program after the interrupt vector

initPorts						;Configures PORTA and PORTB for digital I/O
				banksel	ANSELA		;Switch register banks
				clrf	ANSELA		;Set all PORTA pins to digital
				clrf	ANSELB		;Set all PORTB pins to digital
				movlw	01010111b	;Enable Port B pull-ups, TMR0 internal
				;movwf	OPTION_REG	;clock, and 256 prescaler
				banksel	TRISA		;Switch register banks
				movlw	00101111b	;Set piezo and LED pins as outputs and
				movwf	TRISA		;all other PORTA pins as inputs
				clrf	TRISB		;Set all PORTB pins as outputs for LEDs
				banksel	PORTA		;Return to register bank 0
				clrf	PORTA		;Clear all PORTA outputs and turn on Run LED

main				movlw	11000011b	;Send this pattern to the
				movwf	PORTB		;Port B LEDs
				sleep			;Done - shut down microcontroller core

				end