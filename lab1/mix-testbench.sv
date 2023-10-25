
`timescale 1 ns / 10 ps
module mix_tb ();
  localparam N = 30;
  localparam SEED = 1613;
  
  logic Q0, Q1, T, Clk, Rst;

  sch_3_to_2_mix U1(Q0, Q1, T, Clk, Rst); 
  
  initial begin
    Clk = 0; Rst = 0;
    #5 Rst = 1;
  end
  
  always @(Clk) 
    #10 Clk <= ~Clk;
  
  initial begin
    $random(SEED);
    repeat (N) begin
      {T} = $urandom_range(2**1-1);
      @(negedge Clk);
    end
     #10 $finish;
  end
  
  initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(0, mix_tb);
  end
 
endmodule
