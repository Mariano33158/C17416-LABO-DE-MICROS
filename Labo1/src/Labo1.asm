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
	extern	__moduint
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
	global	_mostrarDado
	global	_delay_ms

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
UDL_dado_0	udata
r0x1007	res	1
r0x1008	res	1
r0x1009	res	1
r0x100A	res	1
r0x100C	res	1
r0x100D	res	1
r0x1006	res	1
r0x1001	res	1
r0x1000	res	1
r0x1002	res	1
r0x1003	res	1
r0x1004	res	1
r0x1005	res	1
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
;   _delay_ms
;   __moduint
;   _mostrarDado
;   _initPIC
;   _delay_ms
;   __moduint
;   _mostrarDado
;10 compiler assigned registers:
;   r0x1007
;   r0x1008
;   r0x1009
;   STK00
;   r0x100A
;   STK02
;   STK01
;   r0x100B
;   r0x100C
;   r0x100D
;; Starting pCode block
S_dado__main	code
_main:
; 2 exit points
;	.line	18; "dado.c"	initPIC();  // Configuración inicial del PIC
	PAGESEL	_initPIC
	CALL	_initPIC
	PAGESEL	$
;	.line	20; "dado.c"	unsigned char botonAnterior = 0;  // Para detectar flanco ascendente
	BANKSEL	r0x1007
	CLRF	r0x1007
