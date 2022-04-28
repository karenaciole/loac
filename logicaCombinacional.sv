// Atividade 02 (Lógica Combinacional)

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

// QUESTÃO 1 - FIM DE EXPEDIENTE 

//input
logic noite; logic maquinas_fora_de_operacao; logic sexta_feira; logic producao_atendida; 
always_comb noite <= SWI[4]; always_comb maquinas_fora_de_operacao <= SWI[5]; always_comb sexta_feira <= SWI[6]; always_comb producao_atendida <= SWI[7];

//output
logic sirene; 
always_comb LED[2] <= sirene; 

//condicao
always_comb
  if (maquinas_fora_de_operacao)
    if (noite)
      sirene <= 1;

    else 
      if (sexta_feira)
        if (producao_atendida)
          sirene <= 1; 
        else 
          sirene <= 0; 
      else
        sirene <= 0;
  else 
    sirene <= 0; 


// QUESTÃO 2 - AGÊNCIA BANCÁRIA 

//input 
logic cofre; logic relogio_expediente; logic interruptor_gerente;
always_comb cofre <= SWI[0]; always_comb relogio_expediente <= SWI[1]; always_comb interruptor_gerente <= SWI[2];

//output
logic alarme;
always_comb SEG[0] <= alarme; 

// condicao 
always_comb alarme <= cofre & ~(relogio_expediente & ~interruptor_gerente);


// QUESTÃO 3 - ESTUFA 

//input
logic t1; logic t2; // t1 = temperatura >= 15, t2 = temperatura >= 20 
always_comb t1 <= SWI[3]; always_comb t2 <= SWI[4];

//output
logic aquecedor; logic resfriador; logic inconsistencia;
always_comb LED[6] <= aquecedor; always_comb LED[7] <= resfriador; always_comb SEG[7] <= inconsistencia;

//condicao

always_comb aquecedor <= ~(t1 | t2); 
always_comb resfriador <= (t1 & t2);
always_comb inconsistencia <= (~t1 & t2) | (t1 & ~t2);


// QUESTÃO 4 - AERONAVE 

//input 
logic lavatorio_mulheres; logic lavatorio_unissex_1; logic lavatorio_unissex_2; 
always_comb lavatorio_mulheres <= SWI[0]; always_comb lavatorio_unissex_1 <= SWI[1]; always_comb lavatorio_unissex_2 <= SWI[2]; 

//output 
logic lavatorio_livre_mulheres; logic lavatorio_livre_homens; 
always_comb LED[0] <= lavatorio_livre_mulheres; always_comb LED[1] <= lavatorio_livre_homens; 

//condicao
always_comb lavatorio_livre_mulheres <= ~(lavatorio_mulheres & lavatorio_unissex_1 & lavatorio_unissex_2);
always_comb lavatorio_livre_homens <= ~(lavatorio_unissex_1 & lavatorio_unissex_2);

endmodule
