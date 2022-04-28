// Exercício 4: Contador Síncrono - valores (1, 2, 4 e 8)

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


  parameter NBITS_CONTADOR = 3; // tamanho do contador

  // declaração das constantes: 1, 2, 4, 8
  parameter NUM_1 = 'h06;
  parameter NUM_2 = 'h5b;
  parameter NUM_4 = 'h66;
  parameter NUM_8 = 'h7f;
  

  //output
  logic[NBITS_CONTADOR-1: 0] count; 

  always_comb LED <= count; 
  
  always_comb begin 
    case (count) 
      1: SEG <= NUM_2;
      2: SEG <= NUM_4;
      3: SEG <= NUM_8;
      default: SEG <= NUM_1;
    endcase
  end

  // funcionamento 
  always_ff @(posedge clk_2) count <= count + 1; 

endmodule
