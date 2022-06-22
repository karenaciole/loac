// Karen Anne Aciole Alves
// PROBLEMA 1 - Agência Bancária

  logic cofre, relogio_expediente, interruptor_gerente, alarme;
  
  always_comb begin
	  cofre <= SWI[0]; 
	  relogio_expediente <= SWI[1]; 
	  interruptor_gerente <= SWI[2];
  end
  
  always_comb LED[1] <= alarme; 

  always_comb begin
    if (cofre) 
      if (relogio_expediente)
        if (interruptor_gerente) 
          alarme <= 1;
        else 
          alarme <= 0;
      else
        alarme <= 1; 
    else 
      alarme <= 0;
  end
