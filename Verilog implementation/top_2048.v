`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2018 02:06:13 PM
// Design Name: 
// Module Name: top_2048
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


module top_2048(
    input wire clk,
    input wire reset,
    input wire gameReset,
    input wire playSound,
    input wire ps2d, ps2c,
    output wire [11:0] rgb,
    output wire hsync, vsync,
    output wire audioOut,
    output wire audSd
    );
    
    // ---------- Internal Variables ----------
    // Keyboard input
    wire scanDoneTick;
    wire [7:0] scanData;
    // VGA screen
    wire clk50m;                // 50 MHz input clock
    wire videoOn, pixelTick;    // Outputs of VGA sync
    wire [9:0] pixX, pixY;      // Current pixel position
    reg [11:0] rgbReg;          // Current RGB settings
    wire [11:0] rgbNext;        // Next RGB settings
    wire [11:0] cr00, cr01, cr02, cr03,
                cr10, cr11, cr12, cr13,
                cr20, cr21, cr22, cr23,
                cr30, cr31, cr32, cr33;
    
    clk50mGen gen50mclk(.clk(clk), .reset(reset), .outsignal(clk50m));
    
    vga_sync vgaUnit(.clk(clk50m), .reset(reset), .hsync(hsync), .vsync(vsync), .video_on(videoOn), .p_tick(pixelTick),
                     .pixel_x(pixX), .pixel_y(pixY));

    keyToGameLogic gameLogic(.clk(clk), .reset(reset), .ps2c(ps2c), .ps2d(ps2d), .gameReset(gameReset),
                             .cr00(cr00), .cr01(cr01), .cr02(cr02), .cr03(cr03),
                             .cr10(cr10), .cr11(cr11), .cr12(cr12), .cr13(cr13),
                             .cr20(cr20), .cr21(cr21), .cr22(cr22), .cr23(cr23),
                             .cr30(cr30), .cr31(cr31), .cr32(cr32), .cr33(cr33),
                             .gameOver(gameOver), .gameWon(gameWon));
                             
    displayGame gameScreen(.clk(clk), .videoOn(videoOn), .pixX(pixX), .pixY(pixY),
                           .cr00(cr00), .cr01(cr01), .cr02(cr02), .cr03(cr03),
                           .cr10(cr10), .cr11(cr11), .cr12(cr12), .cr13(cr13),
                           .cr20(cr20), .cr21(cr21), .cr22(cr22), .cr23(cr23),
                           .cr30(cr30), .cr31(cr31), .cr32(cr32), .cr33(cr33),
                           .graphRGB(rgbNext));
                           
    playBGM bkgrndMusic(.clk(clk), .reset(reset), .playSound(playSound), .audioOut(audioOut), .audSd(audSd));
                           
    always @(posedge clk)
        begin
            if (pixelTick)
                rgbReg <= rgbNext;
        end
        
    assign rgb = rgbReg;
                           
endmodule