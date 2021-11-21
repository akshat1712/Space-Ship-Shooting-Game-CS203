module display( score, max_score, seg, an, clk);

input clk;    
input [6:0] score, max_score;
output reg [3:0] an;
output reg [6:0] seg;

reg [3:0]  score_digit_o, score_digit_t, max_score_digit_o, max_score_digit_t;

always @(score or max_score)begin
      score_digit_o=score%10;
      score_digit_t=score/10;
      
      max_score_digit_o=max_score%10;
      max_score_digit_t=max_score/10; 
end

wire [6:0] s1, s2, s3, s4;

reg [1:0] state_dummy; 
reg [12:0] seg_clk;
reg [1:0] state_local=2'b00;

wire newclk;

decoder d1( score_digit_o,s1);
decoder d2( score_digit_t,s2);
decoder d3( max_score_digit_o,s3);
decoder d4( max_score_digit_t,s4);

assign newclk = seg_clk[12]; 

always@(posedge clk) 
    seg_clk=seg_clk+1;

always@( posedge newclk )begin

    case(state_local)
    
    2'b00: begin
    seg<=s1;
    an<=4'b1011;//midleft
    state_dummy=2'b01;
    end
    
    2'b01: begin
    seg<=s2;
    an<=4'b0111;//left
    state_dummy=2'b10;
    end
    
    2'b10: begin
    seg<=s3;
    an<=4'b1110;//right
    state_dummy=2'b11;
    end
    
    2'b11: begin
    seg<=s4;
    an<=4'b1101;//midright
    state_dummy=2'b00;
    end
    
    default: begin
    seg<=s1;
    an<=4'b1011;//midleft
    state_dummy=2'b01;
    end
    endcase
    
    state_local = state_dummy;

end
      
endmodule


module decoder(digit_bcd, seg_l);

    input [3:0] digit_bcd;
    output reg [6:0] seg_l;
    
    always@( digit_bcd) begin
    
        case(digit_bcd)
            4'b0000: seg_l <= 7'b1000000;   
            4'b0001: seg_l <= 7'b1111001; 
            4'b0010: seg_l <= 7'b0100100;  
            4'b0011: seg_l <= 7'b0110000;  
            4'b0100: seg_l <= 7'b0011001;  
            4'b0101: seg_l <= 7'b0010010;  
            4'b0110: seg_l <= 7'b0000010;  
            4'b0111: seg_l <= 7'b1111000;  
            4'b1000: seg_l <= 7'b0000000;   
            4'b1001: seg_l <= 7'b0010000;  
            default: seg_l <= 7'b1000000; 
        endcase 
    
 end

endmodule