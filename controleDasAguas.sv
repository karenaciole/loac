// Karen Anne Aciole Alves 
// Roteiro 3  - Questão 1 (Controle das águas de boqueirão)

  parameter NIVEL_ALTO = 'b01011111; // letra 'a'
  parameter NIVEL_NORMAL = 'b01010100; // letra 'n'
  parameter NIVEL_BAIXO = 'b01111100; // letra 'b';
  parameter DESCALIBRADO = 'b01011110; // letra 'd'
  
  logic [2:0] sinal; 

  always_comb sinal <= SWI; 

  always_comb begin 
    case (sinal) 
      'b01: SEG <= NIVEL_NORMAL;
      'b10: SEG <= NIVEL_BAIXO;
      'b11: SEG <= DESCALIBRADO;
      default: SEG <= NIVEL_ALTO;
    endcase
  end

endmodule
