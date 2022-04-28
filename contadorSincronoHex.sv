// Exercício 2: Contador Síncrono Hexadecimal de 4 bits

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


  parameter NBITS_CONTADOR = 4; // tamanho do contador
  parameter RESET_CONTADOR = 0; // reset

  // declaração das constantes: 0 a F
  parameter NUM_0 = 'h3f;
  parameter NUM_1 = 'h06;
  parameter NUM_2 = 'h5b;
  parameter NUM_3 = 'h4f;
  parameter NUM_4 = 'h66;
  parameter NUM_5 = 'h6d;
  parameter NUM_6 = 'h7d;
  parameter NUM_7 = 'h7;
  parameter NUM_8 = 'h7f;
  parameter NUM_9 = 'h6f;
  parameter LETRA_A = 'h77;
  parameter LETRA_b = 'h7c;
  parameter LETRA_C = 'h39;
  parameter LETRA_d = 'h5e;
  parameter LETRA_E = 'h79;
  parameter LETRA_F = 'h71;

  // input 
  logic reset, select_count; 

  always_comb reset <= SWI[0]; 
  always_comb select_count <= SWI[1]; // crescente ou decrescente
  
  //output
  logic[NBITS_CONTADOR-1: 0] count; 

  always_comb LED <= count; 
  
  always_comb begin 
    case (count) 
      1: SEG <= NUM_1;
      2: SEG <= NUM_2;
      3: SEG <= NUM_3;
      4: SEG <= NUM_4;
      5: SEG <= NUM_5;
      6: SEG <= NUM_6;
      7: SEG <= NUM_7;
      8: SEG <= NUM_8;
      9: SEG <= NUM_9;
      10: SEG <= LETRA_A;
      11: SEG <= LETRA_b;
      12: SEG <= LETRA_C;
      13: SEG <= LETRA_d;
      14: SEG <= LETRA_E;
      15: SEG <= LETRA_F;
      default: SEG <= NUM_0;
    endcase
  end

  // funcionamento 
  always_ff @(posedge clk_2) begin
    if (reset)
      count <= RESET_CONTADOR; 
    else begin 
      if (select_count)
        count <= count - 1; 
      else 
        count <= count + 1; 
    end 
  end
  

endmodule
