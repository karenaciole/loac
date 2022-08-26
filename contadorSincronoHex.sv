// Karen Anne Aciole Alves
// Exercício 2: Contador Síncrono Hexadecimal de 4 bits

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
