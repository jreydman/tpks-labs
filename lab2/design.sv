module counter
   #(parameter SIZE = 'd4)
  (input  Clk, Rst, en, [2:0] D, [1:0] s,
   output logic [SIZE-1:0] COUNTER);
  always_ff @(posedge Clk, posedge Rst) begin
    if (Rst) COUNTER <= 'd0;
    else if (en) begin
        case (s)
            2'b00: COUNTER <= D;
            2'b01: COUNTER <= COUNTER + 1;
            2'b10: COUNTER <= COUNTER + 2;
            2'b11: COUNTER <= COUNTER + 3;
            default: COUNTER <= COUNTER;
        endcase
    end
end

endmodule

module shift_reg #(parameter MSB=5)
  (input Clk, Rst, Load, R, reg [MSB-1:0] D, output reg [MSB-1:0] Q);
   always_ff @(negedge Clk, negedge Rst)
    if (!Rst) Q <= 5'bx;
    else begin
      if (Load) 
        case (R)
          0 :  Q = D>>2;
          1 :  Q = D<<2;
      	endcase
      else Q <= D;
    end
endmodule

module shift_reg_gen #(parameter MSB=5)
  (input Clk, Rst, Load, R, reg [MSB-1:0] D, output reg [MSB-1:0] Q);
  generate
    genvar i; // unusing insay
    shift_reg #(MSB) shift (.Clk(Clk), .Rst(Rst), .D(D), .R(R), .Q(Q), .Load(Load));  
  endgenerate
endmodule
