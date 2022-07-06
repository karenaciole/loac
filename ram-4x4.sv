// Karen Anne Aciole Alves
// Roteiro 4 - Questão 2 (Memória RAM R/W 4x4)

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
  parameter LETRA_B = 'h7c;
  parameter LETRA_C = 'h39;
  parameter LETRA_D = 'h5e;
  parameter LETRA_E = 'h79;
  parameter LETRA_F = 'h71;
  
  parameter ADDR_WIDTH=2; 
  parameter DATA_WIDTH=4;

  logic reset, wr_en;
  logic [ADDR_WIDTH-1:0] addr; 
  logic [DATA_WIDTH-1:0] wdata; 
  logic [DATA_WIDTH-1:0] rdata; 
  logic [DATA_WIDTH-1:0] mem [1<<ADDR_WIDTH:0];  

  always_comb begin 
      reset <= SWI[0];
      wr_en <= SWI[1];
      addr <= SWI[3:2];
      wdata <= SWI[7:4];
 end
 
  always_comb begin
      case(mem[addr])
          0: SEG <= NUM_0;
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
          11: SEG <= LETRA_B;
          12: SEG <= LETRA_C;
          13: SEG <= LETRA_D;
          14: SEG <= LETRA_E;
          15: SEG <= LETRA_F;
          default: ;
      endcase
  end
  
  always_ff @(posedge clk_2) begin 
      
      if (reset) //loop para resetar dados em cada endereço da memória
          for (int i=0; i<1<<ADDR_WIDTH; i++) begin
              mem[i] <= 0;
              rdata <= 0;
          end 
      
      else if (wr_en & ~reset) 
          mem[addr] <= wdata;
      
      else 
          rdata <= mem[addr];
  end

  always_comb begin 
    LED[0] <= clk_2;
    LED[1] <= wr_en;
    LED[7:4] <= rdata; 
  end
