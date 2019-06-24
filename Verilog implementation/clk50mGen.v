`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2018 12:04:57 PM
// Design Name: 
// Module Name: clk50mGen
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


module clk50mGen(
    input wire clk, reset,
    output reg outsignal
    );
    
    always @(posedge clk)
        begin: clock_generation
            if (reset)
                begin: reset
                    outsignal = 0;
                end
            else
                begin
                    outsignal = ~outsignal;
                end
        end
endmodule
