#include <pic14/pic12f683.h>  // Biblioteca para SDCC y PIC12F683
#define _XTAL_FREQ 4000000   // Oscilador a 4 MHz

// Definir pines para LEDs
#define LED0 GP0
#define LED1 GP1
#define LED2 GP2
#define LED4 GP4

// Definir botón en GP5
#define BOTON GP5

void initPIC(void);

void main(void) {
    initPIC();  // Configuración inicial del PIC

    while (1) {
        if (BOTON == 0) {  // Botón presionado (activo bajo)
            GPIO = 0b00010111;  // Encender LEDs GP0, GP1, GP2 y GP4
        } else {
            GPIO = 0x00;  // Apagar todos los LEDs
        }
    }
}

// Configuración del PIC
void initPIC(void) {
    TRISIO = 0b00100000;  // GP5 como entrada, otros como salida
    ANSEL = 0x00;        // Desactivar entradas analógicas
    CMCON0 = 0x07;       // Desactivar comparador
    GPIO = 0x00;         // Apagar LEDs
}
