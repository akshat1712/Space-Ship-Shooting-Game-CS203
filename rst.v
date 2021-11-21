module reset (button_rst_local,rst,clk);
      input button_rst_local,clk;
      output reg rst;

      always @( posedge clk) begin
            
      if( button_rst_local==1'b1)
            rst=1'b1;
      else
            rst=1'b0;
      end
endmodule
