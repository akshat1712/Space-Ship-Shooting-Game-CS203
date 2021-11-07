`timescale 1ns / 1ps
`include "project.v"
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


module Spaceship_LED_tb( );
reg [3:0] default_state;
wire [3:0] out_state;
reg clk,rst;

Spaceship_LED_state dut(.default_state(default_state), .out_state(out_state), .Clk(clk), .rst(rst));
initial begin

    
    clk=1'b0;default_state=4'b0010;rst=1;
    //$display("default_state is %d ",default_state);
    #10
    $display("Out_State is %d ", out_state);
    
    rst=0;
    //$display("default_state is %d ",default_state);
    #10
    $display("Out_State is %d ", out_state);
    
    // rst=0;
    //$display("default_state is %d ",default_state);
    #10
    $display("Out_State is %d ", out_state);
    
    // rst=0;
   // $display("default_state is %d ",default_state);
    #10
    $display("Out_State is %d ", out_state);
   
    // rst=0;
   // $display("default_state is %d ",default_state);
    #10
    $display("Out_State is %d ", out_state);

    // rst=0;
   // $display("default_state is %d ",default_state);
    #10
    $display("Out_State is %d ", out_state);

    // rst=0;
   // $display("default_state is %d ",default_state);
    #10
    $display("Out_State is %d ", out_state);

    // rst=0;
   // $display("default_state is %d ",default_state);
    #10
    $display("Out_State is %d ", out_state);

    // rst=0;
   // $display("default_state is %d ",default_state);
    #10
    $display("Out_State is %d ", out_state);

    // rst=0;
   // $display("default_state is %d ",default_state);
    #10
    $display("Out_State is %d ", out_state);

    // rst=0;
   // $display("default_state is %d ",default_state);
    #10
    $display("Out_State is %d ", out_state);

    rst=1;
   // $display("default_state is %d ",default_state);
    #10
    $display("Out_State is %d ", out_state);

    rst=0;
   // $display("default_state is %d ",default_state);
    #10
    $display("Out_State is %d ", out_state);

    // rst=0;
   // $display("default_state is %d ",default_state);
    #10
    $display("Out_State is %d ", out_state);
end

always
    #5 clk=~clk;

initial
    #1000 $finish;

endmodule