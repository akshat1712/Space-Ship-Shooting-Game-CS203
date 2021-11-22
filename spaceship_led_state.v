module spaceship_LED_state(mode1, mode2, out_state, clk, rst,led_local);
      // spaceship led_state outputs the state of the Leds and lights up the necessary Leds depends on the state
      // we are always ligting up three consecutive LED
      // State is the Leftmost leds that is lit on the FPGA, by using this one parameter , we can tell which led to light up 
      // We have 2 game mode , one is a sequential one , in which leds will move from right to left at a jump of 2 leds
      // another one in which led will move in a pseudo-random order determined below by algorithm
      
      // led_local outputs the current_state of the leds
      
      input clk, rst, mode1, mode2;
      output [3:0] out_state;
      output reg[ 15:0] led_local;
      
      // reg_state stores the current state of leds in a register
      reg [ 3:0 ] reg_state;     
      
      // counter is used to slow down the Change of state of Leds , else we will see all led glow up as our eyes will not be able to work at the speed of the Clk
      // hence we have use 5x10^7 as one cycle meaning after these many cycle , state will change and human eyes can perceive these changes  
      reg [31:0] counter;
      // interger i for use in for loop
      integer i;
      
      // stay 1 and stay 2 will tells us which state we have to go , if mode1 and mode2 both are 0
      integer stay1=1,stay2=0;
      
      // ran and select is used in random_number generator 
      reg [31:0] ran;
      integer select;
      
      always @ (posedge clk ) begin
      
            // updating stay 1 and stay2 
            if( mode1==1'b1) begin
                stay1=1;
                stay2=0;
            end
            
            if( mode2==1'b1) begin
                stay1=0;
                stay2=1;
            end
            
            // if we have simple game mode
            // then increase reg_state  by 2 until it becomes 14 , which made it changes it to 2 again
            // we only do the above step if counter is 5x10^7
            if(stay1==1'b1)begin
                  stay1=1;
                  stay2=0;
            // if rst is 1 , then reset the state to 2
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
// if we are in random mode , then we add some prime number like 23,11,17,41 as prime number form a random distribution , 
 // then we take modulus with 14 to get from 0 to 13 , and then add 2 to make it a valid stat i.e 2 to 15
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
            
            // depending upon the state, we are ligting up the Leds
            for( i=0;i<16;i=i+1) begin
                  if( i==reg_state-2 || i==reg_state-1 || i==reg_state) 
                        led_local[i]=1;
                  else
                        led_local[i]=0;
            end
      end      
      // now are assigning reg_state to out_state for next iteration of this module.
      assign out_state=reg_state;
            

endmodule
