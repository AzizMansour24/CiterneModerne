
_main:

;MyProject.c,28 :: 		void main() {
;MyProject.c,29 :: 		ADC_Init();
	CALL       _ADC_Init+0
;MyProject.c,30 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MyProject.c,31 :: 		TRISA = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;MyProject.c,32 :: 		TRISB = 0xFF;
	MOVLW      255
	MOVWF      TRISB+0
;MyProject.c,33 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;MyProject.c,34 :: 		TRISE = 0x00;
	CLRF       TRISE+0
;MyProject.c,35 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,36 :: 		PORTE = 0x00;
	CLRF       PORTE+0
;MyProject.c,37 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,38 :: 		nbj=0;
	CLRF       _nbj+0
	CLRF       _nbj+1
;MyProject.c,39 :: 		nbn=0;
	CLRF       _nbn+0
	CLRF       _nbn+1
;MyProject.c,41 :: 		while (1) {
L_main0:
;MyProject.c,42 :: 		if (RB0_bit) {
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_main2
;MyProject.c,43 :: 		if (nbj > 2) {
	MOVF       _nbj+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVF       _nbj+0, 0
	SUBLW      2
L__main60:
	BTFSC      STATUS+0, 0
	GOTO       L_main3
;MyProject.c,44 :: 		Lcd_Out(1, 1, "Gaspillage");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,45 :: 		PORTC.RC7 = 1;
	BSF        PORTC+0, 7
;MyProject.c,46 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
;MyProject.c,47 :: 		PORTC.RC7 = 0;
	BCF        PORTC+0, 7
;MyProject.c,48 :: 		}
	GOTO       L_main5
L_main3:
;MyProject.c,50 :: 		Lcd_Out(1, 1, "Mode Jour");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,51 :: 		}
L_main5:
;MyProject.c,52 :: 		Lcd_Out(2, 3, "Eau= ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,53 :: 		pot = ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _pot+0
	MOVF       R0+1, 0
	MOVWF      _pot+1
;MyProject.c,54 :: 		pourcentage = ((float) pot / 1023.0) * 100.0;
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _pourcentage+0
	MOVF       R0+1, 0
	MOVWF      _pourcentage+1
	MOVF       R0+2, 0
	MOVWF      _pourcentage+2
	MOVF       R0+3, 0
	MOVWF      _pourcentage+3
;MyProject.c,55 :: 		IntToStr(pourcentage, pot1);
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _pot1+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,56 :: 		Lcd_Out(2, 8, pot1);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _pot1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,58 :: 		if (RB7_bit == 0) {
	BTFSC      RB7_bit+0, BitPos(RB7_bit+0)
	GOTO       L_main6
;MyProject.c,59 :: 		nbj = 0;
	CLRF       _nbj+0
	CLRF       _nbj+1
;MyProject.c,60 :: 		}
L_main6:
;MyProject.c,61 :: 		if (PORTB.RB4 == 1 ) {
	BTFSS      PORTB+0, 4
	GOTO       L_main7
;MyProject.c,62 :: 		PORTC.RC0 = 0;
	BCF        PORTC+0, 0
;MyProject.c,63 :: 		PORTE.RE0 = 0;
	BCF        PORTE+0, 0
;MyProject.c,64 :: 		PORTE.RE1 = 0;
	BCF        PORTE+0, 1
;MyProject.c,65 :: 		PORTC.RC7 = 0;
	BCF        PORTC+0, 7
;MyProject.c,66 :: 		nbj++;
	INCF       _nbj+0, 1
	BTFSC      STATUS+0, 2
	INCF       _nbj+1, 1
;MyProject.c,67 :: 		pot = ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _pot+0
	MOVF       R0+1, 0
	MOVWF      _pot+1
;MyProject.c,68 :: 		pourcentage = ((float) pot / 1023.0) * 100.0;
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _pourcentage+0
	MOVF       R0+1, 0
	MOVWF      _pourcentage+1
	MOVF       R0+2, 0
	MOVWF      _pourcentage+2
	MOVF       R0+3, 0
	MOVWF      _pourcentage+3
;MyProject.c,69 :: 		IntToStr(pourcentage, pot1);
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _pot1+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,70 :: 		Lcd_Out(2, 8, pot1);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _pot1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,72 :: 		if (pourcentage < 75) {
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      22
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	MOVF       _pourcentage+0, 0
	MOVWF      R0+0
	MOVF       _pourcentage+1, 0
	MOVWF      R0+1
	MOVF       _pourcentage+2, 0
	MOVWF      R0+2
	MOVF       _pourcentage+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main8
;MyProject.c,73 :: 		PORTC.RC2 = 0;
	BCF        PORTC+0, 2
;MyProject.c,74 :: 		PORTE.RE2 = 0;
	BCF        PORTE+0, 2
;MyProject.c,75 :: 		} else if (pourcentage >= 75) {
	GOTO       L_main9
L_main8:
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      22
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	MOVF       _pourcentage+0, 0
	MOVWF      R0+0
	MOVF       _pourcentage+1, 0
	MOVWF      R0+1
	MOVF       _pourcentage+2, 0
	MOVWF      R0+2
	MOVF       _pourcentage+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main10
;MyProject.c,76 :: 		PORTC.RC2 = 1;
	BSF        PORTC+0, 2
;MyProject.c,77 :: 		for (i = 0; i < 5; i++) {
	CLRF       _i+0
L_main11:
	MOVLW      5
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main12
;MyProject.c,78 :: 		PORTE.RE2 = 1;
	BSF        PORTE+0, 2
;MyProject.c,79 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
	NOP
	NOP
;MyProject.c,80 :: 		PORTE.RE2 = 0;
	BCF        PORTE+0, 2
;MyProject.c,81 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
	NOP
	NOP
;MyProject.c,77 :: 		for (i = 0; i < 5; i++) {
	INCF       _i+0, 1
;MyProject.c,82 :: 		}
	GOTO       L_main11
L_main12:
;MyProject.c,83 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main16:
	DECFSZ     R13+0, 1
	GOTO       L_main16
	DECFSZ     R12+0, 1
	GOTO       L_main16
	DECFSZ     R11+0, 1
	GOTO       L_main16
	NOP
	NOP
;MyProject.c,84 :: 		PORTC.RC2 = 0;
	BCF        PORTC+0, 2
;MyProject.c,85 :: 		}
L_main10:
L_main9:
;MyProject.c,86 :: 		}
	GOTO       L_main17
L_main7:
;MyProject.c,87 :: 		else if (PORTB.RB5 == 1 && PORTB.RB1 == 1 && PORTB.RB0 == 1) {
	BTFSS      PORTB+0, 5
	GOTO       L_main20
	BTFSS      PORTB+0, 1
	GOTO       L_main20
	BTFSS      PORTB+0, 0
	GOTO       L_main20
L__main58:
;MyProject.c,88 :: 		PORTC.RC0 = 1;
	BSF        PORTC+0, 0
;MyProject.c,89 :: 		PORTE.RE0 = 1;
	BSF        PORTE+0, 0
;MyProject.c,90 :: 		}
	GOTO       L_main21
L_main20:
;MyProject.c,91 :: 		else if (PORTB.RB5 == 1 && PORTB.RB1 == 0 && PORTB.RB4 == 0 && PORTB.RB1 == 0) {
	BTFSS      PORTB+0, 5
	GOTO       L_main24
	BTFSC      PORTB+0, 1
	GOTO       L_main24
	BTFSC      PORTB+0, 4
	GOTO       L_main24
	BTFSC      PORTB+0, 1
	GOTO       L_main24
L__main57:
;MyProject.c,92 :: 		PORTC.RC0 = 0;
	BCF        PORTC+0, 0
;MyProject.c,93 :: 		PORTC.RC7 = 1;
	BSF        PORTC+0, 7
;MyProject.c,94 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main25:
	DECFSZ     R13+0, 1
	GOTO       L_main25
	DECFSZ     R12+0, 1
	GOTO       L_main25
	DECFSZ     R11+0, 1
	GOTO       L_main25
;MyProject.c,95 :: 		PORTC.RC7 = 0;
	BCF        PORTC+0, 7
;MyProject.c,96 :: 		for (i = 0; i < 3; i++) {
	CLRF       _i+0
L_main26:
	MOVLW      3
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main27
;MyProject.c,97 :: 		PORTE.RE1 = 1;
	BSF        PORTE+0, 1
;MyProject.c,98 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main29:
	DECFSZ     R13+0, 1
	GOTO       L_main29
	DECFSZ     R12+0, 1
	GOTO       L_main29
	NOP
	NOP
;MyProject.c,99 :: 		PORTE.RE1 = 0;
	BCF        PORTE+0, 1
;MyProject.c,100 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main30:
	DECFSZ     R13+0, 1
	GOTO       L_main30
	DECFSZ     R12+0, 1
	GOTO       L_main30
	NOP
	NOP
;MyProject.c,96 :: 		for (i = 0; i < 3; i++) {
	INCF       _i+0, 1
;MyProject.c,101 :: 		}
	GOTO       L_main26
L_main27:
;MyProject.c,102 :: 		NB = 0;
	CLRF       _NB+0
	CLRF       _NB+1
;MyProject.c,103 :: 		}
L_main24:
L_main21:
L_main17:
;MyProject.c,105 :: 		}
L_main2:
;MyProject.c,107 :: 		if (RA4_bit == 1) {
	BTFSS      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_main31
;MyProject.c,108 :: 		if (nbn > 4) {
	MOVF       _nbn+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main61
	MOVF       _nbn+0, 0
	SUBLW      4
L__main61:
	BTFSC      STATUS+0, 0
	GOTO       L_main32
;MyProject.c,109 :: 		Lcd_Out(1, 1, "Gaspillage");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,110 :: 		}
	GOTO       L_main33
L_main32:
;MyProject.c,112 :: 		Lcd_Out(1, 1, "Mode Nuit");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,113 :: 		}
L_main33:
;MyProject.c,114 :: 		Lcd_Out(2, 3, "Eau= ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,115 :: 		pot = ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _pot+0
	MOVF       R0+1, 0
	MOVWF      _pot+1
;MyProject.c,116 :: 		pourcentage = ((float) pot / 1023.0) * 100.0;
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _pourcentage+0
	MOVF       R0+1, 0
	MOVWF      _pourcentage+1
	MOVF       R0+2, 0
	MOVWF      _pourcentage+2
	MOVF       R0+3, 0
	MOVWF      _pourcentage+3
;MyProject.c,117 :: 		IntToStr(pourcentage, pot1);
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _pot1+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,118 :: 		Lcd_Out(2, 8, pot1);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _pot1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,119 :: 		if (RB7_bit == 0) {
	BTFSC      RB7_bit+0, BitPos(RB7_bit+0)
	GOTO       L_main34
;MyProject.c,120 :: 		nbn = 0;
	CLRF       _nbn+0
	CLRF       _nbn+1
;MyProject.c,121 :: 		}
L_main34:
;MyProject.c,122 :: 		if (PORTB.RB6 == 1 && PORTB.RB4 == 0) {
	BTFSS      PORTB+0, 6
	GOTO       L_main37
	BTFSC      PORTB+0, 4
	GOTO       L_main37
L__main56:
;MyProject.c,123 :: 		PORTC.RC0 = 1;
	BSF        PORTC+0, 0
;MyProject.c,124 :: 		PORTE.RE0 = 1;
	BSF        PORTE+0, 0
;MyProject.c,125 :: 		}
L_main37:
;MyProject.c,126 :: 		if (PORTB.RB4 == 1 && PORTB.RB6 == 0) {
	BTFSS      PORTB+0, 4
	GOTO       L_main40
	BTFSC      PORTB+0, 6
	GOTO       L_main40
L__main55:
;MyProject.c,127 :: 		nbn++;
	INCF       _nbn+0, 1
	BTFSC      STATUS+0, 2
	INCF       _nbn+1, 1
;MyProject.c,128 :: 		if (nbn > 5) {
	MOVF       _nbn+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main62
	MOVF       _nbn+0, 0
	SUBLW      5
L__main62:
	BTFSC      STATUS+0, 0
	GOTO       L_main41
;MyProject.c,129 :: 		PORTC.RC7 = 1;
	BSF        PORTC+0, 7
;MyProject.c,130 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main42:
	DECFSZ     R13+0, 1
	GOTO       L_main42
	DECFSZ     R12+0, 1
	GOTO       L_main42
	DECFSZ     R11+0, 1
	GOTO       L_main42
;MyProject.c,131 :: 		PORTC.RC7 = 0;
	BCF        PORTC+0, 7
;MyProject.c,132 :: 		}
L_main41:
;MyProject.c,133 :: 		PORTC.RC0 = 0;
	BCF        PORTC+0, 0
;MyProject.c,134 :: 		PORTE.RE0 = 0;
	BCF        PORTE+0, 0
;MyProject.c,135 :: 		pot = ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _pot+0
	MOVF       R0+1, 0
	MOVWF      _pot+1
;MyProject.c,136 :: 		pourcentage = ((float) pot / 1023.0) * 100.0;
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _pourcentage+0
	MOVF       R0+1, 0
	MOVWF      _pourcentage+1
	MOVF       R0+2, 0
	MOVWF      _pourcentage+2
	MOVF       R0+3, 0
	MOVWF      _pourcentage+3
;MyProject.c,137 :: 		IntToStr(pourcentage, pot1);
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _pot1+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,138 :: 		Lcd_Out(2, 8, pot1);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _pot1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,140 :: 		if (pourcentage < 75) {
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      22
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	MOVF       _pourcentage+0, 0
	MOVWF      R0+0
	MOVF       _pourcentage+1, 0
	MOVWF      R0+1
	MOVF       _pourcentage+2, 0
	MOVWF      R0+2
	MOVF       _pourcentage+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main43
;MyProject.c,141 :: 		PORTC.RC2 = 0;
	BCF        PORTC+0, 2
;MyProject.c,142 :: 		PORTE.RE2 = 0;
	BCF        PORTE+0, 2
;MyProject.c,143 :: 		}
L_main43:
;MyProject.c,144 :: 		if (pourcentage >= 75) {
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      22
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	MOVF       _pourcentage+0, 0
	MOVWF      R0+0
	MOVF       _pourcentage+1, 0
	MOVWF      R0+1
	MOVF       _pourcentage+2, 0
	MOVWF      R0+2
	MOVF       _pourcentage+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main44
;MyProject.c,145 :: 		PORTC.RC2 = 1;
	BSF        PORTC+0, 2
;MyProject.c,146 :: 		for (i = 0; i < 5; i++) {
	CLRF       _i+0
L_main45:
	MOVLW      5
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main46
;MyProject.c,147 :: 		PORTE.RE2 = 1;
	BSF        PORTE+0, 2
;MyProject.c,148 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main48:
	DECFSZ     R13+0, 1
	GOTO       L_main48
	DECFSZ     R12+0, 1
	GOTO       L_main48
	NOP
	NOP
;MyProject.c,149 :: 		PORTE.RE2 = 0;
	BCF        PORTE+0, 2
;MyProject.c,150 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main49:
	DECFSZ     R13+0, 1
	GOTO       L_main49
	DECFSZ     R12+0, 1
	GOTO       L_main49
	NOP
	NOP
;MyProject.c,146 :: 		for (i = 0; i < 5; i++) {
	INCF       _i+0, 1
;MyProject.c,151 :: 		}
	GOTO       L_main45
L_main46:
;MyProject.c,152 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main50:
	DECFSZ     R13+0, 1
	GOTO       L_main50
	DECFSZ     R12+0, 1
	GOTO       L_main50
	DECFSZ     R11+0, 1
	GOTO       L_main50
	NOP
	NOP
;MyProject.c,153 :: 		PORTC.RC2 = 0;
	BCF        PORTC+0, 2
;MyProject.c,154 :: 		}
L_main44:
;MyProject.c,155 :: 		}
L_main40:
;MyProject.c,156 :: 		}
L_main31:
;MyProject.c,159 :: 		if (RB0_bit == 0 && PORTA.RA4 == 0) {
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_main53
	BTFSC      PORTA+0, 4
	GOTO       L_main53
L__main54:
;MyProject.c,160 :: 		Lcd_Out(1, 1, "Bienvenue");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,161 :: 		Lcd_Out(2, 3, "Eau= ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,162 :: 		pot = ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _pot+0
	MOVF       R0+1, 0
	MOVWF      _pot+1
;MyProject.c,163 :: 		pourcentage = ((float) pot / 1023.0) * 100.0;
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _pourcentage+0
	MOVF       R0+1, 0
	MOVWF      _pourcentage+1
	MOVF       R0+2, 0
	MOVWF      _pourcentage+2
	MOVF       R0+3, 0
	MOVWF      _pourcentage+3
;MyProject.c,164 :: 		IntToStr(pourcentage, pot1);
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _pot1+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,165 :: 		Lcd_Out(2, 8, pot1);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _pot1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,166 :: 		}
L_main53:
;MyProject.c,167 :: 		}
	GOTO       L_main0
;MyProject.c,168 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
