// Karen Anne Aciole Alves
// Questão 3 - ULA


  logic [2:0] a, b, y;
  logic [1:0] f;
  logic under_over; // underflow ou overflow

  always_comb begin
    a <= SWI[7:5]; // 3 bits
    b <= SWI[2:0]; // 3 bits
    f <= SWI[4:3]; // 2 bits - operação 
  end
  
  always_comb LED[2:0] <= y; // saída
always_comb LED[7] <= under_over; // led de under/overflow

  always_comb begin 
    case(f) // operações
      'b01: y <= a | b; // OR 
      'b10: y <= a + b; // SOMA
      'b11: y <= a - b; //SUBTRAÇÃO
      default: y <= a & b; // AND
    endcase

    under_over <= a+b > 3 ? 1 : 0; // checagem de under/over flow quando a soma é maior que 3
    under_over <= a < b ? 1 : 0;  //  checagem de under/over flow quando b é menor que a

    case(y) // saída no Display de 7 segmentos
      0: SEG <= NUM_0;
      1: SEG <= NUM_1;
      2: SEG <= NUM_2;
      3: SEG <= NUM_3;
      4: SEG <= NUM_4;
      5: SEG <= NUM_5;
      6: SEG <= NUM_6;
      7: SEG <= NUM_7;
      default: SEG <= 0;
    endcase
  
  end
