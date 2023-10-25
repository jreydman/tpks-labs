
`timescale 1ns/1ps

module counter_tb;
  localparam N = 30;
  localparam SEED = 1613;
  localparam SIZE = 32;
  
  localparam time_point = 10;
  
  logic clk, rst, en;
  logic [1:0] s;
  logic [SIZE-1:0] D;
  logic [SIZE-1:0] COUNTER;

  initial begin //set max N repeates of counter
   repeat (N) @(negedge clk);
     #time_point $finish;
  end
  
  counter uut (.Clk(clk), .Rst(rst), .en(en), .s(s), .COUNTER(COUNTER), .D(D));

  // ping
  always @(clk) 
    #time_point clk <= ~clk;
  
  // gen new func value at every low type clk
  always @(posedge clk) begin
    byte unsigned del;
    #time_point s = $urandom_range(0, 3);
       
    del = $urandom_range(2, 4);
    repeat (del) @(negedge clk);
    rst <= ~rst;
    #time_point rst <= ~rst;
  end
  
  
  // load waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, counter_tb);
  end 
  
  //starter
  initial begin
    $urandom(SEED);
    clk = 0; rst = 1; en=0; s = 2'b00;

    D = 32'h0; // set parallel load value 0 [static]
    
    #time_point rst = 0;
    en = 1; // Counter status enable
  end
endmodule
