
`timescale 1 ns / 10 ps
module assert_df_lv_tb ();
  
  localparam N = 20;
  localparam SEED = 1613;
  localparam max_long = 18; //sum(11,7)
  
  logic I1, I2, I3, I4;
  wire O1, O2, O3, O4;
  
  sch_4_to_2_df u0(O1, O2, I1, I2, I3, I4);
  sch_4_to_2_vl u1(O3, O4, I1, I2, I3, I4);
  
  initial begin
    $urandom(SEED);
    
    repeat (N) begin
        {I1, I2, I3, I4} = $urandom();
		#max_long;
	end

    
    #max_long $finish;
  end
  
  always@(O1, O2, O3, O4)
    assert(O1 == O3 && O2 == O4) 
      else $error("O1 != O3 or O2 != O4");
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, assert_df_lv_tb);
  end
  
  initial begin  
    $timeformat(-9, 1, " ns", 6);
    $monitor("%t, I1=%0b, I2=%0b, I3=%0b, I4=%0b, O1=%0b, O2=%0b, O3=%0b, O2=%0b", $time, I1, I2, I3, I4, O1, O2, O3, O4);
  end
endmodule

