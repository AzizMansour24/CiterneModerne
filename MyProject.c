sbit LCD_RS at RD1_bit;
sbit LCD_EN at RD0_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISD1_bit;
sbit LCD_EN_Direction at TRISD0_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

unsigned int nbj = 0;
unsigned int nbn = 0;
unsigned int pot;
unsigned int NB;
unsigned int v;
unsigned int NB1 = 0;
char pot1[7];
unsigned char i;
unsigned char x = 0;
unsigned char a;
float pourcentage;


void main() {
    ADC_Init();
    Lcd_Init();
    TRISA = 0xFF;
    TRISB = 0xFF;
    TRISC = 0x00;
    TRISE = 0x00;
    PORTC = 0x00;
    PORTE = 0x00;
    Lcd_Cmd(_LCD_CURSOR_OFF);
    nbj=0;
    nbn=0;

    while (1) {
        if (RB0_bit) {
        if (nbj > 2) {
            Lcd_Out(1, 1, "Gaspillage");
            PORTC.RC7 = 1;
            delay_ms(200);
            PORTC.RC7 = 0;
            }
            else{
        Lcd_Out(1, 1, "Mode Jour");
            }
            Lcd_Out(2, 3, "Eau= ");
            pot = ADC_Read(1);
            pourcentage = ((float) pot / 1023.0) * 100.0;
            IntToStr(pourcentage, pot1);
            Lcd_Out(2, 8, pot1);

            if (RB7_bit == 0) {
                nbj = 0;
            }
            if (PORTB.RB4 == 1 ) {
                PORTC.RC0 = 0;
                PORTE.RE0 = 0;
                PORTE.RE1 = 0;
                PORTC.RC7 = 0;
                nbj++;
                pot = ADC_Read(1);
                pourcentage = ((float) pot / 1023.0) * 100.0;
                IntToStr(pourcentage, pot1);
                Lcd_Out(2, 8, pot1);

                if (pourcentage < 75) {
                    PORTC.RC2 = 0;
                    PORTE.RE2 = 0;
                } else if (pourcentage >= 75) {
                    PORTC.RC2 = 1;
                    for (i = 0; i < 5; i++) {
                        PORTE.RE2 = 1;
                        delay_ms(50);
                        PORTE.RE2 = 0;
                        delay_ms(50);
                    }
                    delay_ms(1000);
                    PORTC.RC2 = 0;
                }
            }
            else if (PORTB.RB5 == 1 && PORTB.RB1 == 1 && PORTB.RB0 == 1) {
                PORTC.RC0 = 1;
                PORTE.RE0 = 1;
            }
            else if (PORTB.RB5 == 1 && PORTB.RB1 == 0 && PORTB.RB4 == 0 && PORTB.RB1 == 0) {
                PORTC.RC0 = 0;
                PORTC.RC7 = 1;
                delay_ms(200);
                PORTC.RC7 = 0;
                for (i = 0; i < 3; i++) {
                    PORTE.RE1 = 1;
                    delay_ms(50);
                    PORTE.RE1 = 0;
                    delay_ms(50);
                }
                NB = 0;
            }

        }

        if (RA4_bit == 1) {
           if (nbn > 4) {
            Lcd_Out(1, 1, "Gaspillage");
            }
            else{
           Lcd_Out(1, 1, "Mode Nuit");
            }
            Lcd_Out(2, 3, "Eau= ");
            pot = ADC_Read(1);
            pourcentage = ((float) pot / 1023.0) * 100.0;
            IntToStr(pourcentage, pot1);
            Lcd_Out(2, 8, pot1);
            if (RB7_bit == 0) {
                nbn = 0;
            }
            if (PORTB.RB6 == 1 && PORTB.RB4 == 0) {
                PORTC.RC0 = 1;
                PORTE.RE0 = 1;
            }
            if (PORTB.RB4 == 1 && PORTB.RB6 == 0) {
                nbn++;
                if (nbn > 5) {
                    PORTC.RC7 = 1;
                    delay_ms(200);
                    PORTC.RC7 = 0;
                }
                PORTC.RC0 = 0;
                PORTE.RE0 = 0;
                pot = ADC_Read(1);
                pourcentage = ((float) pot / 1023.0) * 100.0;
                IntToStr(pourcentage, pot1);
                Lcd_Out(2, 8, pot1);

                if (pourcentage < 75) {
                    PORTC.RC2 = 0;
                    PORTE.RE2 = 0;
                }
                if (pourcentage >= 75) {
                    PORTC.RC2 = 1;
                    for (i = 0; i < 5; i++) {
                        PORTE.RE2 = 1;
                        delay_ms(50);
                        PORTE.RE2 = 0;
                        delay_ms(50);
                    }
                    delay_ms(1000);
                    PORTC.RC2 = 0;
                }
            }
        }


        if (RB0_bit == 0 && PORTA.RA4 == 0) {
            Lcd_Out(1, 1, "Bienvenue");
            Lcd_Out(2, 3, "Eau= ");
            pot = ADC_Read(1);
            pourcentage = ((float) pot / 1023.0) * 100.0;
            IntToStr(pourcentage, pot1);
            Lcd_Out(2, 8, pot1);
        }
    }
}