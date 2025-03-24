// Mariano Segura Chaves C17416
// Laboratorio 1

#include <pic14/pic12f683.h>  // Biblioteca para SDCC y PIC12F683
#define _XTAL_FREQ 4000000   // Oscilador a 4 MHz

// Definir pines para LEDs que encienden cada conjunto de leds
#define LED0 GP0
#define LED1 GP1
#define LED2 GP2
#define LED4 GP4

// Definir botón que acciona la tirada del dado en GP5
#define BOTON GP5

void initPIC(void);
void mostrarDado(unsigned char numero);
void delay_ms(unsigned int tiempo);  // Retardo manual

void main(void) {
    initPIC();  // Configuración inicial del PIC para que todo inicie en 0
    unsigned char dado = 0;
    unsigned char botonAnterior = 0;  // Para detectar flanco ascendente
    unsigned int contador = 0;      // Contador para número aleatorio

    while (1) {
        contador++;  // Incrementar contador continuamente
        delay_ms(1);  // Retardo manual de 1 ms

        unsigned char botonActual = BOTON;  // Leer estado actual del botón para saber si empezar o no

        // Detectar flanco ascendente
        if (botonActual == 1 && botonAnterior == 0) { 
            // Calcular número aleatorio entre 1 y 6
            dado = (contador % 6) + 1;
            mostrarDado(dado);  // Actualizar LEDs
        }

        botonAnterior = botonActual;  // Guardar estado actual
    }
}

// Configuración del PIC
void initPIC(void) {
    TRISIO = 0b00100000;  // GP5 como entrada, otros como salida
    ANSEL = 0x00;        // Desactivar entradas analógicas
    CMCON0 = 0x07;       // Desactivar comparador
    GPIO = 0x00;         // Apagar LEDs inicialmente
}

// Mostrar número del dado usando LEDs
void mostrarDado(unsigned char numero) {
    GPIO = 0x00;  // Apagar LEDs antes de configurar

    switch (numero) {
        case 1:
            LED1 = 1;  // Número 1: GP1 encendido
            break;
        case 2:
            LED0 = 1;  // Número 2: GP0 encendido
            break;
        case 3:
            LED0 = 1;
            LED1 = 1;  // Número 3: GP0 y GP1 encendidos
            break;
        case 4:
            LED0 = 1;
            LED2 = 1;  // Número 4: GP0 y GP2 encendidos
            break;
        case 5:
            LED0 = 1;
            LED1 = 1;
            LED2 = 1;  // Número 5: GP0, GP1 y GP2 encendidos
            break;
        case 6:
            LED0 = 1;
            LED2 = 1;
            LED4 = 1;  // Número 6: GP0, GP2 y GP4 encendidos
            break;
    }
}

// Retardo manual en milisegundos
void delay_ms(unsigned int tiempo) {
    unsigned int i, j;
    for (i = 0; i < tiempo; i++) {
        for (j = 0; j < 1000; j++) {
            // NOP para retardo ajustable
            __asm nop __endasm;
        }
    }
}
