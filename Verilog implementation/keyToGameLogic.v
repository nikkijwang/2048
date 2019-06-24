`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2018 10:39:27 AM
// Design Name: 
// Module Name: keyToGameLogic
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


module keyToGameLogic(
    input clk,
    input reset,
    input ps2c, ps2d,
    input gameReset,
    output wire [11:0] cr00, cr01, cr02, cr03, cr10, cr11, cr12, cr13, cr20, cr21, cr22, cr23, cr30, cr31, cr32, cr33,
    output gameOver,
    output gameWon
    );
    
    //---------- Internal Variables ----------//
    reg openSpace, openSpaceNext;
    reg [3:0] addrRow, addrRowNext, addrCol, addrColNext;
    wire [1:0] xCoor, yCoor;
    wire rndNumSel;
    wire [11:0] rndNum;
    //wire [11:0] dataIn;
    wire doneTick;
    wire [7:0] dout;
    reg [4:0] stateReg, stateNext;
    reg [1:0] iReg, iNext, jReg, jNext, kReg, kNext;
    reg loop, loopNext;
    wire [11:0] init [0:3][0:3];
    reg [11:0] mem [0:3][0:3];
    reg [11:0] memNext [0:3][0:3];
    reg blkGen, blkGenNext;
    reg gameWonReg, gameWonNext;
    reg gameOverReg, gameOverNext;
    
    //---------- Constant Declarations ----------//
    localparam W  = 8'h1D,
               A  = 8'h15,
               S  = 8'h1B,
               D  = 8'h23,
               F0 = 8'hF0;
               
    //---------- State Declarations -----------//
    localparam IDLE      = 5'd0,
               UP        = 5'd1,
               LEFT      = 5'd2,
               DOWN      = 5'd3,
               RIGHT     = 5'd4,
               REL_W     = 5'd5,
               REL_A     = 5'd6,
               REL_S     = 5'd7,
               REL_D     = 5'd8,
               SLIDE_U   = 5'd9,
               SLIDE_L   = 5'd10,
               SLIDE_D   = 5'd11,
               SLIDE_R   = 5'd12,
               CALC_W    = 5'd13,
               CALC_A    = 5'd14,
               CALC_S    = 5'd15,
               CALC_D    = 5'd16,
               CHECK_WIN = 5'd17,
               CHECK_GO  = 5'd18,
               GENBLK    = 5'd19;

    ps2_rx kInput(.clk(clk), .reset(reset), .ps2d(ps2d), .ps2c(ps2c), .rx_en(1'b1), .rx_done_tick(doneTick), .dout(dout));
    
    LFSR randGen(.clk(clk), .xCoor(xCoor), .yCoor(yCoor), .rndNum(rndNumSel));
    assign rndNum = (rndNumSel) ? 4 : 2;  
                 
//    gameMem gameMemory(.clk(clk), .wr(wr), .addrCol(addrCol), .addrRow(addrRow), .dataIn(dataIn),
//                       .cr00(cr00), .cr01(cr01), .cr02(cr02), .cr03(cr03),
//                       .cr10(cr10), .cr11(cr11), .cr12(cr12), .cr13(cr13),
//                       .cr20(cr20), .cr21(cr21), .cr22(cr22), .cr23(cr23),
//                       .cr30(cr30), .cr31(cr31), .cr32(cr32), .cr33(cr33));                 
    gameMem gameMemory(.clk(clk),
                       .cr00(init[0][0]), .cr01(init[0][1]), .cr02(init[0][2]), .cr03(init[0][3]),
                       .cr10(init[1][0]), .cr11(init[1][1]), .cr12(init[1][2]), .cr13(init[1][3]),
                       .cr20(init[2][0]), .cr21(init[2][1]), .cr22(init[2][2]), .cr23(init[2][3]),
                       .cr30(init[3][0]), .cr31(init[3][1]), .cr32(init[3][2]), .cr33(init[3][3]));

    always @(posedge clk, posedge reset, posedge gameReset)
        begin
            if (reset)
                begin: sys_reset
                    stateReg <= IDLE;
                    kReg <= 0;
                    iReg <= 0;
                    jReg <= 0;
                    openSpace <= 0;
                    addrRow <= 0;
                    addrCol <= 0;
                    loop <= 0;
                    mem[0][0] <= init[0][0];
                    mem[0][1] <= init[0][1];
                    mem[0][2] <= init[0][2];
                    mem[0][3] <= init[0][3];
                    mem[1][0] <= init[1][0];
                    mem[1][1] <= init[1][1];
                    mem[1][2] <= init[1][2];
                    mem[1][3] <= init[1][3];
                    mem[2][0] <= init[2][0];
                    mem[2][1] <= init[2][1];
                    mem[2][2] <= init[2][2];
                    mem[2][3] <= init[2][3];
                    mem[3][0] <= init[3][0];
                    mem[3][1] <= init[3][1];
                    mem[3][2] <= init[3][2];
                    mem[3][3] <= init[3][3];
                    gameWonReg <= 0;
                    gameOverReg <= 0;
                    blkGen <= 0;
                end
            else if (gameReset)
                begin: game_reset
                    stateReg <= IDLE;
                    kReg <= 0;
                    iReg <= 0;
                    jReg <= 0;
                    openSpace <= 0;
                    addrRow <= 0;
                    addrCol <= 0;
                    loop <= 0;
                    mem[0][0] <= init[0][0];
                    mem[0][1] <= init[0][1];
                    mem[0][2] <= init[0][2];
                    mem[0][3] <= init[0][3];
                    mem[1][0] <= init[1][0];
                    mem[1][1] <= init[1][1];
                    mem[1][2] <= init[1][2];
                    mem[1][3] <= init[1][3];
                    mem[2][0] <= init[2][0];
                    mem[2][1] <= init[2][1];
                    mem[2][2] <= init[2][2];
                    mem[2][3] <= init[2][3];
                    mem[3][0] <= init[3][0];
                    mem[3][1] <= init[3][1];
                    mem[3][2] <= init[3][2];
                    mem[3][3] <= init[3][3];
                    gameWonReg <= 0;
                    gameOverReg <= 0;
                    blkGen <= 0;
                end
            else
                begin
                    stateReg <= stateNext;
                    kReg <= kNext;
                    iReg <= iNext;
                    jReg <= jNext;
                    openSpace <= openSpaceNext;
                    addrRow <= addrRowNext;
                    addrCol <= addrColNext;
                    loop <= loopNext;
                    mem[0][0] <= memNext[0][0];
                    mem[0][1] <= memNext[0][1];
                    mem[0][2] <= memNext[0][2];
                    mem[0][3] <= memNext[0][3];
                    mem[1][0] <= memNext[1][0];
                    mem[1][1] <= memNext[1][1];
                    mem[1][2] <= memNext[1][2];
                    mem[1][3] <= memNext[1][3];
                    mem[2][0] <= memNext[2][0];
                    mem[2][1] <= memNext[2][1];
                    mem[2][2] <= memNext[2][2];
                    mem[2][3] <= memNext[2][3];
                    mem[3][0] <= memNext[3][0];
                    mem[3][1] <= memNext[3][1];
                    mem[3][2] <= memNext[3][2];
                    mem[3][3] <= memNext[3][3];
                    gameWonReg <= gameWonNext;
                    gameOverReg <= gameOverNext;
                    blkGen <= blkGenNext;
                end
        end
    
    always @*
        begin
            stateNext = stateReg;
            iNext = iReg;
            jNext = jReg;
            kNext = kReg;
            openSpaceNext = openSpace;
            addrRowNext = addrRow;
            addrColNext = addrCol;
            loopNext = loop;
            memNext[0][0] = mem[0][0];
            memNext[0][1] = mem[0][1];
            memNext[0][2] = mem[0][2];
            memNext[0][3] = mem[0][3];
            memNext[1][0] = mem[1][0];
            memNext[1][1] = mem[1][1];
            memNext[1][2] = mem[1][2];
            memNext[1][3] = mem[1][3];
            memNext[2][0] = mem[2][0];
            memNext[2][1] = mem[2][1];
            memNext[2][2] = mem[2][2];
            memNext[2][3] = mem[2][3];
            memNext[3][0] = mem[3][0];
            memNext[3][1] = mem[3][1];
            memNext[3][2] = mem[3][2];
            memNext[3][3] = mem[3][3];
            gameWonNext = gameWonReg;
            gameOverNext = gameOverReg;
            case (stateReg)
                IDLE:   begin
                            if (doneTick)
                                begin: read_scan_data
                                if (dout == W)
                                    stateNext = UP;
                                else if (dout == A)
                                    stateNext = LEFT;
                                else if (dout == S)
                                    stateNext = DOWN;
                                else if (dout == D)
                                    stateNext = RIGHT;
                                end
                        end
                UP:     begin
                            if (doneTick)
                                begin
                                if (dout == F0)
                                    stateNext = REL_W;
                                end
                        end
                LEFT:   begin
                            if (doneTick)
                                begin
                                if (dout == F0)
                                    stateNext = REL_A;
                                end
                        end
                DOWN:   begin
                            if (doneTick)
                                begin
                                if (dout == F0)
                                    stateNext = REL_S;
                                end
                        end
                RIGHT:  begin
                            if (doneTick)
                                begin
                                if (dout == F0)
                                    stateNext = REL_D;
                                end
                        end
                REL_W:  begin
                            if (doneTick)
                                begin
                                if (dout == W)
                                    stateNext = SLIDE_U;
                                    iNext = 0;
                                    jNext = 0;
                                    kNext = 0;
                                    openSpaceNext = 0;
                                    loopNext = 0;
                                end
                        end
                REL_A:  begin
                            if (doneTick)
                                begin
                                if (dout == A)
                                    stateNext = SLIDE_L;
                                    iNext = 0;
                                    jNext = 0;
                                    openSpaceNext = 0;
                                end
                        end
                REL_S:  begin
                            if (doneTick)
                                begin
                                if (dout == S)
                                    stateNext = SLIDE_D;
                                    iNext = 0;
                                    jNext = 3;
                                    kNext = 2;
                                    openSpaceNext = 0;
                                end
                        end
                REL_D:  begin
                            if (doneTick)
                                begin
                                if (dout == D)
                                    stateNext = SLIDE_R;
                                    iNext = 3;
                                    jNext = 0;
                                end
                        end
                SLIDE_U:    begin
                                if ((iReg == 3) && (jReg == 3))
                                    begin
                                        stateNext = CALC_W;
                                        iNext = 0;
                                        jNext = 0;
                                        loopNext = 0;
                                        kNext = 0;
                                    end
                                else if (jReg == 3)
                                    begin
                                        iNext = iReg + 1;
                                        jNext = 0;
                                        openSpaceNext = 0;
                                    end
                                else
                                    jNext = jReg + 1;
                                    
                                if (mem[iReg][jReg] == 0 && !openSpace)
                                    begin
                                        openSpaceNext = 1;
                                        addrRowNext = jReg;
                                    end
                                else if (mem[iReg][jReg] != 0 && openSpace)
                                    begin
                                        memNext[iReg][addrRow] = mem[iReg][jReg];
                                        addrRowNext = addrRow + 1;
                                        memNext[iReg][jReg] = 0;
                                    end
                            end
                SLIDE_L:    begin
                                if ((iReg == 3) && (jReg == 3))
                                    begin
                                        stateNext = CALC_A;
                                        iNext = 0;
                                        jNext = 0;
                                        kNext = 0;
                                    end
                                else if (iReg == 3)
                                    begin
                                        jNext = jReg + 1;
                                        iNext = 0;
                                        openSpaceNext = 0;
                                    end
                                else
                                    iNext = iReg + 1;
                                    
                                if (mem[iReg][jReg] == 0 && !openSpace)
                                    begin
                                        openSpaceNext = 1;
                                        addrColNext = iReg;
                                    end
                                else if (mem[iReg][jReg] != 0 && openSpace)
                                    begin
                                        memNext[addrCol][jReg] = mem[iReg][jReg];
                                        addrColNext = addrCol + 1;
                                        memNext[iReg][jReg] = 0;
                                    end
                            end
                SLIDE_D:    begin
                                if ((iReg == 3) && (jReg == 0))
                                    begin
                                        stateNext = CALC_S;
                                        iNext = 0;
                                        jNext = 0;
                                        kNext = 1;
                                    end
                                else if (jReg == 0)
                                    begin
                                        iNext = iReg + 1;
                                        jNext = 3;
                                        openSpaceNext = 0;
                                    end
                                else
                                    jNext = jNext - 1;
                                    
                                if (mem[iReg][jReg] == 0 && !openSpace)
                                    begin
                                        addrRowNext = jReg;
                                        openSpaceNext = 1;
                                    end
                                else if (mem[iReg][jReg] != 0 && openSpace)
                                    begin
                                        memNext[iReg][addrRow] = mem[iReg][jReg];
                                        addrRowNext = addrRow - 1;
                                        memNext[iReg][jReg] = 0;
                                    end
                            end
                SLIDE_R:    begin
                                if ((jReg == 3) && (iReg == 0))
                                    begin
                                        stateNext = CALC_D;
                                        iNext = 0;
                                        jNext = 0;
                                        kNext = 1;
                                    end
                                else if (iReg == 0)
                                    begin
                                        jNext = jReg + 1;
                                        iNext = 3;
                                        openSpaceNext = 0;
                                    end
                                else
                                    iNext = iReg - 1;
                                    
                                if (mem[iReg][jReg] == 0 && !openSpace)
                                    begin
                                        if (mem[iReg][jReg] == 0 && !openSpace)
                                            begin
                                                addrColNext = iReg;
                                                openSpaceNext = 1;
                                            end
                                    end
                                else if (mem[iReg][jReg] != 0 && openSpace)
                                    begin
                                        memNext[addrCol][jReg] = mem[iReg][jReg];
                                        addrColNext = addrCol - 1;
                                        memNext[iReg][jReg] = 0;
                                     end
                            end      
                CALC_W: begin
                /*
                for (i = 0; i < col; i++)
                {
                    for (j = 0; j < row - 1; j++)
                    {
                        
                        // Current and next number are the same
                        if (x[i][j] == x[i][j+1])
                        {
                            x[i][j] *= 2;        // Increase the current number
                            x[i][j+1] = 0;        // Clear the next number
                            
                            // Shift the numbers
                            for (a = j + 1; a < row - 1; a++)
                            {
                                x[i][a] = x[i][a+1];
                                x[i][a+1] = 0;
                            }
                        }
                    }
                }*/
                            if ((iReg == 3) && (jReg == 2) && (kReg == 2))
                                begin
                                    stateNext = GENBLK;
                                    iNext = 0;
                                    jNext = 0;
                                    loopNext = 0;
                                end
                            else if ((jReg == 2) && (kReg == 2))
                                begin
                                    iNext = iReg + 1;
                                    jNext = 0;
                                    loopNext = 0;
                                end
                            else if (kReg == 2)
                                begin
                                    jNext = jReg + 1;
                                    loopNext = 0;
                                end
                            else
                                kNext = kReg + 1;
                                
                            if (!loop)
                                begin
                                    if (mem[iReg][jReg] == mem[iReg][jReg + 1])
                                        begin
                                            memNext[iReg][jReg] = mem[iReg][jReg] << 1;
                                            memNext[iReg][jReg + 1] = 0;
                                            kNext = jReg + 1;
                                            loopNext = 1;
                                        end
                                end
                            else
                                begin
                                    memNext[iReg][kReg] = mem[iReg][kReg + 1];
                                    memNext[iReg][kReg + 1] = 0;
                                end
                        end
                CALC_A: begin
                            if ((jReg == 3) && (iReg == 2) && (kReg == 2))
                                begin
                                    stateNext = GENBLK;
                                    iNext = 0;
                                    jNext = 0;
                                    kNext = 2;
                                end
                            else if ((iReg == 2) && (kReg == 2))
                                begin
                                    jNext = jReg + 1;
                                    iNext = 0;
                                    kNext = 2;
                                end
                            else if (kReg == 2)
                                begin
                                    jNext = jReg + 1;
                                    kNext = 2;
                                end
                            else
                                kNext = kReg + 1;
                                
                            if (kReg == 2)
                                begin
                                    if (mem[iReg][jReg] == mem[iReg + 1][jReg])
                                        begin
                                            memNext[iReg][jReg] = mem[iReg][jReg] << 1;
                                            memNext[iReg + 1][jReg] = 0;
                                            kNext = iReg + 1;
                                        end
                                end
                            else
                                begin
                                    memNext[kReg][jReg] = mem[kReg + 1][jReg];
                                    memNext[kReg+1][jReg] = 0;
                                end
                            end
                CALC_S: begin
                            if ((iReg == 3) && (jReg == 0) && (kReg == 1))
                                begin
                                    stateNext = GENBLK;
                                    iNext = 0;
                                    jNext = 0;
                                    kNext = 0;
                                end
                            else if ((jReg == 0) && (kReg == 1))
                                begin
                                    iNext = iReg + 1;
                                    jNext = 3;
                                    kNext = 2;
                                end
                            else
                                kNext = kReg - 1;
                                
                            if (kReg == 1)
                                begin
                                    if (mem[iReg][jReg] == mem[iReg][jReg - 1])
                                        begin
                                            memNext[iReg][jReg] = mem[iReg][jReg] << 1;
                                            memNext[iReg][jReg-1] = 0;
                                        end
                                end
                            else
                                begin
                                    memNext[iReg][kReg] = mem[iReg][kReg-1];
                                    memNext[iReg][kReg-1] = 0;
                                end
                        end
                CALC_D: begin
                            if ((jReg == 3) && (iReg == 1) && (kReg == 1))
                                begin
                                    stateNext = GENBLK;
                                    iNext = 0;
                                    jNext = 0;
                                    kNext = 1;
                                end
                            else if ((iReg == 1) && (kReg == 1))
                                begin
                                    jNext = jReg + 1;
                                    iNext = 3;
                                    kNext = 2;
                                end
                            else
                                kNext = kReg - 1;
                                
                            if (kReg == 2)
                                begin
                                    if (mem[iReg][jReg] == mem[iReg - 1][jReg])
                                        begin
                                            memNext[iReg][jReg] = mem[iReg][jReg] << 1;
                                            memNext[iReg - 1][jReg] = 0;
                                        end
                                end
                            else
                                begin
                                    memNext[kReg][jReg] = mem[kReg-1][jReg];
                                    memNext[kReg-1][jReg] = 0;
                                end
                        end        
                CHECK_WIN:  begin
                                if((iReg == 3) && (jReg == 3))
                                    begin
                                        stateNext = CHECK_GO;
                                        iNext = 0;
                                        jNext = 0;
                                    end
                                else if (jReg == 3)
                                    begin
                                        iNext = iReg + 1;
                                        jNext = 0;
                                    end
                                else
                                    jNext = jReg + 1;
                                    
                                if (mem[iReg][jReg] == 2048)
                                    begin
                                        gameWonNext = 1;
                                        stateNext = IDLE;
                                    end
                                else
                                    gameWonNext = 0;
                            end
                CHECK_GO:   begin
                                if ((iReg == 3) && (jReg == 3) && (mem[iReg][jReg] != 0))
                                    begin
                                        stateNext = IDLE;
                                        gameOverNext = 1;
                                        iNext = 0;
                                        jNext = 0;
                                    end
                                else if (jReg == 3)
                                    begin
                                        iNext = iReg + 1;
                                        jNext = 0;
                                    end
                                else
                                    jNext = jReg + 1;
                                    
                                if (mem[iReg][jReg] == 0)
                                    begin
                                        stateNext = GENBLK;
                                    end
                            end
                GENBLK: begin
                            if(mem[xCoor][yCoor] == 0)
                                begin
                                    memNext[xCoor][yCoor] = rndNum;
                                    stateNext = IDLE;
                                end
                        end
            endcase
        end
        
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
