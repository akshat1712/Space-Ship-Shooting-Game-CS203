module check(state, action_type, clk, buttons_local, press);
input clk;
input [3:0] state;
input [15:0] buttons_local;
output reg [1:0] action_type;
output reg [15:0] press = 16'b0000000000000000;

integer i=0;
integer flag=0;

always @(posedge clk) begin
    flag=0;
    action_type=2'b10;
    //checking off leds
    for(i=0;i<16 && flag==0;i=i+1)begin
        if(i==state || i==state-1 || i==state-2)i=i;
        else if(buttons_local[i]==1 && press[i]==0)begin
            flag=1;
            press[i]=1;
            action_type=2'b00;    
        end
    end
    
    //checking on leds
    if(flag==0)begin
        if(buttons_local[state]==1 && press[state]==0)begin
            press[state]=1;
            action_type=2'b01;
        end
        
        if(buttons_local[state-1]==1 && press[state-1]==0)begin
            press[state-1]=1;
            action_type=2'b01;
        end
        
        if(buttons_local[state-2]==1 && press[state-2]==0)begin
            press[state-2]=1;
            action_type=2'b01;
        end
     end

    for(i=0;i<16;i=i+1) begin
        if(buttons_local[i]==0 && press[i]==1) 
            press[i]=0;
    end

end

endmodule