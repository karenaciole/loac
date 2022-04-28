// Atividade 04 (Exercício 5 - ULA)
// Funcionando no Simulate, mas ao enviar para o Remote apresenta erro na linha 56. Devido ao tempo não consegui identificar o problema. 

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

  parameter NBITS_OPERADORES = 2; 
  parameter NBITS_F = 3; 
  parameter NBITS_RESULTADO = 2; 

  //input 
  logic [NBITS_OPERADORES-1:0] a, b; logic [NBITS_F-1:0] f; 
  always_comb a <= SWI[3:2]; always_comb b <= SWI[1:0]; always_comb f <= SWI[6:4]; 

  //output
  logic [NBITS_RESULTADO-1:0] y;
  always_comb LED[NBITS_RESULTADO-1:0] <= y;

  //ULA 
  always_comb begin
    case (f)
      'b000: y <= a & b; 
      'b001: y <= a | b;
      'b010: y <= a + b;
      'b100: y <= a & ~b; 
      'b101: y <= a | ~b; 
      'b110: y <= a - b;
      'b111: y <= a < b; 
    endcase
  end

endmodule
