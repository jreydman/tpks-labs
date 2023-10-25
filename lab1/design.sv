

//valve
module sch_4_to_2_vl (output On1, output On2,							
                   	  input In1, In2, In3, In4);
		wire Y1, Y2;
  
  		nand #5 (Y1, In1, In2);
 		nand #7 (Y2, In2, In3);
  		xor #11 (On1, Y1, Y2);
  		and #10 (On2, Y2, In4);
endmodule

//dataflow
module sch_4_to_2_df (output On1, output On2,							
                   	  input In1, In2, In3, In4);
		logic Y1, Y2;
  
  		assign #5 	Y1 = ~(In1 & In2);
  		assign #7 	Y2 = ~(In2 & In3);
  		assign #11 	On1 = Y1 ^ Y2;
  		assign #10 	On2 = Y2 & In4;
endmodule

//mixed
module sch_3_to_2_mix (output reg Q0, Q1,
                        input T, Clk, Rst);	 
  
  // ! i'm comment next elements to demonstrate code shortening !
  
  //wire Y1, Y2, Y3, Y4, Y5, Y6;
  
  // dataflow [syntax]
  // assign Y1 = Q0 & ~T;
  // assign Y2 = ~Q0 & T;
  // assign Y3 = Y1 | Y2;
  // assign Y4 = Q1 & ~Q0;
  // assign Y5 = ~Q1 & Q0;
  // assign Y6 = Y4 | Y5;

  // behavioral [syntax]
  always @(posedge Clk, negedge Rst)
    if (~Rst) Q0 = 0;
		else Q0 = Q0 & ~T | ~Q0 & T; // Y3
  
  always @(posedge Clk, negedge Rst)
    if (~Rst) Q1 = 0;
		else Q1 = Q1 & ~Q0 | ~Q1 & Q0; // Y6
    
endmodule
