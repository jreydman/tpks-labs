
`timescale 1 ns / 10 ps
module vl_tb ();
  
  localparam max_long = 18; //sum(11,7)

  logic I1, I2, I3, I4;
  wire O1, O2;
  
  sch_4_to_2_vl u0(O1, O2, I1, I2, I3, I4);

  initial begin
    I1 = 1'b0; I2 = 1'b0; I3 = 1'b0; I4 = 1'b0;
    #max_long I1 = 1'b0; I2 = 1'b0; I3 = 1'b0; I4 = 1'b1;
    #max_long I1 = 1'b0; I2 = 1'b0; I3 = 1'b1; I4 = 1'b0;
    #max_long I1 = 1'b0; I2 = 1'b1; I3 = 1'b0; I4 = 1'b0;
    #max_long I1 = 1'b1; I2 = 1'b0; I3 = 1'b0; I4 = 1'b1;
    #max_long I1 = 1'b1; I2 = 1'b0; I3 = 1'b0; I4 = 1'b1;
    #max_long I1 = 1'b0; I2 = 1'b1; I3 = 1'b0; I4 = 1'b1;
    #max_long I1 = 1'b0; I2 = 1'b0; I3 = 1'b1; I4 = 1'b1;
    #max_long I1 = 1'b0; I2 = 1'b1; I3 = 1'b1; I4 = 1'b0;
    #max_long I1 = 1'b1; I2 = 1'b0; I3 = 1'b1; I4 = 1'b0;
    #max_long I1 = 1'b1; I2 = 1'b1; I3 = 1'b0; I4 = 1'b0;

    #max_long $finish;

  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, vl_tb);
  end
  
  initial begin  
    $timeformat(-9, 1, " ns", 6);
    $monitor("%t, I1=%0b, I2=%0b, I3=%0b, I4=%0b, O1=%0b, O2=%0b", $time, I1, I2, I3, I4, O1, O2);
  end
endmodule

