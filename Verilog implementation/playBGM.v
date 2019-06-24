`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2018 03:50:51 AM
// Design Name: 
// Module Name: playBGM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module playBGM(
    input wire clk,
    input wire reset,
    input wire playSound,
    output reg audioOut,
    output reg audSd
    );
    
    reg [19:0] counter;
    reg [31:0] time1, noteTime;
    reg [9:0] msec, number;    //millisecond counter, and sequence number of musical note.
    wire [4:0] note, duration;
    wire [19:0] notePeriod;
    parameter clockFrequency = 100_000_000;    //50 MHz
    
    assign aud_sd = 1'b1;
    
    MusicSheet     mysong(number, notePeriod, duration);
    always @ (posedge clk) 
        begin
            if(reset | ~playSound) 
                begin 
                  counter <=0;  
                  time1<=0;  
                  number <=0;  
                  audioOut <=1;    
                end
            else 
                begin
                    counter <= counter + 1; 
                    time1<= time1+1;
                    if( counter >= notePeriod) 
                        begin
                            counter <=0;  
                            audioOut <= ~audioOut ; 
                        end    //toggle audio output     
                    if( time1 >= noteTime) 
                        begin    
                            time1 <=0;  
                            number <= number + 1; 
                        end  //play next note
                end
        end    
         
    always @(duration) noteTime = duration * clockFrequency / 16; 
endmodule