;	.line	23; "dado.c"	while (1) {
	CLRF	r0x1008
	CLRF	r0x1009
_00109_DS_:
;	.line	24; "dado.c"	contador++;  // Incrementar contador continuamente
	BANKSEL	r0x1008
	INCF	r0x1008,F
	BTFSC	STATUS,2
	INCF	r0x1009,F
;	.line	25; "dado.c"	delay_ms(1);  // Retardo manual de 1 ms
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
;	.line	27; "dado.c"	unsigned char botonActual = BOTON;  // Leer estado actual del botón
	BANKSEL	r0x100A
	CLRF	r0x100A
	BANKSEL	_GPIObits
	BTFSS	_GPIObits,5
	GOTO	_00002_DS_
	BANKSEL	r0x100A
	INCF	r0x100A,F
_00002_DS_:
;	.line	30; "dado.c"	if (botonActual == 1 && botonAnterior == 0) { 
	BANKSEL	r0x100A
	MOVF	r0x100A,W
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00106_DS_
	MOVF	r0x1007,W
	BTFSS	STATUS,2
	GOTO	_00106_DS_
;	.line	32; "dado.c"	dado = (contador % 6) + 1;
	MOVLW	0x06
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x1008,W
	MOVWF	STK00
	MOVF	r0x1009,W
	PAGESEL	__moduint
	CALL	__moduint
	PAGESEL	$
;;1	MOVWF	r0x100B
	MOVF	STK00,W
	BANKSEL	r0x100C
	MOVWF	r0x100C
	MOVWF	r0x100D
	MOVWF	r0x100C
	INCF	r0x100C,W
;	.line	33; "dado.c"	mostrarDado(dado);  // Actualizar LEDs
	MOVWF	r0x100D
	PAGESEL	_mostrarDado
	CALL	_mostrarDado
	PAGESEL	$
_00106_DS_:
;	.line	36; "dado.c"	botonAnterior = botonActual;  // Guardar estado actual
	BANKSEL	r0x100A
	MOVF	r0x100A,W
	MOVWF	r0x1007
	GOTO	_00109_DS_
;	.line	38; "dado.c"	}
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;7 compiler assigned registers:
;   r0x1000
;   STK00
;   r0x1001
;   r0x1002
;   r0x1003
;   r0x1004
;   r0x1005
;; Starting pCode block
S_dado__delay_ms	code
_delay_ms:
; 2 exit points
;	.line	81; "dado.c"	void delay_ms(unsigned int tiempo) {
	BANKSEL	r0x1000
	MOVWF	r0x1000
	MOVF	STK00,W
	MOVWF	r0x1001
;	.line	83; "dado.c"	for (i = 0; i < tiempo; i++) {
	CLRF	r0x1002
	CLRF	r0x1003
_00152_DS_:
	BANKSEL	r0x1000
	MOVF	r0x1000,W
	SUBWF	r0x1003,W
	BTFSS	STATUS,2
	GOTO	_00182_DS_
	MOVF	r0x1001,W
	SUBWF	r0x1002,W
_00182_DS_:
	BTFSC	STATUS,0
	GOTO	_00154_DS_
;;genSkipc:3307: created from rifx:000000cf3d3d8e30
;	.line	84; "dado.c"	for (j = 0; j < 1000; j++) {
	MOVLW	0xe8
	BANKSEL	r0x1004
	MOVWF	r0x1004
	MOVLW	0x03
	MOVWF	r0x1005
_00150_DS_:
	nop	
	MOVLW	0xff
	BANKSEL	r0x1004
	ADDWF	r0x1004,F
	BTFSS	STATUS,0
	DECF	r0x1005,F
;	.line	84; "dado.c"	for (j = 0; j < 1000; j++) {
	MOVF	r0x1005,W
	IORWF	r0x1004,W
	BTFSS	STATUS,2
	GOTO	_00150_DS_
;	.line	83; "dado.c"	for (i = 0; i < tiempo; i++) {
	INCF	r0x1002,F
	BTFSC	STATUS,2
	INCF	r0x1003,F
	GOTO	_00152_DS_
_00154_DS_:
;	.line	89; "dado.c"	}
	RETURN	
; exit point of _delay_ms

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;1 compiler assigned register :
;   r0x1006
;; Starting pCode block
S_dado__mostrarDado	code
_mostrarDado:
; 2 exit points
;	.line	49; "dado.c"	void mostrarDado(unsigned char numero) {
	BANKSEL	r0x1006
	MOVWF	r0x1006
;	.line	50; "dado.c"	GPIO = 0x00;  // Apagar LEDs antes de configurar
	BANKSEL	_GPIO
	CLRF	_GPIO
;;unsigned compare: left < lit(0x1=1), size=1
;	.line	52; "dado.c"	switch (numero) {
	MOVLW	0x01
	BANKSEL	r0x1006
	SUBWF	r0x1006,W
	BTFSS	STATUS,0
	GOTO	_00125_DS_
;;genSkipc:3307: created from rifx:000000cf3d3d8e30
;;swapping arguments (AOP_TYPEs 1/2)
;;unsigned compare: left >= lit(0x7=7), size=1
	MOVLW	0x07
	SUBWF	r0x1006,W
	BTFSC	STATUS,0
	GOTO	_00125_DS_
;;genSkipc:3307: created from rifx:000000cf3d3d8e30
	DECF	r0x1006,F
	MOVLW	HIGH(_00141_DS_)
	BANKSEL	PCLATH
	MOVWF	PCLATH
	MOVLW	_00141_DS_
	BANKSEL	r0x1006
	ADDWF	r0x1006,W
	BTFSS	STATUS,0
	GOTO	_00001_DS_
	BANKSEL	PCLATH
	INCF	PCLATH,F
_00001_DS_:
	MOVWF	PCL
_00141_DS_:
	GOTO	_00118_DS_
	GOTO	_00119_DS_
	GOTO	_00120_DS_
	GOTO	_00121_DS_
	GOTO	_00122_DS_
	GOTO	_00123_DS_
_00118_DS_:
;	.line	54; "dado.c"	LED1 = 1;  // Número 1: GP1 encendido
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
;	.line	55; "dado.c"	break;
	GOTO	_00125_DS_
_00119_DS_:
;	.line	57; "dado.c"	LED0 = 1;  // Número 2: GP0 encendido
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	58; "dado.c"	break;
	GOTO	_00125_DS_
_00120_DS_:
;	.line	60; "dado.c"	LED0 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	61; "dado.c"	LED1 = 1;  // Número 3: GP0 y GP1 encendidos
	BSF	_GPIObits,1
;	.line	62; "dado.c"	break;
	GOTO	_00125_DS_
_00121_DS_:
;	.line	64; "dado.c"	LED0 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	65; "dado.c"	LED2 = 1;  // Número 4: GP0 y GP2 encendidos
	BSF	_GPIObits,2
;	.line	66; "dado.c"	break;
	GOTO	_00125_DS_
_00122_DS_:
;	.line	68; "dado.c"	LED0 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	69; "dado.c"	LED1 = 1;
	BSF	_GPIObits,1
;	.line	70; "dado.c"	LED2 = 1;  // Número 5: GP0, GP1 y GP2 encendidos
	BSF	_GPIObits,2
;	.line	71; "dado.c"	break;
	GOTO	_00125_DS_
_00123_DS_:
;	.line	73; "dado.c"	LED0 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	74; "dado.c"	LED2 = 1;
	BSF	_GPIObits,2
;	.line	75; "dado.c"	LED4 = 1;  // Número 6: GP0, GP2 y GP4 encendidos
	BSF	_GPIObits,4
_00125_DS_:
;	.line	78; "dado.c"	}
	RETURN	
; exit point of _mostrarDado

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;; Starting pCode block
S_dado__initPIC	code
_initPIC:
; 2 exit points
;	.line	42; "dado.c"	TRISIO = 0b00100000;  // GP5 como entrada, otros como salida
	MOVLW	0x20
	BANKSEL	_TRISIO
	MOVWF	_TRISIO
;	.line	43; "dado.c"	ANSEL = 0x00;        // Desactivar entradas analógicas
	CLRF	_ANSEL
;	.line	44; "dado.c"	CMCON0 = 0x07;       // Desactivar comparador
	MOVLW	0x07
	BANKSEL	_CMCON0
	MOVWF	_CMCON0
;	.line	45; "dado.c"	GPIO = 0x00;         // Apagar LEDs inicialmente
	CLRF	_GPIO
;	.line	46; "dado.c"	}
	RETURN	
; exit point of _initPIC


;	code size estimation:
;	  121+   34 =   155 instructions (  378 byte)

	end
