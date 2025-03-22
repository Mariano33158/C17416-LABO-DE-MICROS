;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.2 #15341 (MINGW64)
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"dado.c"
	list	p=12f683
	radix dec
	include "p12f683.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	_ANSEL
	extern	_TRISIO
	extern	_CMCON0
	extern	_GPIO
	extern	_GPIObits
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_main
	global	_initPIC

	global PSAVE
	global SSAVE
	global WSAVE
	global STK12
	global STK11
	global STK10
	global STK09
	global STK08
	global STK07
	global STK06
	global STK05
	global STK04
	global STK03
	global STK02
	global STK01
	global STK00

sharebank udata_ovr 0x0070
PSAVE	res 1
SSAVE	res 1
WSAVE	res 1
STK12	res 1
STK11	res 1
STK10	res 1
STK09	res 1
STK08	res 1
STK07	res 1
STK06	res 1
STK05	res 1
STK04	res 1
STK03	res 1
STK02	res 1
STK01	res 1
STK00	res 1

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------
;--------------------------------------------------------
; initialized absolute data
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; reset vector 
;--------------------------------------------------------
STARTUP	code 0x0000
	nop
	pagesel __sdcc_gsinit_startup
	goto	__sdcc_gsinit_startup
;--------------------------------------------------------
; code
;--------------------------------------------------------
code_dado	code
;***
;  pBlock Stats: dbName = M
;***
;has an exit
;functions called:
;   _initPIC
;   _initPIC
;; Starting pCode block
S_dado__main	code
_main:
; 2 exit points
;	.line	16; "dado.c"	initPIC();  // Configuración inicial del PIC
	PAGESEL	_initPIC
	CALL	_initPIC
	PAGESEL	$
_00109_DS_:
;	.line	19; "dado.c"	if (BOTON == 0) {  // Botón presionado (activo bajo)
	BANKSEL	_GPIObits
	BTFSC	_GPIObits,5
	GOTO	_00106_DS_
;	.line	20; "dado.c"	GPIO = 0b00010111;  // Encender LEDs GP0, GP1, GP2 y GP4
	MOVLW	0x17
	MOVWF	_GPIO
	GOTO	_00109_DS_
_00106_DS_:
;	.line	22; "dado.c"	GPIO = 0x00;  // Apagar todos los LEDs
	BANKSEL	_GPIO
	CLRF	_GPIO
	GOTO	_00109_DS_
;	.line	25; "dado.c"	}
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;; Starting pCode block
S_dado__initPIC	code
_initPIC:
; 2 exit points
;	.line	29; "dado.c"	TRISIO = 0b00100000;  // GP5 como entrada, otros como salida
	MOVLW	0x20
	BANKSEL	_TRISIO
	MOVWF	_TRISIO
;	.line	30; "dado.c"	ANSEL = 0x00;        // Desactivar entradas analógicas
	CLRF	_ANSEL
;	.line	31; "dado.c"	CMCON0 = 0x07;       // Desactivar comparador
	MOVLW	0x07
	BANKSEL	_CMCON0
	MOVWF	_CMCON0
;	.line	32; "dado.c"	GPIO = 0x00;         // Apagar LEDs
	CLRF	_GPIO
;	.line	33; "dado.c"	}
	RETURN	
; exit point of _initPIC


;	code size estimation:
;	   16+    6 =    22 instructions (   56 byte)

	end
