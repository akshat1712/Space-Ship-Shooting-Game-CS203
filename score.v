module score_module (action_type,score_local,max_score_local,clk,rst);
      input [1:0] action_type;
      input clk,rst;

      output reg [6:0] max_score_local;
      output reg [6:0] score_local;


      always @(posedge clk) begin
            
            if( rst==1'b1)  begin
                  score_local=7'b0000000;
            end
            else if( action_type ==2'b01) begin
                  if(score_local==max_score_local)
                      max_score_local=max_score_local+1;
                  score_local=score_local+1;
            end
            else if( action_type==2'b00) begin
                if( score_local>0)
                    score_local=score_local-1;
            end
            else begin
                  max_score_local=max_score_local;
                  score_local=score_local;
            end
      end
      
endmodule