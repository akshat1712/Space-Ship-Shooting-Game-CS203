module display( score, max_score, seg, an, clk);
      //This module takes care of the display of the current score(score), and maximum score(max_score) on the seven segment display
      input clk;//clock signal
      input [6:0] score, max_score;//7-bit numbers to indicate score and maximum score(Range: 0 - 99)
      output reg [3:0] an;//4-bit number(one hot encoding) to indicate which position has to glow (left, midleft, midright, right)
      output reg [6:0] seg;//7-bit number to indicate which segments of the 7 segment display should glow (abcdefg)

      reg [3:0]  score_digit_o, score_digit_t, max_score_digit_o, max_score_digit_t;//Ones and Tens digit of score and max_score

      always @(score or max_score)begin //always block: sensitivity list has score or max_score
            //Finding ones and tens digit of the score and maximum score
            score_digit_o=score%10;
            score_digit_t=score/10;

            max_score_digit_o=max_score%10;
            max_score_digit_t=max_score/10; 
      end

      wire [6:0] s1, s2, s3, s4;//Four 7-bit wires, to pass the segment values to [6:0] seg for each of the four digits on the display.

      reg [1:0] state_dummy; //2-bit reg to store the modified state value (00, 01, 10, 11)
      reg [12:0] seg_clk;//13-bit clock divider
      reg [1:0] state_local=2'b00;//2-bit number state allows one to access and modify the properties corresponding to one of the four positions

      wire newclk;//new_clk is the MSB of seg_clk

      //instantiating decoder modules to obtain the values of s1, s2, s3, s4
      decoder d1( score_digit_o,s1);
      decoder d2( score_digit_t,s2);
      decoder d3( max_score_digit_o,s3);
      decoder d4( max_score_digit_t,s4);

      assign newclk = seg_clk[12]; 

      always@(posedge clk) //always block: sensitivity list has positive edge of the clock signal
          seg_clk=seg_clk+1; //incrementing seg_clk in each clock cycle

      always@( posedge newclk )begin//always block: sensitivity list has new_clk (MSB of clock divider, [12:0] seg_clk)

          case(state_local)//case statement using state_local

          2'b00: begin
          seg<=s1;//assign s1(output of instantiation d1) to [6:0] seg
          an<=4'b1011;//choose the correct position: midleft (units digit of score)
          state_dummy=2'b01;//set next state to 01
          end

          2'b01: begin
          seg<=s2;//assign s2(output of instantiation d2) to [6:0] seg
          an<=4'b0111;//choose the correct position: left (tens digit of score)
          state_dummy=2'b10;//set next state to 10
          end

          2'b10: begin
          seg<=s3;//assign s3(output of instantiation d3) to [6:0] seg
          an<=4'b1110;//choose the correct position: right (units digit of max_score)
          state_dummy=2'b11;//set next state to 11
          end

          2'b11: begin
          seg<=s4;//assign s4(output of instantiation d4) to [6:0] seg
          an<=4'b1101;//choose the correct position: midright (tens digit of max_score)
          state_dummy=2'b00;//set next state to 00
          end

          default: begin//default: same as case 00
          seg<=s1;
          an<=4'b1011;//midleft
          state_dummy=2'b01;
          end
          endcase

          state_local = state_dummy;//assign state_dummy to state_local

      end

endmodule


module decoder(digit_bcd, seg_l);
    //This module converts a 4-bit BCD number to 7-bit number that represents the segments that are to be lit up to display that digit (abcdefg)
    input [3:0] digit_bcd;
    output reg [6:0] seg_l;
    
    always@( digit_bcd) begin
    
        case(digit_bcd)
            4'b0000: seg_l <= 7'b1000000;  //0 
            4'b0001: seg_l <= 7'b1111001;  //1
            4'b0010: seg_l <= 7'b0100100;  //2
            4'b0011: seg_l <= 7'b0110000;  //3
            4'b0100: seg_l <= 7'b0011001;  //4
            4'b0101: seg_l <= 7'b0010010;  //5
            4'b0110: seg_l <= 7'b0000010;  //6
            4'b0111: seg_l <= 7'b1111000;  //7
            4'b1000: seg_l <= 7'b0000000;  //8
            4'b1001: seg_l <= 7'b0010000;  //9
            default: seg_l <= 7'b1000000;  //default = 0
        endcase 
    
 end

endmodule
