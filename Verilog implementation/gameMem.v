`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2018 10:09:46 AM
// Design Name: 
// Module Name: gameMem
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


module gameMem(
    clk,
    //wr,
    //addrCol,
    //addrRow,
    //dataIn,
    cr00, cr01, cr02, cr03, cr10, cr11, cr12, cr13, cr20, cr21, cr22, cr23, cr30, cr31, cr32, cr33
    );
    
    parameter DATA_W = 12;
    parameter ADDR_W = 4;
    parameter ROW = 4;
    parameter COL = 4;
    
    //---------- Input Ports ----------//
    input clk;
    //input wr;
    //input [ADDR_W-1:0] addrCol, addrRow;
    //input [DATA_W-1:0] dataIn;
    
    //---------- Output Ports ----------//
    output wire [DATA_W-1:0] cr00, cr01, cr02, cr03, cr10, cr11, cr12, cr13, cr20, cr21, cr22, cr23, cr30, cr31, cr32, cr33;
    
    //---------- Internal Variables ----------//
    reg [DATA_W-1:0] mem [0:COL-1][0:ROW-1];
    reg [31:0] data;
    reg [1:0] initCount;
    reg [2:0] rndNum;
    reg doneInit;
    wire [1:0] xCoor, yCoor;
    wire rndNumSel;
    reg [2:0] i, j;
    
    LFSR rndGen(.clk(clk), .xCoor(xCoor), .yCoor(yCoor), .rndNum(rndNumSel));
    
    // Memory Initialization
//    initial begin: COL_SEL
//    for (i = 0; i < COL; i = i + 1)
//        begin: ROW_SEL
//            for (j = 0; j < ROW; j = j + 1)
//                begin: MEM_INIT
//                    mem[i][j] = 0;
//                end
//        end
//    end
    initial begin: init_reg
        initCount = 0;
        doneInit = 0;
        i = 0;
        j = 0;
    end
    
    // Game Initializations
    always @(posedge clk)
        begin: INIT_MEM
            if (doneInit == 0)
                begin: COL_SEL
                    if (i  < COL)
                        begin: ROW_SEL
                            if (j < ROW)
                                begin
                                    mem[i][j] = 0;
                                    j = j + 1;
                                end
                            else
                                begin
                                    mem[i][j] = 0;
                                    j = 0;
                                    i = i + 1;
                                end
                        end
                    else
                        begin doneInit = 1; end
                end
            else 
                begin 
                    if (initCount < 2)
                        begin: BLK_GEN
                            //#5  // wait 5 ns
                            // Data generation
                            if (rndNumSel == 0)
                                rndNum = 2;
                            else
                                rndNum = 4;
                            // Coordinate generation
                            if (mem[xCoor][yCoor] == 0)
                                begin
                                    mem[xCoor][yCoor] = rndNum;
                                    initCount = initCount + 1;
                                end
                        end
                    end
//            else if (wr)
//                begin: WRITE_OP
//                    mem[addrCol][addrRow] = dataIn;
//                end
        end
    
    // Write Block
    // Write Operation:
//    always @(posedge clk)
//        begin: MEM_WRITE
//            if (wr)
//                begin
//                    mem[addrCol][addrRow] = dataIn;
//                end
//            end
            
    assign cr00 = mem[0][0];
    assign cr01 = mem[0][1];
    assign cr02 = mem[0][2];
    assign cr03 = mem[0][3];
    assign cr10 = mem[1][0];
    assign cr11 = mem[1][1];
    assign cr12 = mem[1][2];
    assign cr13 = mem[1][3];
    assign cr20 = mem[2][0];
    assign cr21 = mem[2][1];
    assign cr22 = mem[2][2];
    assign cr23 = mem[2][3];
    assign cr30 = mem[3][0];
    assign cr31 = mem[3][1];
    assign cr32 = mem[3][2];
    assign cr33 = mem[3][3];
    
endmodule
