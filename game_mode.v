`timescale 1ns / 1ps


module game_mode( game_mode1_button_local , game_mode2_button_local ,game_mode1,game_mode2,clk);
    // similiar to rst, we are also doing the same to avoid debouncing of our inputs
    // game_mode1 stores if mode 1 is to be played 
    // game_mode2 stores if mode2 is to be played
    // It is assumed  that player does not press both game mode to avoid confusion which game mode we have to play
    output reg game_mode1;
    output reg game_mode2;
    input game_mode1_button_local , game_mode2_button_local , clk;
    
    always@ ( posedge clk) begin
    
        if( game_mode1_button_local==1)
            game_mode1=1;
        else
            game_mode1=0;
        
        if( game_mode2_button_local==1)
            game_mode2=1;
        else
            game_mode2=0;
    end
endmodule
