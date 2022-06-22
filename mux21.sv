// Karen Anne Aciole Alves 
// Roteiro 3  - Questão 2 (Multiplexador 2:1) 

  logic [2:0] a, b, saida;
  logic [1:0] selecao; // seleciona qual mensagem irá ser transmitida (a ou b) 

  always_comb begin 
    a <= SWI[4:3];
    b <= SWI[6:5];
    selecao <= SWI[7];
  end

  always_comb LED[7:6] <= saida;

  always_comb saida <= selecao ? b : a; 

endmodule
