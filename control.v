`timescale 1ns / 1ps

module control (clk,rst_button,game_mode1_button,game_mode2_button,led,buttons,an,seg);

  // control module is the Top level module which calls other module and acts like a testbench for our game
 // rst_buttons takes input from FPGA
input clk, rst_button;
input [15:0] buttons;

  // game_mode1_button, game_mode2_button take input from FPGA
input game_mode1_button,game_mode2_button;

  // seg contains the cathode value for Seven segment display
  // an tells which Anode we have to switch so that a segment display can grow
output wire [6:0] seg;
output wire [ 3:0] an;
output wire [15:0] led; 

// All the below variables stores / passes information from one module to another module 
wire [6:0] score ;
wire [6:0] max_score;
wire [3:0] state;
wire [1:0] action_type;
wire [15:0] press;
wire[ 31:0] counter_check;


wire rst_button;
wire game_mode1_button;
wire game_mode2_button;

wire rst;
wire game_mode1;
wire game_mode2;


// we are calling the specigic modules in a specific order to make our game work properly
  reset dut0(rst_button,rst, clk);   

game_mode dut2( game_mode1_button,game_mode2_button,game_mode1,game_mode2,clk );

spaceship_LED_state dut3( game_mode1,game_mode2,state, clk, rst, led);

check dut4( state, action_type, clk, buttons,press);

score_module dut5(action_type, score, max_score, clk, rst);

display dut6( score,max_score,seg,an,clk);


endmodule
