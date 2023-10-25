`timescale 1 ns / 10 ps

module shift_gen_tb;
  
  localparam N = 50;
  localparam SEED = 1613;
  localparam MSB = 5;
  
  logic  clk, rst, reverse, load; 
  reg [MSB-1:0] data;
  reg [MSB-1:0] shifter;
  
  shift_reg_gen #(MSB) sh (.Clk(clk), .Rst(rst), .D(data), .R(reverse), .Q(shifter), .Load(load));   

  always #10 clk = ~clk; // time pick
  
  initial begin //init config
    clk <= 0; rst <= 1; reverse<= 0; load <= 1;
    $urandom(SEED);
  end
  
  initial begin //starter
    byte unsigned delay;
    delay = $urandom_range(2, 5);
    repeat (delay) @(posedge clk);
    // [right] shift test
    #20 repeat (MSB) @(negedge clk) data<=shifter;    
    
    //[left] shift test
    begin reverse<=1; rst<=0; reverse<=1; end // reset config
    #20 rst<=1;
    repeat (MSB) @(negedge clk) data<=shifter;  
    
    $finish;
  end
 
  initial begin // Dump waves & console log
    reg [MSB-1:0] test;
    $monitor ("test logic shift operator: [left] %b | [right] %b", test<<2, test>>2);
    $dumpfile("dump.vcd");
    $dumpvars(0, shift_gen_tb);
    $monitor ("rst=%0b, load=%0b, reverse=%0b, data=%b, result=%b", rst, load, reverse, data, shifter);
  end
endmodule
