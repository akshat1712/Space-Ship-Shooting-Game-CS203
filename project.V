`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institute: IIT Ropar 
// Members: Pranavkumar Mallela and Akshat Sinha
// 
// Create Date: 05.11.2021 11:10:53
// Design Name: 
// Module Name: Spaceship_LED_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Spaceship_LED_state( default_state, out_state, Clk, rst);
  input [3:0] default_state;
  output reg [3:0] out_state;
  input Clk, rst;
  always @ (posedge Clk) begin
      if (rst)
            out_state<=default_state;
      else if(out_state==4'b1110)
            out_state<=4'b0010;
      else
            out_state<=out_state+2;
  end

endmodule