// Karen Anne Aciole Alves
// Roteiro 4- Questão 3 (Memória RAM ROM 4x4)

  parameter NUM_5 = 'h6d;
  parameter NUM_6 = 'h7d;
  parameter NUM_9 = 'h6f;
  parameter LETRA_C = 'h39;

  parameter ADDR_WIDTH=2; 
  parameter DATA_WIDTH=4;

  logic [ADDR_WIDTH-1:0] addr;
  logic [DATA_WIDTH-1:0] data;

  always_comb addr <= SWI[3:2];

  always_comb begin
      case(addr)
          'b00: SEG = NUM_6; // 0110
          'b01: SEG = LETRA_C; // 1100
          'b10: SEG = NUM_9; // 1001
          'b11: SEG = NUM_5; // 0101
      endcase

      case (addr)
          'b00: data = 'b0110;
          'b01: data = 'b1100; 
          'b10: data = 'b1001; 
          'b11: data = 'b0101; 
      endcase
  end

  always_comb LED[7:4] <= data; 
