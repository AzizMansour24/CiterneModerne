#include <stdlib.h>
#include <string.h>
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

unsigned int pot; //valeur logique
char pot1[6];     //message a afficher
float pourcentage;  //valeur analogique

unsigned char i;
unsigned char a;
unsigned int nbj=0,nbn=0;

void interrupt(void){
//MODE JOUR********************************************************************************************************
if(INTCON.INTF&&PORTB.RB0==1){
INTCON.RBIE=1;
EEPROM_WRITE(0xFF,nbj);
if(EEPROM_READ(0xFF)>=2){
          for(i=0;i<3;i++){
          PORTC.RC7=1;delay_ms(100);PORTC.RC7=0;
          }
          //Lcd_Out(2, 3, "Alerte Gaspillage");
}
//interruption PORTB
if(INTCON.RBIF==1){
//boutton raz
if(PORTB.RB7==0){
nbj=0;
EEPROM_WRITE(0xFF,nbj);
}
 //bouton valider
 if(PORTB.RB5==1&&PORTB.RB1==1&&PORTA.RA4==0){ PORTC.RC0=1;PORTE.RE0=1; }
 //niveau b
 else if(PORTB.RB5==1&&PORTB.RB4==0){
                  PORTC.RC0=0;PORTC.RC7=1;delay_ms(100);PORTC.RC7=0;
                  for(i=0;i<3;i++){PORTE.RE1=1;delay_ms(50);PORTE.RE1=0;delay_ms(50);}
                  delay_ms(200);

 }
 //niveau a
 if(PORTB.RB4==1)
        {PORTC.RC0=0;PORTE.RE0=0;PORTE.RE1=0;PORTC.RC7=0;

         //***************qualite eauu******************
             if (pourcentage<75)
            {
            //Lcd_Out(2, 3, "Eau Propre");
            }
            else if (pourcentage>=75)
            {PORTC.RC2=1;
            for(i=0;i<5;i++){PORTE.RE2=1;delay_ms(50);PORTE.RE2=0;delay_ms(50);}
            delay_ms(1000);
            PORTC.RC2=0;
            nbj++;                    //incrementation
            EEPROM_WRITE(0xFF,nbj);   //ecriture eeprom
            INTCON.RBIF=0;
        }
         //***************qualite eauu******************
}
}
 if(PORTB.RB0==0){ INTCON.INTF=0;}
 //if(INTCON.INTF==0){PORTC.RC0=0;PORTE.RE0=0;INTCON.INTF=0;PORTE.RE1=0;PORTC.RC7=0;INTCON.INTF=0;}

}
//MODE NUIT**************************************************************************************************
if(INTCON.TMR0IF && PORTA.RA4 == 1) { //timer0
          INTCON.RBIE=1;
          EEPROM_WRITE(0xFE,nbn);
          if(EEPROM_READ(0xFE)>=2){
          for(i=0;i<3;i++){
          PORTC.RC7=1;delay_ms(100);PORTC.RC7=0;
          }
          //Lcd_Out(2, 3, "Alerte Gaspillage");
          }
          if(INTCON.RBIF==1){
          if(PORTB.RB7==0){
                           nbn=0;
                           EEPROM_WRITE(0xFE,nbn);
          }

        //niveau c
        if(PORTB.RB6 == 1) {
            PORTC.RC0 = 1;
            PORTE.RE0 = 1;
        }
        //niveau a
        if(PORTB.RB4 == 1) {
            PORTC.RC0 = 0;
            PORTE.RE0 = 0;
            //qualite de l eau
             if (pourcentage<75)
            { //Lcd_Out(2, 3, "Eau Propre");
            }
            else if (pourcentage>=75){
            PORTC.RC2=1;
            for(i=0;i<5;i++){PORTE.RE2=1;delay_ms(50);PORTE.RE2=0;delay_ms(50);}
            delay_ms(1000);
            PORTC.RC2=0;
            }
            nbn++;                    //incrementation
            EEPROM_WRITE(0xFE,nbn);   //ecriture eeprom
            INTCON.RBIF==0;
        }
        }
        INTCON.TMR0IF = 0; // Clear TMR0 interrupt flag
}

}








void main() {
     I2C1_Init(100000);
     EECON1=0b00000111;
    ADC_Init();
    Lcd_Init();
    TRISA=0XFF;
    TRISB=0XFF;
    TRISC=0X00;
    TRISE=0X00;
    INTCON.GIE=1;
    INTCON.INTE=1;
    OPTION_REG.Intedg=1;
    //INTCON.T0IE=1;
    //TMR0=0;



    PORTC=0X00;
    PORTE=0X00;
    a=0;

    //init timer0
    OPTION_REG.T0CS = 0; // TMR0 clock source: internal instruction cycle clock (Fosc/4)
    OPTION_REG.T0SE = 0; // TMR0 source edge select: low-to-high
    OPTION_REG.PSA = 0; // Prescaler Assignment: Timer0 clock source comes from prescaler
    OPTION_REG.PS2 = 1; // Prescaler Rate Select bits (1:64)
    OPTION_REG.PS1 = 0;
    OPTION_REG.PS0 = 1;


    while(1) {
    //lecture de la qualite
    pot = ADC_Read(1);               //lire la convertion sur le bin RA1/AN1
    pourcentage = ((float)pot / 1023.0) * 100.0;          //convertion de la valeur en float
    IntToStr((int)pourcentage, pot1);                     //convertion de int en string

    /*if(PORTB.RB0==1){
    Lcd_Out(1, 1, "Mode Jour");
    }
    else if(PORTA.RA4==1){
    Lcd_Out(1, 1, "Mode Nuit");
    }else{*/
    Lcd_Cmd(_LCD_CURSOR_OFF);
    Lcd_Out(1, 1, "Bienvenue");
    Lcd_Out(2, 3, "Eau= ");
    Lcd_Out(2, 8, pot1);
    //}
    }
}