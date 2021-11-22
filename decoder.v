`timescale 1ns / 1ps

module decoder(
    digit_bcd, seg_l);
    
    // decoder outputs a seven bit cathode value depending which digit we have to show , input of digit is done in BCD format
    input [3:0] digit_bcd;
    output reg [6:0] seg_l;
    always@( digit_bcd) begin
 case( digit_bcd)
    4'b0000: seg_l = 7'b0000001;   
    4'b0001: seg_l = 7'b1001111; 
    4'b0010: seg_l = 7'b0010010;  
    4'b0011: seg_l = 7'b0000110;  
    4'b0100: seg_l = 7'b1001100;  
    4'b0101: seg_l = 7'b0100100;  
    4'b0110: seg_l = 7'b0100000;  
    4'b0111: seg_l = 7'b0001111;  
    4'b1000: seg_l = 7'b0000000;   
    4'b1001: seg_l = 7'b0000100;  
    default: seg_l = 7'b0000001; 
 endcase 
 end
endmodule
