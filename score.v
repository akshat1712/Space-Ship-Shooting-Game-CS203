module score_module (action_type,score_local,max_score_local,clk,rst);
      // score module updates the score of the game that is to be displayed on the Seven Segment display of the FPGA
      // action_type getting from the check module
      input [1:0] action_type;
      input clk,rst;

      // scoring the score and max_score in a register locally in the score_module
      output reg [6:0] max_score_local;
      output reg [6:0] score_local;


      always @(posedge clk) begin
            // if rst is 1 , reset the score to 0
            if( rst==1'b1)  begin
                  score_local=7'b0000000;
            end
            // if we hit it correctly, then if current_score=max_score is true, update max_score, 
            // then update score_local always
            else if( action_type ==2'b01) begin
                  if(score_local==max_score_local)
                      max_score_local=max_score_local+1;
                  score_local=score_local+1;
            end
            // if user misses, then decrease score by 1 , if it is greater than 0
            else if( action_type==2'b00) begin
                if( score_local>0)
                    score_local=score_local-1;
            end
            // if we get a don't care case , just pass the previous value to this updation
            else begin
                  max_score_local=max_score_local;
                  score_local=score_local;
            end
      end
      
endmodule
