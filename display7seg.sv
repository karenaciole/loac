// Atividade 03 (Lógica Combinacional e Display de 7 Segmentos)

parameter divide_by=100000000;  // divisor do clock de referência
// A frequencia do clock de referencia é 50 MHz.
// A frequencia de clk_2 será de  50 MHz / divide_by

parameter NBITS_INSTR = 32;
parameter NBITS_TOP = 8, NREGS_TOP = 32, NBITS_LCD = 64;
module top(input  logic clk_2,
           input  logic [NBITS_TOP-1:0] SWI,
           output logic [NBITS_TOP-1:0] LED,
           output logic [NBITS_TOP-1:0] SEG,
           output logic [NBITS_LCD-1:0] lcd_a, lcd_b,
           output logic [NBITS_INSTR-1:0] lcd_instruction,
           output logic [NBITS_TOP-1:0] lcd_registrador [0:NREGS_TOP-1],
           output logic [NBITS_TOP-1:0] lcd_pc, lcd_SrcA, lcd_SrcB,
             lcd_ALUResult, lcd_Result, lcd_WriteData, lcd_ReadData, 
           output logic lcd_MemWrite, lcd_Branch, lcd_MemtoReg, lcd_RegWrite);

  always_comb begin
    //SEG <= SWI;
    lcd_WriteData <= SWI;
    lcd_pc <= 'h12;
    lcd_instruction <= 'h34567890;
    lcd_SrcA <= 'hab;
    lcd_SrcB <= 'hcd;
    lcd_ALUResult <= 'hef;
    lcd_Result <= 'h11;
    lcd_ReadData <= 'h33;
    lcd_MemWrite <= SWI[0];
    lcd_Branch <= SWI[1];
    lcd_MemtoReg <= SWI[2];
    lcd_RegWrite <= SWI[3];
    for(int i=0; i<NREGS_TOP; i++)
       if(i != NREGS_TOP/2-1) lcd_registrador[i] <= i+i*16;
       else                   lcd_registrador[i] <= ~SWI;
    lcd_a <= {56'h1234567890ABCD, SWI};
    lcd_b <= {SWI, 56'hFEDCBA09876543};
  end

// QUESTÃO 1 - Situação do aluno

parameter LETRA_A = 'b01110111; // aprovado
parameter LETRA_F = 'b01110001; // final
parameter LETRA_P = 'b01110011; // perdeu
parameter NBITS_NOTA = 4; 

//input 
logic [NBITS_NOTA-1:0] nota; 
always_comb nota <= SWI;

//output
always_comb 
    if (nota >= 7) SEG <= LETRA_A;
    else if (nota >= 4) SEG <= LETRA_F;
    else SEG <= LETRA_P;


// QUESTÃO 2 - Controle das águas de boqueirão

parameter NIVEL_ALTO = 'b01011111; // letra 'a'
parameter NIVEL_NORMAL = 'b01010100; // letra 'n'
parameter NIVEL_BAIXO = 'b01111100; // letra 'b';
parameter DESCALIBRADO = 'b01011110; // letra 'd'
parameter NBITS_SINAL = 2; 

//input 
logic [NBITS_SINAL-1:0] sinal;

always_comb sinal <= SWI; 

always_comb 
  if (sinal == 'b00)
    SEG <= NIVEL_ALTO;
  else if (sinal == 'b01)
    SEG <= NIVEL_NORMAL; 
  else if (sinal == 'b10)
    SEG <= NIVEL_BAIXO;
  else 
    SEG <= DESCALIBRADO;

endmodule
