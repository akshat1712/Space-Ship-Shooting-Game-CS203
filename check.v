module check(state, action_type, clk, buttons_local, press);
    input clk;//clock signal
    input [3:0] state;//4-bit number to indicate the position of the leftmost LED of the spaceship
    input [15:0] buttons_local;//16-bit variable to read the 16 switch values from the FPGA board
    output reg [1:0] action_type;//2-bit number to indicate whether the user has hit the spaceship or not
    //action_type:
    //00 indicates-> user missed the spaceship
    //01 indicates-> user hit the spaceship
    //10,11 indicate-> don't care values
    output reg [15:0] press = 16'b0000000000000000;//16-bit number, where each bit is a bool value of the corresponding switch on the FPGA board
    //[15:0] press ensures that any switch value can only be read 'high' once. To read the switch as 'high' again, the switch must first be set to 'low' and then 'high' again.

integer i=0;//loop variable
integer flag=0;//flag to chose which for loop to run

    always @(posedge clk) begin //always block: sensitivity list has positive edge of the clock signal.
    flag=0;//initialize flag to 0
    action_type=2'b10;//initializing action_type to don't care value
    //checking off leds
    for(i=0;i<16 && flag==0;i=i+1)begin
        if(i==state || i==state-1 || i==state-2)i=i;//do nothing at the spaceship's position
        else if(buttons_local[i]==1 && press[i]==0)begin    //Enter if any switch is 'high' at a position other than state, state-1 and state-2, for the first time.
            flag=1;//set flag=1, terminates the loop in the next iteration
            press[i]=1;//set press[i] to 'high'
            action_type=2'b00;//set action_type to misfire   
        end
    end
    
    //checking on leds
    if(flag==0)begin    //Enter only if no switch was detected 'high', in the previous loop.
        //Checking for positions: state, state-1, state-2
        if(buttons_local[state]==1 && press[state]==0)begin //Enter is switch at state is 'high' for the first time.
            press[state]=1;//set press[state] to 'high'
            action_type=2'b01;//set action_type to correct hit
        end
        
        if(buttons_local[state-1]==1 && press[state-1]==0)begin //Enter is switch at state-1 is 'high' for the first time.
            press[state-1]=1;//set press[state-1] to 'high'
            action_type=2'b01;//set action_type to correct hit
        end
        
        if(buttons_local[state-2]==1 && press[state-2]==0)begin //Enter is switch at state-2 is 'high' for the first time.
            press[state-2]=1;//set press[state-2] to 'high'
            action_type=2'b01;//set action_type to correct hit
        end
     end

    //If any switch reads 'low', make sure that press[switch] is set to 'low' again.
    for(i=0;i<16;i=i+1) begin
        if(buttons_local[i]==0 && press[i]==1) 
            press[i]=0;
    end

end

endmodule
