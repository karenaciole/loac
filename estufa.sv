// Karen Anne Aciole Alves
// PROBLEMA 2 - Estufa

  logic temperatura_15, temperatura_20, aquecedor, resfriador, inconsistencia; 


  always_comb begin 
    temperatura_15 <= SWI[6];
    temperatura_20 <= SWI[7];
  end

  always_comb begin
    LED[6] <= aquecedor;
    LED[7] <= resfriador;
    SEG[7] <= inconsistencia;
  end
       
  always_comb begin
    aquecedor <= ~(temperatura_15 | temperatura_20);
    inconsistencia <= ~temperatura_15 & temperatura_20;
    resfriador <= temperatura_15 & temperatura_20;
  end
