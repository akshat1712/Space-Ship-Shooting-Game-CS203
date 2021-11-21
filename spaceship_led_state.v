module spaceship_LED_state(mode1, mode2, out_state, clk, rst,led_local);
      input clk, rst, mode1, mode2;
      output [3:0] out_state;
      output reg[ 15:0] led_local;
      
      reg [ 3:0 ] reg_state;      
      reg [31:0] counter;
      integer i;
      integer stay1=1,stay2=0;
      
      reg [8:0] ran;
      integer select;
      
      always @ (posedge clk ) begin
      
            if( mode1==1'b1) begin
                stay1=1;
                stay2=0;
            end
            
            if( mode2==1'b1) begin
                stay1=0;
                stay2=1;
            end
            
            if(stay1==1'b1)begin
                  stay1=1;
                  stay2=0;
                  if(rst==1'b1) begin
                      reg_state=4'b0010;
                      counter=0;
                  end  
                   else if( counter==32'd50000000 ) begin
                        if( out_state==4'b1110)
                            reg_state=4'b0010;
                        else
                            reg_state=reg_state+2;
                        counter=0;
                   end  
                   else
                        counter=counter+1; 
            end

            else begin
                  stay2=1;
                  stay1=0;
                  if( counter==32'd50000000 ) begin 
                        if( select==0) begin 
                              ran=ran+23;
                              select=1;
                        end
                        else if( select==1) begin
                              ran=ran+11;
                              select=2;
                        end
                        else if( select==2) begin
                              ran=ran+17;
                              select=3;
                        end
                        else begin
                              ran=ran+41;
                              select=0;
                        end

                        reg_state= ran%14 +2;  
                        counter=0;
                  end
                  else
                        counter=counter+1;
            end
            
            
            for( i=0;i<16;i=i+1) begin
                  if( i==reg_state-2 || i==reg_state-1 || i==reg_state) 
                        led_local[i]=1;
                  else
                        led_local[i]=0;
            end
      end      
      
      assign out_state=reg_state;
            

endmodule