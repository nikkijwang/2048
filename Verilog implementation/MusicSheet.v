`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2018 03:46:19 AM
// Design Name: 
// Module Name: MusicSheet
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


module MusicSheet(
    input [9:0] number,
    output reg [19:0] note,
    output reg [4:0] duration
    );
    parameter  SIXTEENTH = 5'b00001;
    parameter  EIGHTH = 5'b00010;
    parameter  QUARTER = 5'b00100;//2 Hz
    parameter  HALF = 5'b01000;
    parameter  ONE = 2* HALF;
    parameter  TWO = 2* ONE;
    parameter  FOUR = 2* TWO;
    parameter G6 = 31888.162,
              F6 = 35793.287,
              E6B = 40176.455,
              D6 = 42565.508,
              C6 = 47778.309,
              B5B = 53629.195,
              G5 = 63776.242,
              F5 = 71586.471,
              E5B = 80353.039,
              D5 = 85131.017,
              C5 = 95556.435,
              B4B = 107258.39,
              A4 = 113636.36,
              G4 = 127552.65,
              F4 = 143172.94,
              E4 = 151686.14,
              SP = 1;
              
      always @(number)
      begin
        case (number)   // Dearly Beloved - Kingdom Hearts
        // MEASURE 1
        0: begin note = E6B; duration = QUARTER + EIGHTH; end
        1: begin note = SP; duration = QUARTER + EIGHTH; end
        2: begin note = E6B; duration = EIGHTH; end
        3: begin note = SP; duration = EIGHTH; end
        
        4: begin note = D6; duration = QUARTER + EIGHTH; end
        5: begin note = SP; duration = QUARTER + EIGHTH; end
        6: begin note = D6; duration = EIGHTH; end
        7: begin note = SP; duration = EIGHTH; end
        
        // MEASURE 2
        8: begin note = C6; duration = QUARTER + EIGHTH; end
        9: begin note = SP; duration = QUARTER + EIGHTH; end
        10: begin note = C6; duration = EIGHTH; end
        11: begin note = SP; duration = EIGHTH; end
        
        12: begin note = B5B; duration = QUARTER + EIGHTH; end
        13: begin note = SP; duration = QUARTER + EIGHTH; end
        14: begin note = B5B; duration = EIGHTH; end
        15: begin note = SP; duration = EIGHTH; end
        
        // MEASURE 3
        16: begin note = C6; duration = QUARTER + EIGHTH; end
        17: begin note = SP; duration = QUARTER + EIGHTH; end
        18: begin note = C6; duration = EIGHTH; end
        19: begin note = SP; duration = EIGHTH; end
        
        20: begin note = G5; duration = QUARTER + EIGHTH; end
        21: begin note = SP; duration = QUARTER + EIGHTH; end
        22: begin note = G5; duration = EIGHTH; end
        23: begin note = SP; duration = EIGHTH; end
        
        // MEASURE 4
        24: begin note = F5; duration = QUARTER + EIGHTH; end
        25: begin note = SP; duration = QUARTER + EIGHTH; end
        26: begin note = F5; duration = EIGHTH; end
        27: begin note = SP; duration = EIGHTH; end
        
        28: begin note = D6; duration = QUARTER + EIGHTH; end
        29: begin note = SP; duration = QUARTER + EIGHTH; end
        30: begin note = D6; duration = EIGHTH; end
        31: begin note = SP; duration = EIGHTH; end
        
        // MEASURE 5
        32: begin note = C6; duration = QUARTER + EIGHTH; end
        33: begin note = SP; duration = QUARTER + EIGHTH; end
        34: begin note = C6; duration = EIGHTH; end
        35: begin note = SP; duration = EIGHTH; end
        
        36: begin note = G5; duration = QUARTER + EIGHTH; end
        37: begin note = SP; duration = QUARTER + EIGHTH; end
        38: begin note = G5; duration = EIGHTH; end
        39: begin note = SP; duration = EIGHTH; end
        
        // MEASURE 6
        40: begin note = F5; duration = QUARTER + EIGHTH; end
        41: begin note = SP; duration = QUARTER + EIGHTH; end
        42: begin note = F5; duration = EIGHTH; end
        43: begin note = SP; duration = EIGHTH; end
        
        44: begin note = D6; duration = QUARTER + EIGHTH; end
        45: begin note = SP; duration = QUARTER + EIGHTH; end
        46: begin note = D6; duration = EIGHTH; end
        47: begin note = SP; duration = EIGHTH; end
        
        // MEASURE 7
        48: begin note = E6B; duration = QUARTER + EIGHTH; end
        49: begin note = SP; duration = QUARTER + EIGHTH; end
        50: begin note = E6B; duration = EIGHTH; end
        51: begin note = SP; duration = EIGHTH; end
        
        52: begin note = D6; duration = QUARTER + EIGHTH; end
        53: begin note = SP; duration = QUARTER + EIGHTH; end
        54: begin note = D6; duration = EIGHTH; end
        55: begin note = SP; duration = EIGHTH; end
        
        // MEASURE 8
        56: begin note = G6; duration = QUARTER + EIGHTH; end
        57: begin note = SP; duration = QUARTER + EIGHTH; end
        58: begin note = G6; duration = EIGHTH; end
        59: begin note = SP; duration = EIGHTH; end
        
        60: begin note = F6; duration = SIXTEENTH; end
        61: begin note = SP; duration = SIXTEENTH; end
        62: begin note = G6; duration = SIXTEENTH; end
        63: begin note = SP; duration = SIXTEENTH; end
        64: begin note = F6; duration = EIGHTH + QUARTER; end
        65: begin note = SP; duration = EIGHTH + QUARTER; end
        default: begin note = SP; duration = FOUR; end
        endcase
    end
endmodule
