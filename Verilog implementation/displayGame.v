`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2018 12:01:55 PM
// Design Name: 
// Module Name: displayGame
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


module displayGame(
    input wire clk,
    input wire videoOn,
    input wire [9:0] pixX, pixY,
    input wire [11:0] cr00, cr01, cr02, cr03, cr10, cr11, cr12, cr13, cr20, cr21, cr22, cr23, cr30, cr31, cr32, cr33,
    output reg [11:0] graphRGB
    );
    
    // constant signal declarations
    //------------------------------------------------------
    // x, y coordinates (0,0) to (639, 479)
    //------------------------------------------------------
    localparam MAX_X = 640;
    localparam MAX_Y = 480;
    //------------------------------------------------------
    // screen refresh
    //------------------------------------------------------
    wire refr_tick;
    assign refr_tick = (pixY == MAX_Y + 1) && (pixX == 0);
    //------------------------------------------------------
    // title bar
    //------------------------------------------------------
    localparam TBAR_Y_T = 84;
    localparam TBAR_Y_B = 89;
    //------------------------------------------------------
    // title display
    //------------------------------------------------------
    localparam CHAR_L = 32;     // length
    localparam CHAR_H = 64;     // height
    localparam CHAR_Y_T = 10;
    localparam CHAR_Y_B = CHAR_Y_T + (CHAR_H - 1);
    // character 1: (
    localparam CHAR_X1_L = 64;
    localparam CHAR_X1_R = CHAR_X1_L + (CHAR_L - 1);
    // character 2: >
    localparam CHAR_X2_L = CHAR_X1_R + 1;
    localparam CHAR_X2_R = CHAR_X2_L + (CHAR_L - 1);
    // character 3: _
    localparam CHAR_X3_L = CHAR_X2_R + 1;
    localparam CHAR_X3_R = CHAR_X3_L + (CHAR_L - 1);
    // character 4: <
    localparam CHAR_X4_L = CHAR_X3_R + 1;
    localparam CHAR_X4_R = CHAR_X4_L + (CHAR_L - 1);
    // character 5: )
    localparam CHAR_X5_L = CHAR_X4_R + 1;
    localparam CHAR_X5_R = CHAR_X5_L + (CHAR_L - 1);
    // character 6: 
    localparam CHAR_X6_L = CHAR_X5_R + 1;
    localparam CHAR_X6_R = CHAR_X6_L + (CHAR_L - 1);
    // character 7: 2
    localparam CHAR_X7_L = CHAR_X6_R + 1;
    localparam CHAR_X7_R = CHAR_X7_L + (CHAR_L - 1);
    // character 8: 0
    localparam CHAR_X8_L = CHAR_X7_R + 1;
    localparam CHAR_X8_R = CHAR_X8_L + (CHAR_L - 1);
    // character 9: 4
    localparam CHAR_X9_L = CHAR_X8_R + 1;
    localparam CHAR_X9_R = CHAR_X9_L + (CHAR_L - 1);
    // character 10: 8
    localparam CHAR_X10_L = CHAR_X9_R + 1;
    localparam CHAR_X10_R = CHAR_X10_L + (CHAR_L - 1);
    // character 11: 
    localparam CHAR_X11_L = CHAR_X10_R + 1;
    localparam CHAR_X11_R = CHAR_X11_L + (CHAR_L - 1);
    // character 12: (
    localparam CHAR_X12_L = CHAR_X11_R + 1;
    localparam CHAR_X12_R = CHAR_X12_L + (CHAR_L - 1);
    // character 13: >
    localparam CHAR_X13_L = CHAR_X12_R + 1;
    localparam CHAR_X13_R = CHAR_X13_L + (CHAR_L - 1);
    // character 14: _
    localparam CHAR_X14_L = CHAR_X13_R + 1;
    localparam CHAR_X14_R = CHAR_X14_L + (CHAR_L - 1);
    // character 15: <
    localparam CHAR_X15_L = CHAR_X14_R + 1;
    localparam CHAR_X15_R = CHAR_X15_L + (CHAR_L - 1);
    // character 16: )
    localparam CHAR_X16_L = CHAR_X15_R + 1;
    localparam CHAR_X16_R = CHAR_X16_L + (CHAR_L - 1);
    //------------------------------------------------------
    // key instructions
    //------------------------------------------------------
    // KEYS
    localparam KEY_L = 8;
    localparam KEY_H = 16;
    localparam K_YT = 94;
    localparam K_YB = K_YT + KEY_H - 1;
    localparam K1_XL = 42;
    localparam K1_XR = K1_XL + KEY_L - 1;
    localparam K2_XL = K1_XR + 1;
    localparam K2_XR = K2_XL + KEY_L - 1;
    localparam K3_XL = K2_XR + 1;
    localparam K3_XR = K3_XL + KEY_L - 1;
    localparam K4_XL = K3_XR + 1;
    localparam K4_XR = K4_XL + KEY_L - 1;
    
    // W  SLIDE UP
    localparam W_YT = K_YB + 1;
    localparam W_YB = W_YT + KEY_H - 1;
    localparam W1_XL = 2;
    localparam W1_XR = W1_XL + KEY_L - 1;
    localparam W2_XL = W1_XR +1;
    localparam W2_XR = W2_XL + KEY_L - 1;
    localparam W3_XL = W2_XR + 1;
    localparam W3_XR = W3_XL + KEY_L - 1;
    localparam W4_XL = W3_XR + 1;
    localparam W4_XR = W4_XL + KEY_L - 1;
    localparam W5_XL = W4_XR + 1;
    localparam W5_XR = W5_XL + KEY_L - 1;
    localparam W6_XL = W5_XR + 1;
    localparam W6_XR = W6_XL + KEY_L - 1;
    localparam W7_XL = W6_XR + 1;
    localparam W7_XR = W7_XL + KEY_L - 1;
    localparam W8_XL = W7_XR + 1;
    localparam W8_XR = W8_XL + KEY_L - 1;
    localparam W9_XL = W8_XR + 1;
    localparam W9_XR = W9_XL + KEY_L - 1;
    localparam W10_XL = W9_XR + 1;
    localparam W10_XR = W10_XL + KEY_L - 1;
    localparam W11_XL = W10_XR + 1;
    localparam W11_XR = W11_XL + KEY_L - 1;
    
    // A  SLIDE LEFT
    localparam A_YT = W_YB + 1;
    localparam A_YB = A_YT + KEY_H - 1;
    localparam A1_XL = 2;
    localparam A1_XR = A1_XL + KEY_L - 1;
    localparam A2_XL = A1_XR +1;
    localparam A2_XR = A2_XL + KEY_L - 1;
    localparam A3_XL = A2_XR + 1;
    localparam A3_XR = A3_XL + KEY_L - 1;
    localparam A4_XL = A3_XR + 1;
    localparam A4_XR = A4_XL + KEY_L - 1;
    localparam A5_XL = A4_XR + 1;
    localparam A5_XR = A5_XL + KEY_L - 1;
    localparam A6_XL = A5_XR + 1;
    localparam A6_XR = A6_XL + KEY_L - 1;
    localparam A7_XL = A6_XR + 1;
    localparam A7_XR = A7_XL + KEY_L - 1;
    localparam A8_XL = A7_XR + 1;
    localparam A8_XR = A8_XL + KEY_L - 1;
    localparam A9_XL = A8_XR + 1;
    localparam A9_XR = A9_XL + KEY_L - 1;
    localparam A10_XL = A9_XR + 1;
    localparam A10_XR = A10_XL + KEY_L - 1;
    localparam A11_XL = A10_XR + 1;
    localparam A11_XR = A11_XL + KEY_L - 1;
    localparam A12_XL = A11_XR + 1;
    localparam A12_XR = A12_XL + KEY_L - 1;
    localparam A13_XL = A12_XR + 1;
    localparam A13_XR = A13_XL + KEY_L - 1;  
      
    // S  SLIDE DOWN
    localparam S_YT = A_YB + 1;
    localparam S_YB = S_YT + KEY_H - 1;
    localparam S1_XL = 2;
    localparam S1_XR = S1_XL + KEY_L - 1;
    localparam S2_XL = S1_XR + 1;
    localparam S2_XR = S2_XL + KEY_L - 1;
    localparam S3_XL = S2_XR + 1;
    localparam S3_XR = S3_XL + KEY_L - 1;
    localparam S4_XL = S3_XR + 1;
    localparam S4_XR = S4_XL + KEY_L - 1;
    localparam S5_XL = S4_XR + 1;
    localparam S5_XR = S5_XL + KEY_L - 1;
    localparam S6_XL = S5_XR + 1;
    localparam S6_XR = S6_XL + KEY_L - 1;
    localparam S7_XL = S6_XR + 1;
    localparam S7_XR = S7_XL + KEY_L - 1;
    localparam S8_XL = S7_XR + 1;
    localparam S8_XR = S8_XL + KEY_L - 1;
    localparam S9_XL = S8_XR + 1;
    localparam S9_XR = S9_XL + KEY_L - 1;
    localparam S10_XL = S9_XR + 1;
    localparam S10_XR = S10_XL + KEY_L - 1;
    localparam S11_XL = S10_XR + 1;
    localparam S11_XR = S11_XL + KEY_L - 1;
    localparam S12_XL = S11_XR + 1;
    localparam S12_XR = S12_XL + KEY_L - 1;
    localparam S13_XL = S12_XR + 1;
    localparam S13_XR = S13_XL + KEY_L - 1;  
      
    // D  SLIDE RIGHT
    localparam D_YT = S_YB + 1;
    localparam D_YB = D_YT + KEY_H - 1;
    localparam D1_XL = 2;
    localparam D1_XR = D1_XL + KEY_L - 1;
    localparam D2_XL = D1_XR + 1;
    localparam D2_XR = D2_XL + KEY_L - 1;
    localparam D3_XL = D2_XR + 1;
    localparam D3_XR = D3_XL + KEY_L - 1;
    localparam D4_XL = D3_XR + 1;
    localparam D4_XR = D4_XL + KEY_L - 1;
    localparam D5_XL = D4_XR + 1;
    localparam D5_XR = D5_XL + KEY_L - 1;
    localparam D6_XL = D5_XR + 1;
    localparam D6_XR = D6_XL + KEY_L - 1;
    localparam D7_XL = D6_XR + 1;
    localparam D7_XR = D7_XL + KEY_L - 1;
    localparam D8_XL = D7_XR + 1;
    localparam D8_XR = D8_XL + KEY_L - 1;
    localparam D9_XL = D8_XR + 1;
    localparam D9_XR = D9_XL + KEY_L - 1;
    localparam D10_XL = D9_XR + 1;
    localparam D10_XR = D10_XL + KEY_L - 1;
    localparam D11_XL = D10_XR + 1;
    localparam D11_XR = D11_XL + KEY_L - 1;
    localparam D12_XL = D11_XR + 1;
    localparam D12_XR = D12_XL + KEY_L - 1;
    localparam D13_XL = D12_XR + 1;
    localparam D13_XR = D13_XL + KEY_L - 1;
    localparam D14_XL = D13_XR + 1;
    localparam D14_XR = D14_XL + KEY_L - 1;
    //------------------------------------------------------
    // game box numbers
    //------------------------------------------------------
    localparam NUM_L = 16;
    localparam NUM_H = 32;
    //------------------------------------------------------
    // 4 x 4 grid box
    //------------------------------------------------------
    localparam GRID_W = 5;
    localparam GRID_L = ((NUM_L * 4 + 2) * 4) + (GRID_W * 5);
    localparam GRID_H = ((NUM_H + 4) * 4) + (GRID_W * 5);
    // grid length
    localparam GRID_X_L = 172;
    localparam GRID_X_R = GRID_X_L + (GRID_L - 1);
    // grid height
    localparam GRID_Y_T = 200;
    localparam GRID_Y_B = GRID_Y_T + (GRID_H - 1);
    // horizontal grid y-positions
    localparam GRID_H1_YT = GRID_Y_T;
    localparam GRID_H1_YB = GRID_H1_YT + (GRID_W);
    localparam GRID_H2_YT = GRID_H1_YB + (NUM_H + 4);
    localparam GRID_H2_YB = GRID_H2_YT + (GRID_W);
    localparam GRID_H3_YT = GRID_H2_YB + (NUM_H + 4);
    localparam GRID_H3_YB = GRID_H3_YT + (GRID_W);
    localparam GRID_H4_YT = GRID_H3_YB + (NUM_H + 4);
    localparam GRID_H4_YB = GRID_H4_YT + (GRID_W);
    localparam GRID_H5_YT = GRID_H4_YB + (NUM_H + 4);
    localparam GRID_H5_YB = GRID_H5_YT + (GRID_W);
    // vertical grid x-positions
    localparam GRID_V1_XL = GRID_X_L;
    localparam GRID_V1_XR = GRID_V1_XL + (GRID_W - 1);
    localparam GRID_V2_XL = GRID_V1_XR + (NUM_L * 4 + 4) - 1;
    localparam GRID_V2_XR = GRID_V2_XL + (GRID_W - 1);
    localparam GRID_V3_XL = GRID_V2_XR + (NUM_L * 4 + 4) - 1;
    localparam GRID_V3_XR = GRID_V3_XL + (GRID_W - 1);
    localparam GRID_V4_XL = GRID_V3_XR + (NUM_L * 4 + 4) - 1;
    localparam GRID_V4_XR = GRID_V4_XL + (GRID_W - 1);
    localparam GRID_V5_XL = GRID_V4_XR + (NUM_L * 4 + 4) - 1;
    localparam GRID_V5_XR = GRID_V5_XL + (GRID_W - 1);
    //------------------------------------------------------
    // game box boundaries
    //------------------------------------------------------
    localparam BOX_L = NUM_L * 4 + 2;
    localparam BOX_H = NUM_H + 4;
    // Column 0's left and right boundaries
    localparam BOX0Q_XL = GRID_X_L + GRID_W;
    localparam BOX0Q_XR = BOX0Q_XL + BOX_L;
    // Column 1's left and right boundaries
    localparam BOX1Q_XL = BOX0Q_XR + GRID_W;
    localparam BOX1Q_XR = BOX1Q_XL + BOX_L;
    // Column 2's left and right boundaries
    localparam BOX2Q_XL = BOX1Q_XR + GRID_W;
    localparam BOX2Q_XR = BOX2Q_XL + BOX_L;
    // Column 3's left and right boundaries
    localparam BOX3Q_XL = BOX2Q_XR + GRID_W;
    localparam BOX3Q_XR = BOX3Q_XL + BOX_L;
    // Row 0's top and bottom boundaries
    localparam BOXQ0_YT = GRID_Y_T + GRID_W;
    localparam BOXQ0_YB = BOXQ0_YT + BOX_H;
    // Row 1's top and bottom boundaries
    localparam BOXQ1_YT = BOXQ0_YB + GRID_W;
    localparam BOXQ1_YB = BOXQ1_YT + BOX_H;
    // Row 2's top and bottom boundaries
    localparam BOXQ2_YT = BOXQ1_YB + GRID_W;
    localparam BOXQ2_YB = BOXQ2_YT + BOX_H;
    // Row 3's top and bottom boundaries
    localparam BOXQ3_YT = BOXQ2_YB + GRID_W;
    localparam BOXQ3_YB = BOXQ3_YT + BOX_H;
    reg [11:0] data;
    wire [3:0] boxmap;
    //------------------------------------------------------
    // map area signals
    //------------------------------------------------------
    // ---------- title ----------
    wire t1on, t2on, t3on, t4on, t5on, t6on, t7on, t8on, t9on, t10on, t11on, t12on, t13on, t14on, t15on, t16on;
    wire t1map, t2map, t3map, t4map, t5map, t6map, t7map, t8map, t9map, t10map, t11map, t12map, t13map, t14map, t15map, t16map;
    // ---------- key instructions ----------
    // KEYS
    wire k1on, k2on, k3on, k4on, kon;
    wire k1map, k2map, k3map, k4map, kmap;
    // W  SLIDE UP
    wire w1on, w2on, w3on, w4on, w5on, w6on, w7on, w8on, w9on, w10on, w11on, won;
    wire w1map, w2map, w3map, w4map, w5map, w6map, w7map, w8map, w9map, w10map, w11map, wmap;
    // A  SLIDE LEFT
    wire a1on, a2on, a3on, a4on, a5on, a6on, a7on, a8on, a9on, a10on, a11on, a12on, a13on, aon;
    wire a1map, a2map, a3map, a4map, a5map, a6map, a7map, a8map, a9map, a10map, a11map, a12map, a13map, amap;
    // S  SLIDE DOWN
    wire s1on, s2on, s3on, s4on, s5on, s6on, s7on, s8on, s9on, s10on, s11on, s12on, s13on, son;
    wire s1map, s2map, s3map, s4map, s5map, s6map, s7map, s8map, s9map, s10map, s11map, s12map, s13map, smap;
    // D  SLIDE RIGHT
    wire d1on, d2on, d3on, d4on, d5on, d6on, d7on, d8on, d9on, d10on, d11on, d12on, d13on, d14on, don;
    wire d1map, d2map, d3map, d4map, d5map, d6map, d7map, d8map, d9map, d10map, d11map, d12map, d13map, d14map, dmap;
    // ---------- 4 x 4 grid ----------
    wire gridH1on, gridH2on, gridH3on, gridH4on, gridH5on, gridV1on, gridV2on, gridV3on, gridV4on, gridV5on;
    // ---------- game box display ----------
    wire box00on, box01on, box02on, box03on,
         box10on, box11on, box12on, box13on,
         box20on, box21on, box22on, box23on,
         box30on, box31on, box32on, box33on, boxOn;
    //------------------------------------------------------
    // bitmaps
    //------------------------------------------------------
    // ---------- title ----------
    wire [3:0] titleAddr;
    wire [2:0] t1col, t2col, t3col, t4col, t5col, t6col, t7col, t8col, t9col, t10col, t11col, t12col, t13col, t14col, t15col, t16col;
    wire t1bit, t2bit, t3bit, t4bit, t5bit, t6bit, t7bit, t8bit, t9bit, t10bit, t11bit, t12bit, t13bit, t14bit, t15bit, t16bit;
    reg [7:0] t1data, t2data, t3data, t4data, t5data, t6data, t7data, t8data, t9data, t10data, t11data, t12data, t13data, t14data,
              t15data, t16data;
    reg [7:0] sym_lp, sym_rp, sym_lt, sym_us, sym_gt, sp;
    // ---------- numbers ----------
    wire [3:0] num_addr;
    reg [7:0] num_0, num_1, num_2, num_3, num_4, num_5, num_6, num_7, num_8, num_9;
    
    // ---------- key instructions ----------
    wire [3:0] keyAddr, kAddr, wAddr, aAddr, sAddr, dAddr;
    reg [7:0] letK, letE, letY, letS, letW, letL, letI, letD, letU, letP, letA, letF, letT, letO, letN, letR, letG, letH;
    // KEYS
    wire [2:0] k1col, k2col, k3col, k4col;
    wire k1bit, k2bit, k3bit, k4bit;
    reg [7:0] k1data, k2data, k3data, k4data;
    // W SLIDE UP
    wire [2:0] w1col, w2col, w3col, w4col, w5col, w6col, w7col, w8col, w9col, w10col, w11col;
    wire w1bit, w2bit, w3bit, w4bit, w5bit, w6bit, w7bit, w8bit, w9bit, w10bit, w11bit;
    reg [7:0] w1data, w2data, w3data, w4data, w5data, w6data, w7data, w8data, w9data, w10data, w11data;
    // A  SLIDE LEFT
    wire [2:0] a1col, a2col, a3col, a4col, a5col, a6col, a7col, a8col, a9col, a10col, a11col, a12col, a13col;
    wire a1bit, a2bit, a3bit, a4bit, a5bit, a6bit, a7bit, a8bit, a9bit, a10bit, a11bit, a12bit, a13bit;
    reg [7:0] a1data, a2data, a3data, a4data, a5data, a6data, a7data, a8data, a9data, a10data, a11data, a12data, a13data;
    // S  SLIDE DOWN
    wire [2:0] s1col, s2col, s3col, s4col, s5col, s6col, s7col, s8col, s9col, s10col, s11col, s12col, s13col;
    wire s1bit, s2bit, s3bit, s4bit, s5bit, s6bit, s7bit, s8bit, s9bit, s10bit, s11bit, s12bit, s13bit;
    reg [7:0] s1data, s2data, s3data, s4data, s5data, s6data, s7data, s8data, s9data, s10data, s11data, s12data, s13data;
    // D  SLIDE RIGHT
    wire [2:0] d1col, d2col, d3col, d4col, d5col, d6col, d7col, d8col, d9col, d10col, d11col, d12col, d13col, d14col;
    wire d1bit, d2bit, d3bit, d4bit, d5bit, d6bit, d7bit, d8bit, d9bit, d10bit, d11bit, d12bit, d13bit, d14bit;
    reg [7:0] d1data, d2data, d3data, d4data, d5data, d6data, d7data, d8data, d9data, d10data, d11data, d12data, d13data, d14data;
    //------------------------------------------------------
    // object output signals
    //------------------------------------------------------
    wire titleOn, tbarOn, gridOn, keyInstrOn;
    reg [11:0] boxRGB;
    wire [11:0] titleRGB, gridRGB;
    wire [11:0] cr00rgb, cr01rgb, cr02rgb, cr03rgb, cr10rgb, cr11rgb, cr12rgb, cr13rgb,
                cr20rgb, cr21rgb, cr22rgb, cr23rgb, cr30rgb, cr31rgb, cr32rgb, cr33rgb;
    
    //------------------------------------------------------
    // title bitmap roms
    //------------------------------------------------------
    // symbol '('
    always @*
        case(titleAddr)
            4'h0: sym_lp = 8'b00000000; // 
            4'h1: sym_lp = 8'b00000000; // 
            4'h2: sym_lp = 8'b00001100; //     **
            4'h3: sym_lp = 8'b00011000; //    **
            4'h4: sym_lp = 8'b00110000; //   **
            4'h5: sym_lp = 8'b00110000; //   **
            4'h6: sym_lp = 8'b00110000; //   **
            4'h7: sym_lp = 8'b00110000; //   **
            4'h8: sym_lp = 8'b00110000; //   **
            4'h9: sym_lp = 8'b00110000; //   **
            4'ha: sym_lp = 8'b00011000; //    **
            4'hb: sym_lp = 8'b00001100; //     **
            4'hc: sym_lp = 8'b00000000; // 
            4'hd: sym_lp = 8'b00000000; // 
            4'he: sym_lp = 8'b00000000; // 
            4'hf: sym_lp = 8'b00000000; //
         endcase
     // symbol ')'
     always @*
        case (titleAddr)
            4'h0: sym_rp = 8'b00000000; // 
            4'h1: sym_rp = 8'b00000000; // 
            4'h2: sym_rp = 8'b00110000; //   **
            4'h3: sym_rp = 8'b00011000; //    **
            4'h4: sym_rp = 8'b00001100; //     **
            4'h5: sym_rp = 8'b00001100; //     **
            4'h6: sym_rp = 8'b00001100; //     **
            4'h7: sym_rp = 8'b00001100; //     **
            4'h8: sym_rp = 8'b00001100; //     **
            4'h9: sym_rp = 8'b00001100; //     **
            4'ha: sym_rp = 8'b00011000; //    **
            4'hb: sym_rp = 8'b00110000; //   **
            4'hc: sym_rp = 8'b00000000; // 
            4'hd: sym_rp = 8'b00000000; // 
            4'he: sym_rp = 8'b00000000; // 
            4'hf: sym_rp = 8'b00000000; // 
        endcase
    // symbol '>'
    always @*
        case (titleAddr)
            4'h0: sym_gt = 8'b00000000; // 
            4'h1: sym_gt = 8'b00000000; // 
            4'h2: sym_gt = 8'b00000000; // 
            4'h3: sym_gt = 8'b01100000; //  **
            4'h4: sym_gt = 8'b00110000; //   **
            4'h5: sym_gt = 8'b00011000; //    **
            4'h6: sym_gt = 8'b00001100; //     **
            4'h7: sym_gt = 8'b00000110; //      **
            4'h8: sym_gt = 8'b00001100; //     **
            4'h9: sym_gt = 8'b00011000; //    **
            4'ha: sym_gt = 8'b00110000; //   **
            4'hb: sym_gt = 8'b01100000; //  **
            4'hc: sym_gt = 8'b00000000; // 
            4'hd: sym_gt = 8'b00000000; // 
            4'he: sym_gt = 8'b00000000; // 
            4'hf: sym_gt = 8'b00000000; //
        endcase
    // symbol '<'
    always @*
        case (titleAddr)
            4'h0: sym_lt = 8'b00000000; // 
            4'h1: sym_lt = 8'b00000000; // 
            4'h2: sym_lt = 8'b00000000; // 
            4'h3: sym_lt = 8'b00000110; //      **
            4'h4: sym_lt = 8'b00001100; //     **
            4'h5: sym_lt = 8'b00011000; //    **
            4'h6: sym_lt = 8'b00110000; //   **
            4'h7: sym_lt = 8'b01100000; //  **
            4'h8: sym_lt = 8'b00110000; //   **
            4'h9: sym_lt = 8'b00011000; //    **
            4'ha: sym_lt = 8'b00001100; //     **
            4'hb: sym_lt = 8'b00000110; //      **
            4'hc: sym_lt = 8'b00000000; // 
            4'hd: sym_lt = 8'b00000000; // 
            4'he: sym_lt = 8'b00000000; // 
            4'hf: sym_lt = 8'b00000000; // 
        endcase
    // symbol '_'
    always @*
        case (titleAddr)   
            4'h0: sym_us = 8'b00000000; // 
            4'h1: sym_us = 8'b00000000; // 
            4'h2: sym_us = 8'b00000000; // 
            4'h3: sym_us = 8'b00000000; // 
            4'h4: sym_us = 8'b00000000; // 
            4'h5: sym_us = 8'b00000000; // 
            4'h6: sym_us = 8'b00000000; // 
            4'h7: sym_us = 8'b00000000; // 
            4'h8: sym_us = 8'b00000000; // 
            4'h9: sym_us = 8'b00000000; // 
            4'ha: sym_us = 8'b00000000; // 
            4'hb: sym_us = 8'b00000000; // 
            4'hc: sym_us = 8'b00000000; // 
            4'hd: sym_us = 8'b11111111; // ********
            4'he: sym_us = 8'b00000000; // 
            4'hf: sym_us = 8'b00000000; //
        endcase
    // space
    always @*
        case (keyAddr)
            4'h0: sp = 8'b00000000; // 
            4'h1: sp = 8'b00000000; // 
            4'h2: sp = 8'b00000000; // 
            4'h3: sp = 8'b00000000; // 
            4'h4: sp = 8'b00000000; // 
            4'h5: sp = 8'b00000000; // 
            4'h6: sp = 8'b00000000; // 
            4'h7: sp = 8'b00000000; // 
            4'h8: sp = 8'b00000000; // 
            4'h9: sp = 8'b00000000; // 
            4'ha: sp = 8'b00000000; // 
            4'hb: sp = 8'b00000000; // 
            4'hc: sp = 8'b00000000; // 
            4'hd: sp = 8'b00000000; // 
            4'he: sp = 8'b00000000; // 
            4'hf: sp = 8'b00000000; //
        endcase
    //------------------------------------------------------
    // key instruction bitmap roms
    //------------------------------------------------------
    // letter K
    always @*
        case (keyAddr)   
            4'h0: letK = 8'b00000000; // 
            4'h1: letK = 8'b00000000; // 
            4'h2: letK = 8'b11100110; // ***  **
            4'h3: letK = 8'b01100110; //  **  **
            4'h4: letK = 8'b01100110; //  **  **
            4'h5: letK = 8'b01101100; //  ** **
            4'h6: letK = 8'b01111000; //  ****
            4'h7: letK = 8'b01111000; //  ****
            4'h8: letK = 8'b01101100; //  ** **
            4'h9: letK = 8'b01100110; //  **  **
            4'ha: letK = 8'b01100110; //  **  **
            4'hb: letK = 8'b11100110; // ***  **
            4'hc: letK = 8'b00000000; // 
            4'hd: letK = 8'b00000000; // 
            4'he: letK = 8'b00000000; // 
            4'hf: letK = 8'b00000000; // 
        endcase
    // letter E
    always @*
        case (keyAddr)   
            4'h0: letE = 8'b00000000; //          
            4'h1: letE = 8'b00000000; //          
            4'h2: letE = 8'b11111110; // *******  
            4'h3: letE = 8'b01100110; //  **  **  
            4'h4: letE = 8'b01100010; //  **   *  
            4'h5: letE = 8'b01101000; //  ** *    
            4'h6: letE = 8'b01111000; //  ****    
            4'h7: letE = 8'b01101000; //  ** *    
            4'h8: letE = 8'b01100000; //  **      
            4'h9: letE = 8'b01100010; //  **   *  
            4'ha: letE = 8'b01100110; //  **  **  
            4'hb: letE = 8'b11111110; // *******  
            4'hc: letE = 8'b00000000; //          
            4'hd: letE = 8'b00000000; //          
            4'he: letE = 8'b00000000; //          
            4'hf: letE = 8'b00000000; //          
        endcase
    // letter Y
    always @*
        case (keyAddr)   
            4'h0: letY = 8'b00000000; //           
            4'h1: letY = 8'b00000000; //           
            4'h2: letY = 8'b11000011; // **    **  
            4'h3: letY = 8'b11000011; // **    **  
            4'h4: letY = 8'b11000011; // **    **  
            4'h5: letY = 8'b01100110; //  **  **   
            4'h6: letY = 8'b00111100; //   ****    
            4'h7: letY = 8'b00011000; //    **     
            4'h8: letY = 8'b00011000; //    **     
            4'h9: letY = 8'b00011000; //    **     
            4'ha: letY = 8'b00011000; //    **     
            4'hb: letY = 8'b00111100; //   ****    
            4'hc: letY = 8'b00000000; //           
            4'hd: letY = 8'b00000000; //           
            4'he: letY = 8'b00000000; //           
            4'hf: letY = 8'b00000000; //           
        endcase
    // letter S
    always @*
        case (keyAddr)   
            4'h0: letS = 8'b00000000; //         
            4'h1: letS = 8'b00000000; //         
            4'h2: letS = 8'b01111100; //  *****  
            4'h3: letS = 8'b11000110; // **   ** 
            4'h4: letS = 8'b11000110; // **   ** 
            4'h5: letS = 8'b01100000; //  **     
            4'h6: letS = 8'b00111000; //   ***   
            4'h7: letS = 8'b00001100; //     **  
            4'h8: letS = 8'b00000110; //      ** 
            4'h9: letS = 8'b11000110; // **   ** 
            4'ha: letS = 8'b11000110; // **   ** 
            4'hb: letS = 8'b01111100; //  *****  
            4'hc: letS = 8'b00000000; //         
            4'hd: letS = 8'b00000000; //         
            4'he: letS = 8'b00000000; //         
            4'hf: letS = 8'b00000000; //         
        endcase
    // letter W
    always @*
        case (keyAddr)   
            4'h0: letW = 8'b00000000; //           
            4'h1: letW = 8'b00000000; //           
            4'h2: letW = 8'b11000011; // **    **  
            4'h3: letW = 8'b11000011; // **    **  
            4'h4: letW = 8'b11000011; // **    **  
            4'h5: letW = 8'b11000011; // **    **  
            4'h6: letW = 8'b11000011; // **    **  
            4'h7: letW = 8'b11011011; // ** ** **  
            4'h8: letW = 8'b11011011; // ** ** **  
            4'h9: letW = 8'b11111111; // ********  
            4'ha: letW = 8'b01100110; //  **  **   
            4'hb: letW = 8'b01100110; //  **  **   
            4'hc: letW = 8'b00000000; //           
            4'hd: letW = 8'b00000000; //           
            4'he: letW = 8'b00000000; //           
            4'hf: letW = 8'b00000000; //           
        endcase
    // letter L
    always @*
        case (keyAddr)   
            4'h0: letL = 8'b00000000; //         
            4'h1: letL = 8'b00000000; //         
            4'h2: letL = 8'b11110000; // ****    
            4'h3: letL = 8'b01100000; //  **     
            4'h4: letL = 8'b01100000; //  **     
            4'h5: letL = 8'b01100000; //  **     
            4'h6: letL = 8'b01100000; //  **     
            4'h7: letL = 8'b01100000; //  **     
            4'h8: letL = 8'b01100000; //  **     
            4'h9: letL = 8'b01100010; //  **   * 
            4'ha: letL = 8'b01100110; //  **  ** 
            4'hb: letL = 8'b11111110; // ******* 
            4'hc: letL = 8'b00000000; //         
            4'hd: letL = 8'b00000000; //         
            4'he: letL = 8'b00000000; //         
            4'hf: letL = 8'b00000000; //         
        endcase
    // letter I
    always @*
        case (keyAddr)   
            4'h0: letI = 8'b00000000; //        
            4'h1: letI = 8'b00000000; //        
            4'h2: letI = 8'b00111100; //   **** 
            4'h3: letI = 8'b00011000; //    **  
            4'h4: letI = 8'b00011000; //    **  
            4'h5: letI = 8'b00011000; //    **  
            4'h6: letI = 8'b00011000; //    **  
            4'h7: letI = 8'b00011000; //    **  
            4'h8: letI = 8'b00011000; //    **  
            4'h9: letI = 8'b00011000; //    **  
            4'ha: letI = 8'b00011000; //    **  
            4'hb: letI = 8'b00111100; //   **** 
            4'hc: letI = 8'b00000000; //        
            4'hd: letI = 8'b00000000; //        
            4'he: letI = 8'b00000000; //        
            4'hf: letI = 8'b00000000; //        
        endcase
    // letter D
    always @*
        case (keyAddr)   
            4'h0: letD = 8'b00000000; //           
            4'h1: letD = 8'b00000000; //           
            4'h2: letD = 8'b11111000; // *****     
            4'h3: letD = 8'b01101100; //  ** **    
            4'h4: letD = 8'b01100110; //  **  **   
            4'h5: letD = 8'b01100110; //  **  **   
            4'h6: letD = 8'b01100110; //  **  **   
            4'h7: letD = 8'b01100110; //  **  **   
            4'h8: letD = 8'b01100110; //  **  **   
            4'h9: letD = 8'b01100110; //  **  **   
            4'ha: letD = 8'b01101100; //  ** **    
            4'hb: letD = 8'b11111000; // *****     
            4'hc: letD = 8'b00000000; //           
            4'hd: letD = 8'b00000000; //           
            4'he: letD = 8'b00000000; //           
            4'hf: letD = 8'b00000000; //           
        endcase
    // letter U
    always @*
        case (keyAddr)   
            4'h0: letU = 8'b00000000; //          
            4'h1: letU = 8'b00000000; //          
            4'h2: letU = 8'b11000110; // **   **  
            4'h3: letU = 8'b11000110; // **   **  
            4'h4: letU = 8'b11000110; // **   **  
            4'h5: letU = 8'b11000110; // **   **  
            4'h6: letU = 8'b11000110; // **   **  
            4'h7: letU = 8'b11000110; // **   **  
            4'h8: letU = 8'b11000110; // **   **  
            4'h9: letU = 8'b11000110; // **   **  
            4'ha: letU = 8'b11000110; // **   **  
            4'hb: letU = 8'b01111100; //  *****   
            4'hc: letU = 8'b00000000; //          
            4'hd: letU = 8'b00000000; //          
            4'he: letU = 8'b00000000; //          
            4'hf: letU = 8'b00000000; //          
        endcase
    // letter P
    always @*
        case (keyAddr)   
            4'h0: letP = 8'b00000000; //          
            4'h1: letP = 8'b00000000; //          
            4'h2: letP = 8'b11111100; // ******   
            4'h3: letP = 8'b01100110; //  **  **  
            4'h4: letP = 8'b01100110; //  **  **  
            4'h5: letP = 8'b01100110; //  **  **  
            4'h6: letP = 8'b01111100; //  *****   
            4'h7: letP = 8'b01100000; //  **      
            4'h8: letP = 8'b01100000; //  **      
            4'h9: letP = 8'b01100000; //  **      
            4'ha: letP = 8'b01100000; //  **      
            4'hb: letP = 8'b11110000; // ****     
            4'hc: letP = 8'b00000000; //          
            4'hd: letP = 8'b00000000; //          
            4'he: letP = 8'b00000000; //          
            4'hf: letP = 8'b00000000; //          
        endcase
    // letter A
    always @*
        case (keyAddr)   
            4'h0: letA = 8'b00000000; //          
            4'h1: letA = 8'b00000000; //          
            4'h2: letA = 8'b00010000; //    *     
            4'h3: letA = 8'b00111000; //   ***    
            4'h4: letA = 8'b01101100; //  ** **   
            4'h5: letA = 8'b11000110; // **   **  
            4'h6: letA = 8'b11000110; // **   **  
            4'h7: letA = 8'b11111110; // *******  
            4'h8: letA = 8'b11000110; // **   **  
            4'h9: letA = 8'b11000110; // **   **  
            4'ha: letA = 8'b11000110; // **   **  
            4'hb: letA = 8'b11000110; // **   **  
            4'hc: letA = 8'b00000000; //          
            4'hd: letA = 8'b00000000; //          
            4'he: letA = 8'b00000000; //          
            4'hf: letA = 8'b00000000; //          
        endcase
    // letter F
    always @*
        case (keyAddr)   
            4'h0: letF = 8'b00000000; //          
            4'h1: letF = 8'b00000000; //          
            4'h2: letF = 8'b11111110; // *******  
            4'h3: letF = 8'b01100110; //  **  **  
            4'h4: letF = 8'b01100010; //  **   *  
            4'h5: letF = 8'b01101000; //  ** *    
            4'h6: letF = 8'b01111000; //  ****    
            4'h7: letF = 8'b01101000; //  ** *    
            4'h8: letF = 8'b01100000; //  **      
            4'h9: letF = 8'b01100000; //  **      
            4'ha: letF = 8'b01100000; //  **      
            4'hb: letF = 8'b11110000; // ****     
            4'hc: letF = 8'b00000000; //          
            4'hd: letF = 8'b00000000; //          
            4'he: letF = 8'b00000000; //          
            4'hf: letF = 8'b00000000; //          
        endcase
    // letter T
    always @*
        case (keyAddr)   
            4'h0: letT = 8'b00000000; //           
            4'h1: letT = 8'b00000000; //           
            4'h2: letT = 8'b11111111; // ********  
            4'h3: letT = 8'b11011011; // ** ** **  
            4'h4: letT = 8'b10011001; // *  **  *  
            4'h5: letT = 8'b00011000; //    **     
            4'h6: letT = 8'b00011000; //    **     
            4'h7: letT = 8'b00011000; //    **     
            4'h8: letT = 8'b00011000; //    **     
            4'h9: letT = 8'b00011000; //    **     
            4'ha: letT = 8'b00011000; //    **     
            4'hb: letT = 8'b00111100; //   ****    
            4'hc: letT = 8'b00000000; //           
            4'hd: letT = 8'b00000000; //           
            4'he: letT = 8'b00000000; //           
            4'hf: letT = 8'b00000000; //           
        endcase
    // letter O
    always @*
        case (keyAddr)   
            4'h0: letO = 8'b00000000; //         
            4'h1: letO = 8'b00000000; //         
            4'h2: letO = 8'b01111100; //  *****  
            4'h3: letO = 8'b11000110; // **   ** 
            4'h4: letO = 8'b11000110; // **   ** 
            4'h5: letO = 8'b11000110; // **   ** 
            4'h6: letO = 8'b11000110; // **   ** 
            4'h7: letO = 8'b11000110; // **   ** 
            4'h8: letO = 8'b11000110; // **   ** 
            4'h9: letO = 8'b11000110; // **   ** 
            4'ha: letO = 8'b11000110; // **   ** 
            4'hb: letO = 8'b01111100; //  *****  
            4'hc: letO = 8'b00000000; //         
            4'hd: letO = 8'b00000000; //         
            4'he: letO = 8'b00000000; //         
            4'hf: letO = 8'b00000000; //         
        endcase
    // letter N
    always @*
        case (keyAddr)   
            4'h0: letN = 8'b00000000; //          
            4'h1: letN = 8'b00000000; //          
            4'h2: letN = 8'b11000110; // **   **  
            4'h3: letN = 8'b11100110; // ***  **  
            4'h4: letN = 8'b11110110; // **** **  
            4'h5: letN = 8'b11111110; // *******  
            4'h6: letN = 8'b11011110; // ** ****  
            4'h7: letN = 8'b11001110; // **  ***  
            4'h8: letN = 8'b11000110; // **   **  
            4'h9: letN = 8'b11000110; // **   **  
            4'ha: letN = 8'b11000110; // **   **  
            4'hb: letN = 8'b11000110; // **   **  
            4'hc: letN = 8'b00000000; //          
            4'hd: letN = 8'b00000000; //          
            4'he: letN = 8'b00000000; //          
            4'hf: letN = 8'b00000000; //          
        endcase
    // letter R
    always @*
        case (keyAddr)   
            4'h0: letR = 8'b00000000; //         
            4'h1: letR = 8'b00000000; //         
            4'h2: letR = 8'b11111100; // ******  
            4'h3: letR = 8'b01100110; //  **  ** 
            4'h4: letR = 8'b01100110; //  **  ** 
            4'h5: letR = 8'b01100110; //  **  ** 
            4'h6: letR = 8'b01111100; //  *****  
            4'h7: letR = 8'b01101100; //  ** **  
            4'h8: letR = 8'b01100110; //  **  ** 
            4'h9: letR = 8'b01100110; //  **  ** 
            4'ha: letR = 8'b01100110; //  **  ** 
            4'hb: letR = 8'b11100110; // ***  ** 
            4'hc: letR = 8'b00000000; //         
            4'hd: letR = 8'b00000000; //         
            4'he: letR = 8'b00000000; //         
            4'hf: letR = 8'b00000000; //         
        endcase
    // letter G
    always @*
        case (keyAddr)   
            4'h0: letG = 8'b00000000; //           
            4'h1: letG = 8'b00000000; //           
            4'h2: letG = 8'b00111100; //   ****    
            4'h3: letG = 8'b01100110; //  **  **   
            4'h4: letG = 8'b11000010; // **    *   
            4'h5: letG = 8'b11000000; // **        
            4'h6: letG = 8'b11000000; // **        
            4'h7: letG = 8'b11011110; // ** ****   
            4'h8: letG = 8'b11000110; // **   **   
            4'h9: letG = 8'b11000110; // **   **   
            4'ha: letG = 8'b01100110; //  **  **   
            4'hb: letG = 8'b00111010; //   *** *   
            4'hc: letG = 8'b00000000; //           
            4'hd: letG = 8'b00000000; //           
            4'he: letG = 8'b00000000; //           
            4'hf: letG = 8'b00000000; //           
        endcase
    // letter H
    always @*
        case (keyAddr)   
            4'h0: letH = 8'b00000000; //           
            4'h1: letH = 8'b00000000; //           
            4'h2: letH = 8'b11000110; // **   **   
            4'h3: letH = 8'b11000110; // **   **   
            4'h4: letH = 8'b11000110; // **   **   
            4'h5: letH = 8'b11000110; // **   **   
            4'h6: letH = 8'b11111110; // *******   
            4'h7: letH = 8'b11000110; // **   **   
            4'h8: letH = 8'b11000110; // **   **   
            4'h9: letH = 8'b11000110; // **   **   
            4'ha: letH = 8'b11000110; // **   **   
            4'hb: letH = 8'b11000110; // **   **   
            4'hc: letH = 8'b00000000; //           
            4'hd: letH = 8'b00000000; //           
            4'he: letH = 8'b00000000; //           
            4'hf: letH = 8'b00000000; //           
        endcase
    //------------------------------------------------------
    // number bitmap roms
    //------------------------------------------------------
    // number 0
    always @*
        case (num_addr)
            4'h0: num_0 = 8'b00000000; // 
            4'h1: num_0 = 8'b00000000; // 
            4'h2: num_0 = 8'b01111100; //  *****
            4'h3: num_0 = 8'b11000110; // **   **
            4'h4: num_0 = 8'b11000110; // **   **
            4'h5: num_0 = 8'b11001110; // **  ***
            4'h6: num_0 = 8'b11011110; // ** ****
            4'h7: num_0 = 8'b11110110; // **** **
            4'h8: num_0 = 8'b11100110; // ***  **
            4'h9: num_0 = 8'b11000110; // **   **
            4'ha: num_0 = 8'b11000110; // **   **
            4'hb: num_0 = 8'b01111100; //  *****
            4'hc: num_0 = 8'b00000000; // 
            4'hd: num_0 = 8'b00000000; // 
            4'he: num_0 = 8'b00000000; // 
            4'hf: num_0 = 8'b00000000; //
         endcase
     // number 1
     always @*
        case (num_addr)
            4'h0: num_1= 8'b00000000; // 
            4'h1: num_1= 8'b00000000; // 
            4'h2: num_1= 8'b00011000; // 
            4'h3: num_1= 8'b00111000; // 
            4'h4: num_1= 8'b01111000; //    **
            4'h5: num_1= 8'b00011000; //   ***
            4'h6: num_1= 8'b00011000; //  ****
            4'h7: num_1= 8'b00011000; //    **
            4'h8: num_1= 8'b00011000; //    **
            4'h9: num_1= 8'b00011000; //    **
            4'ha: num_1= 8'b00011000; //    **
            4'hb: num_1= 8'b01111110; //    **
            4'hc: num_1= 8'b00000000; //    **
            4'hd: num_1= 8'b00000000; //  ******
            4'he: num_1= 8'b00000000; // 
            4'hf: num_1= 8'b00000000; // 
        endcase
    // number 2
    always @*
        case (num_addr)
            4'h0: num_2 = 8'b00000000; // 
            4'h1: num_2 = 8'b00000000; // 
            4'h2: num_2 = 8'b01111100; //  *****
            4'h3: num_2 = 8'b11000110; // **   **
            4'h4: num_2 = 8'b00000110; //      **
            4'h5: num_2 = 8'b00001100; //     **
            4'h6: num_2 = 8'b00011000; //    **
            4'h7: num_2 = 8'b00110000; //   **
            4'h8: num_2 = 8'b01100000; //  **
            4'h9: num_2 = 8'b11000000; // **
            4'ha: num_2 = 8'b11000110; // **   **
            4'hb: num_2 = 8'b11111110; // *******
            4'hc: num_2 = 8'b00000000; // 
            4'hd: num_2 = 8'b00000000; // 
            4'he: num_2 = 8'b00000000; // 
            4'hf: num_2 = 8'b00000000; //
        endcase
    // number 3
    always @*
        case (num_addr)
            4'h0: num_3 = 8'b00000000; // 
            4'h1: num_3 = 8'b00000000; // 
            4'h2: num_3 = 8'b01111100; //  *****
            4'h3: num_3 = 8'b11000110; // **   **
            4'h4: num_3 = 8'b00000110; //      **
            4'h5: num_3 = 8'b00000110; //      **
            4'h6: num_3 = 8'b00111100; //   ****
            4'h7: num_3 = 8'b00000110; //      **
            4'h8: num_3 = 8'b00000110; //      **
            4'h9: num_3 = 8'b00000110; //      **
            4'ha: num_3 = 8'b11000110; // **   **
            4'hb: num_3 = 8'b01111100; //  *****
            4'hc: num_3 = 8'b00000000; // 
            4'hd: num_3 = 8'b00000000; // 
            4'he: num_3 = 8'b00000000; // 
            4'hf: num_3 = 8'b00000000; //
        endcase
    // number 4
    always @*
        case (num_addr)
            4'h0: num_4 = 8'b00000000; // 
            4'h1: num_4 = 8'b00000000; // 
            4'h2: num_4 = 8'b00001100; //     **
            4'h3: num_4 = 8'b00011100; //    ***
            4'h4: num_4 = 8'b00111100; //   ****
            4'h5: num_4 = 8'b01101100; //  ** **
            4'h6: num_4 = 8'b11001100; // **  **
            4'h7: num_4 = 8'b11111110; // *******
            4'h8: num_4 = 8'b00001100; //     **
            4'h9: num_4 = 8'b00001100; //     **
            4'ha: num_4 = 8'b00001100; //     **
            4'hb: num_4 = 8'b00011110; //    ****
            4'hc: num_4 = 8'b00000000; // 
            4'hd: num_4 = 8'b00000000; // 
            4'he: num_4 = 8'b00000000; // 
            4'hf: num_4 = 8'b00000000; // 
        endcase
    // number 5
    always @*
        case (num_addr)
             4'h0: num_5 = 8'b00000000; // 
             4'h1: num_5 = 8'b00000000; // 
             4'h2: num_5 = 8'b11111110; // *******
             4'h3: num_5 = 8'b11000000; // **
             4'h4: num_5 = 8'b11000000; // **
             4'h5: num_5 = 8'b11000000; // **
             4'h6: num_5 = 8'b11111100; // ******
             4'h7: num_5 = 8'b00000110; //      **
             4'h8: num_5 = 8'b00000110; //      **
             4'h9: num_5 = 8'b00000110; //      **
             4'ha: num_5 = 8'b11000110; // **   **
             4'hb: num_5 = 8'b01111100; //  *****
             4'hc: num_5 = 8'b00000000; // 
             4'hd: num_5 = 8'b00000000; // 
             4'he: num_5 = 8'b00000000; // 
             4'hf: num_5 = 8'b00000000; // 
        endcase
    // number 6
    always @*
        case (num_addr)
             4'h0: num_6 = 8'b00000000; // 
             4'h1: num_6 = 8'b00000000; // 
             4'h2: num_6 = 8'b00111000; //   ***
             4'h3: num_6 = 8'b01100000; //  **
             4'h4: num_6 = 8'b11000000; // **
             4'h5: num_6 = 8'b11000000; // **
             4'h6: num_6 = 8'b11111100; // ******
             4'h7: num_6 = 8'b11000110; // **   **
             4'h8: num_6 = 8'b11000110; // **   **
             4'h9: num_6 = 8'b11000110; // **   **
             4'ha: num_6 = 8'b11000110; // **   **
             4'hb: num_6 = 8'b01111100; //  *****
             4'hc: num_6 = 8'b00000000; // 
             4'hd: num_6 = 8'b00000000; // 
             4'he: num_6 = 8'b00000000; // 
             4'hf: num_6 = 8'b00000000; // 
         endcase
     // number 7
     always @*
        case (num_addr)
             4'h0: num_7 = 8'b00000000; // 
             4'h1: num_7 = 8'b00000000; // 
             4'h2: num_7 = 8'b11111110; // *******
             4'h3: num_7 = 8'b11000110; // **   **
             4'h4: num_7 = 8'b00000110; //      **
             4'h5: num_7 = 8'b00000110; //      **
             4'h6: num_7 = 8'b00001100; //     **
             4'h7: num_7 = 8'b00011000; //    **
             4'h8: num_7 = 8'b00110000; //   **
             4'h9: num_7 = 8'b00110000; //   **
             4'ha: num_7 = 8'b00110000; //   **
             4'hb: num_7 = 8'b00110000; //   **
             4'hc: num_7 = 8'b00000000; // 
             4'hd: num_7 = 8'b00000000; // 
             4'he: num_7 = 8'b00000000; // 
             4'hf: num_7 = 8'b00000000; // 
        endcase
    // number 8
    always @*
        case (num_addr)
             4'h0: num_8 = 8'b00000000; // 
             4'h1: num_8 = 8'b00000000; // 
             4'h2: num_8 = 8'b01111100; //  *****
             4'h3: num_8 = 8'b11000110; // **   **
             4'h4: num_8 = 8'b11000110; // **   **
             4'h5: num_8 = 8'b11000110; // **   **
             4'h6: num_8 = 8'b01111100; //  *****
             4'h7: num_8 = 8'b11000110; // **   **
             4'h8: num_8 = 8'b11000110; // **   **
             4'h9: num_8 = 8'b11000110; // **   **
             4'ha: num_8 = 8'b11000110; // **   **
             4'hb: num_8 = 8'b01111100; //  *****
             4'hc: num_8 = 8'b00000000; // 
             4'hd: num_8 = 8'b00000000; // 
             4'he: num_8 = 8'b00000000; // 
             4'hf: num_8 = 8'b00000000; // 
        endcase
    // number 9
    always @*
        case (num_addr)
             4'h0: num_9 = 8'b00000000; // 
             4'h1: num_9 = 8'b00000000; // 
             4'h2: num_9 = 8'b01111100; //  *****
             4'h3: num_9 = 8'b11000110; // **   **
             4'h4: num_9 = 8'b11000110; // **   **
             4'h5: num_9 = 8'b11000110; // **   **
             4'h6: num_9 = 8'b01111110; //  ******
             4'h7: num_9 = 8'b00000110; //      **
             4'h8: num_9 = 8'b00000110; //      **
             4'h9: num_9 = 8'b00000110; //      **
             4'ha: num_9 = 8'b00001100; //     **
             4'hb: num_9 = 8'b01111000; //  ****
             4'hc: num_9 = 8'b00000000; // 
             4'hd: num_9 = 8'b00000000; // 
             4'he: num_9 = 8'b00000000; // 
             4'hf: num_9 = 8'b00000000; //
         endcase
    
    //------------------------------------------------------
    // title bar
    //------------------------------------------------------
    assign tbarOn = (TBAR_Y_T <= pixY) && (pixY <= TBAR_Y_B); 
    //------------------------------------------------------
    // title display
    //------------------------------------------------------
    assign titleRGB = 12'b1111_1111_1111;
    // title data
    always @*
        begin
            t1data = sym_lp;
            t2data = sym_gt;
            t3data = sym_us;
            t4data = sym_lt;
            t5data = sym_rp;
            t6data = sp;
            t7data = num_2;
            t8data = num_0;
            t9data = num_4;
            t10data = num_8;
            t11data = sp;
            t12data = sym_lp;
            t13data = sym_gt;
            t14data = sym_us;
            t15data = sym_lt;
            t16data = sym_rp;
        end
        
    // title map
    assign t1map = (CHAR_X1_L < pixX) && (pixX <= CHAR_X1_R) && (CHAR_Y_T < pixY) && (pixY <= CHAR_Y_B);
    assign t2map = (CHAR_X2_L < pixX) && (pixX <= CHAR_X2_R) && (CHAR_Y_T < pixY) && (pixY <= CHAR_Y_B);
    assign t3map = (CHAR_X3_L < pixX) && (pixX <= CHAR_X3_R) && (CHAR_Y_T < pixY) && (pixY <= CHAR_Y_B);
    assign t4map = (CHAR_X4_L < pixX) && (pixX <= CHAR_X4_R) && (CHAR_Y_T < pixY) && (pixY <= CHAR_Y_B);
    assign t5map = (CHAR_X5_L < pixX) && (pixX <= CHAR_X5_R) && (CHAR_Y_T < pixY) && (pixY <= CHAR_Y_B);
    assign t6map = (CHAR_X6_L < pixX) && (pixX <= CHAR_X6_R) && (CHAR_Y_T < pixY) && (pixY <= CHAR_Y_B);
    assign t7map = (CHAR_X7_L < pixX) && (pixX <= CHAR_X7_R) && (CHAR_Y_T < pixY) && (pixY <= CHAR_Y_B);
    assign t8map = (CHAR_X8_L < pixX) && (pixX <= CHAR_X8_R) && (CHAR_Y_T < pixY) && (pixY <= CHAR_Y_B);
    assign t9map = (CHAR_X9_L < pixX) && (pixX <= CHAR_X9_R) && (CHAR_Y_T < pixY) && (pixY <= CHAR_Y_B);
    assign t10map = (CHAR_X10_L < pixX) && (pixX <= CHAR_X10_R) && (CHAR_Y_T < pixY) && (pixY <= CHAR_Y_B);
    assign t11map = (CHAR_X11_L < pixX) && (pixX <= CHAR_X11_R) && (CHAR_Y_T < pixY) && (pixY <= CHAR_Y_B);
    assign t12map = (CHAR_X12_L < pixX) && (pixX <= CHAR_X12_R) && (CHAR_Y_T < pixY) && (pixY <= CHAR_Y_B);
    assign t13map = (CHAR_X13_L < pixX) && (pixX <= CHAR_X13_R) && (CHAR_Y_T < pixY) && (pixY <= CHAR_Y_B);
    assign t14map = (CHAR_X14_L < pixX) && (pixX <= CHAR_X14_R) && (CHAR_Y_T < pixY) && (pixY <= CHAR_Y_B);
    assign t15map = (CHAR_X15_L < pixX) && (pixX <= CHAR_X15_R) && (CHAR_Y_T < pixY) && (pixY <= CHAR_Y_B);
    assign t16map = (CHAR_X16_L < pixX) && (pixX <= CHAR_X16_R) && (CHAR_Y_T < pixY) && (pixY <= CHAR_Y_B);
    
    // title address, columns, and bits
    assign titleAddr = pixY[5:2] - CHAR_Y_T[5:2];
    
    assign t1col = CHAR_X1_R[5:2] - pixX[5:2];
    assign t2col = CHAR_X2_R[5:2] - pixX[5:2];
    assign t3col = CHAR_X3_R[5:2] - pixX[5:2];
    assign t4col = CHAR_X4_R[5:2] - pixX[5:2];
    assign t5col = CHAR_X5_R[5:2] - pixX[5:2];
    assign t6col = CHAR_X6_R[5:2] - pixX[5:2];
    assign t7col = CHAR_X7_R[5:2] - pixX[5:2];
    assign t8col = CHAR_X8_R[5:2] - pixX[5:2];
    assign t9col = CHAR_X9_R[5:2] - pixX[5:2];
    assign t10col = CHAR_X10_R[5:2] - pixX[5:2];
    assign t11col = CHAR_X11_R[5:2] - pixX[5:2];
    assign t12col = CHAR_X12_R[5:2] - pixX[5:2];
    assign t13col = CHAR_X13_R[5:2] - pixX[5:2];
    assign t14col = CHAR_X14_R[5:2] - pixX[5:2];
    assign t15col = CHAR_X15_R[5:2] - pixX[5:2];
    assign t16col = CHAR_X16_R[5:2] - pixX[5:2];
    
    assign t1bit = t1data[t1col];
    assign t2bit = t2data[t2col];
    assign t3bit = t3data[t3col];
    assign t4bit = t4data[t4col];
    assign t5bit = t5data[t5col];
    assign t6bit = t6data[t6col];
    assign t7bit = t7data[t7col];
    assign t8bit = t8data[t8col];
    assign t9bit = t9data[t9col];
    assign t10bit = t10data[t10col];
    assign t11bit = t11data[t11col];
    assign t12bit = t12data[t12col];
    assign t13bit = t13data[t13col];
    assign t14bit = t14data[t14col];
    assign t15bit = t15data[t15col];
    assign t16bit = t16data[t16col];
    
    // map on
    assign t1on = t1map && t1bit;
    assign t2on = t2map && t2bit;
    assign t3on = t3map && t3bit;
    assign t4on = t4map && t4bit;
    assign t5on = t5map && t5bit;
    assign t6on = t6map && t6bit;
    assign t7on = t7map && t7bit;
    assign t8on = t8map && t8bit;
    assign t9on = t9map && t9bit;
    assign t10on = t10map && t10bit;
    assign t11on = t11map && t11bit;
    assign t12on = t12map && t12bit;
    assign t13on = t13map && t13bit;
    assign t14on = t14map && t14bit;
    assign t15on = t15map && t15bit;
    assign t16on = t16map && t16bit;
    assign titleOn = t1on | t2on | t3on | t4on | t5on | t6on | t7on | t8on | t9on | t10on | t11on | t12on | t13on | t14on | t15on | t16on;
    //------------------------------------------------------
    // number display
    //------------------------------------------------------
    assign num_addr = (t7map | t8map | t9map | t10map) ? (pixY[5:2] - CHAR_Y_T[5:2]) : (pixY[4:1]);
    //------------------------------------------------------
    // key instructions display
    //------------------------------------------------------
    // key instructiond data
    always @*
        begin
            // KEYS
            k1data = letK;                
            k2data = letE;                
            k3data = letY;                
            k4data = letS;
            // W  SLIDE UP                
            w1data = letW;                
            w2data = sp;                  
            w3data = sp;                  
            w4data = letS;                
            w5data = letL;                
            w6data = letI;                
            w7data = letD;                
            w8data = letE;                
            w9data = sp;                  
            w10data = letU;               
            w11data = letP;
            // A  SLIDE LEFT
            a1data = letA;
            a2data = sp;   
            a3data = sp;   
            a4data = letS; 
            a5data = letL; 
            a6data = letI; 
            a7data = letD; 
            a8data = letE; 
            a9data = sp;   
            a10data = letL;
            a11data = letE;
            a12data = letF;
            a13data = letT;
            // S  SLIDE DOWN
            s1data = letS; 
            s2data = sp;   
            s3data = sp;   
            s4data = letS; 
            s5data = letL; 
            s6data = letI; 
            s7data = letD; 
            s8data = letE; 
            s9data = sp;   
            s10data = letD;
            s11data = letO;
            s12data = letW;
            s13data = letN;
            // D  SLIDE RIGHT 
            d1data = letD; 
            d2data = sp;   
            d3data = sp;   
            d4data = letS; 
            d5data = letL; 
            d6data = letI; 
            d7data = letD; 
            d8data = letE; 
            d9data = sp;   
            d10data = letR;
            d11data = letI;
            d12data = letG;
            d13data = letH;
            d14data = letT;
        end
    
    // KEYS map
    assign k1map = (K1_XL <= pixX) && (pixX <= K1_XR) && (K_YT <= pixY) && (pixY <= K_YB);
    assign k2map = (K2_XL <= pixX) && (pixX <= K2_XR) && (K_YT <= pixY) && (pixY <= K_YB);
    assign k3map = (K3_XL <= pixX) && (pixX <= K3_XR) && (K_YT <= pixY) && (pixY <= K_YB);
    assign k4map = (K4_XL <= pixX) && (pixX <= K4_XR) && (K_YT <= pixY) && (pixY <= K_YB);
    assign kmap = k1map | k2map | k3map | k4map;
    
    // W SLIDE UP map
    assign w1map = (W1_XL <= pixX) && (pixX <= W1_XR) && (W_YT <= pixY) && (pixY <= W_YB);
    assign w2map = (W2_XL <= pixX) && (pixX <= W2_XR) && (W_YT <= pixY) && (pixY <= W_YB);
    assign w3map = (W3_XL <= pixX) && (pixX <= W3_XR) && (W_YT <= pixY) && (pixY <= W_YB);
    assign w4map = (W4_XL <= pixX) && (pixX <= W4_XR) && (W_YT <= pixY) && (pixY <= W_YB);
    assign w5map = (W5_XL <= pixX) && (pixX <= W5_XR) && (W_YT <= pixY) && (pixY <= W_YB);
    assign w6map = (W6_XL <= pixX) && (pixX <= W6_XR) && (W_YT <= pixY) && (pixY <= W_YB);
    assign w7map = (W7_XL <= pixX) && (pixX <= W7_XR) && (W_YT <= pixY) && (pixY <= W_YB);
    assign w8map = (W8_XL <= pixX) && (pixX <= W8_XR) && (W_YT <= pixY) && (pixY <= W_YB);
    assign w9map = (W9_XL <= pixX) && (pixX <= W9_XR) && (W_YT <= pixY) && (pixY <= W_YB);
    assign w10map = (W10_XL <= pixX) && (pixX <= W10_XR) && (W_YT <= pixY) && (pixY <= W_YB);
    assign w11map = (W11_XL <= pixX) && (pixX <= W11_XR) && (W_YT <= pixY) && (pixY <= W_YB);
    assign wmap = w1map | w2map | w3map | w4map | w5map | w6map | w7map | w8map | w9map | w10map | w11map;
    
    // A  SLIDE LEFT map
    assign a1map = (A1_XL <= pixX) && (pixX <= A1_XR) && (A_YT <= pixY) && (pixY <= A_YB);
    assign a2map = (A2_XL <= pixX) && (pixX <= A2_XR) && (A_YT <= pixY) && (pixY <= A_YB);
    assign a3map = (A3_XL <= pixX) && (pixX <= A3_XR) && (A_YT <= pixY) && (pixY <= A_YB);
    assign a4map = (A4_XL <= pixX) && (pixX <= A4_XR) && (A_YT <= pixY) && (pixY <= A_YB);
    assign a5map = (A5_XL <= pixX) && (pixX <= A5_XR) && (A_YT <= pixY) && (pixY <= A_YB);
    assign a6map = (A6_XL <= pixX) && (pixX <= A6_XR) && (A_YT <= pixY) && (pixY <= A_YB);
    assign a7map = (A7_XL <= pixX) && (pixX <= A7_XR) && (A_YT <= pixY) && (pixY <= A_YB);
    assign a8map = (A8_XL <= pixX) && (pixX <= A8_XR) && (A_YT <= pixY) && (pixY <= A_YB);
    assign a9map = (A9_XL <= pixX) && (pixX <= A9_XR) && (A_YT <= pixY) && (pixY <= A_YB);
    assign a10map = (A10_XL <= pixX) && (pixX <= A10_XR) && (A_YT <= pixY) && (pixY <= A_YB);
    assign a11map = (A11_XL <= pixX) && (pixX <= A11_XR) && (A_YT <= pixY) && (pixY <= A_YB);
    assign a12map = (A12_XL <= pixX) && (pixX <= A12_XR) && (A_YT <= pixY) && (pixY <= A_YB);
    assign a13map = (A13_XL <= pixX) && (pixX <= A13_XR) && (A_YT <= pixY) && (pixY <= A_YB);
    assign amap = a1map | a2map | a3map | a4map | a5map | a6map | a7map | a8map | a9map | a10map | a11map | a12map | a13map;
    
    // S  SLIDE DOWN map
    assign s1map = (S1_XL <= pixX) && (pixX <= S1_XR) && (S_YT <= pixY) && (pixY <= S_YB);
    assign s2map = (S2_XL <= pixX) && (pixX <= S2_XR) && (S_YT <= pixY) && (pixY <= S_YB);
    assign s3map = (S3_XL <= pixX) && (pixX <= S3_XR) && (S_YT <= pixY) && (pixY <= S_YB);
    assign s4map = (S4_XL <= pixX) && (pixX <= S4_XR) && (S_YT <= pixY) && (pixY <= S_YB);
    assign s5map = (S5_XL <= pixX) && (pixX <= S5_XR) && (S_YT <= pixY) && (pixY <= S_YB);
    assign s6map = (S6_XL <= pixX) && (pixX <= S6_XR) && (S_YT <= pixY) && (pixY <= S_YB);
    assign s7map = (S7_XL <= pixX) && (pixX <= S7_XR) && (S_YT <= pixY) && (pixY <= S_YB);
    assign s8map = (S8_XL <= pixX) && (pixX <= S8_XR) && (S_YT <= pixY) && (pixY <= S_YB);
    assign s9map = (S9_XL <= pixX) && (pixX <= S9_XR) && (S_YT <= pixY) && (pixY <= S_YB);
    assign s10map = (S10_XL <= pixX) && (pixX <= S10_XR) && (S_YT <= pixY) && (pixY <= S_YB);
    assign s11map = (S11_XL <= pixX) && (pixX <= S11_XR) && (S_YT <= pixY) && (pixY <= S_YB);
    assign s12map = (S12_XL <= pixX) && (pixX <= S12_XR) && (S_YT <= pixY) && (pixY <= S_YB);
    assign s13map = (S13_XL <= pixX) && (pixX <= S13_XR) && (S_YT <= pixY) && (pixY <= S_YB);
    assign smap = s1map | s2map | s3map | s4map | s5map | s6map | s7map | s8map | s9map | s10map | s11map | s12map | s13map;
    
    // D  SLIDE RIGHT map
    assign d1map = (D1_XL <= pixX) && (pixX <= D1_XR) && (D_YT <= pixY) && (pixY <= D_YB);
    assign d2map = (D2_XL <= pixX) && (pixX <= D2_XR) && (D_YT <= pixY) && (pixY <= D_YB);
    assign d3map = (D3_XL <= pixX) && (pixX <= D3_XR) && (D_YT <= pixY) && (pixY <= D_YB);
    assign d4map = (D4_XL <= pixX) && (pixX <= D4_XR) && (D_YT <= pixY) && (pixY <= D_YB);
    assign d5map = (D5_XL <= pixX) && (pixX <= D5_XR) && (D_YT <= pixY) && (pixY <= D_YB);
    assign d6map = (D6_XL <= pixX) && (pixX <= D6_XR) && (D_YT <= pixY) && (pixY <= D_YB);
    assign d7map = (D7_XL <= pixX) && (pixX <= D7_XR) && (D_YT <= pixY) && (pixY <= D_YB);
    assign d8map = (D8_XL <= pixX) && (pixX <= D8_XR) && (D_YT <= pixY) && (pixY <= D_YB);
    assign d9map = (D9_XL <= pixX) && (pixX <= D9_XR) && (D_YT <= pixY) && (pixY <= D_YB);
    assign d10map = (D10_XL <= pixX) && (pixX <= D10_XR) && (D_YT <= pixY) && (pixY <= D_YB);
    assign d11map = (D11_XL <= pixX) && (pixX <= D11_XR) && (D_YT <= pixY) && (pixY <= D_YB);
    assign d12map = (D12_XL <= pixX) && (pixX <= D12_XR) && (D_YT <= pixY) && (pixY <= D_YB);
    assign d13map = (D13_XL <= pixX) && (pixX <= D13_XR) && (D_YT <= pixY) && (pixY <= D_YB);
    assign d14map = (D14_XL <= pixX) && (pixX <= D14_XR) && (D_YT <= pixY) && (pixY <= D_YB);
    assign dmap = d1map | d2map | d3map | d4map | d5map | d6map | d7map | d8map | d9map | d10map | d11map | d12map | d13map | d14map;    
    
    // key instruction address
    assign kAddr = pixY[3:0] - K_YT[3:0];
    assign wAddr = pixY[3:0] - W_YT[3:0];
    assign aAddr = pixY[3:0] - A_YT[3:0];
    assign sAddr = pixY[3:0] - S_YT[3:0];
    assign dAddr = pixY[3:0] - D_YT[3:0];
    assign keyAddr = (t6map | t11map) ? titleAddr :
                     kmap ? kAddr : 
                     wmap ? wAddr : 
                     amap ? aAddr :
                     smap ? sAddr : dAddr;
    
    // KEYS col
    assign k1col = K1_XR[3:0] - pixX[3:0];
    assign k2col = K2_XR[3:0] - pixX[3:0];
    assign k3col = K3_XR[3:0] - pixX[3:0];
    assign k4col = K4_XR[3:0] - pixX[3:0];
    
    // W SLIDE UP col
    assign w1col = W1_XR[3:0] - pixX[3:0];
    assign w2col = W2_XR[3:0] - pixX[3:0];
    assign w3col = W3_XR[3:0] - pixX[3:0];
    assign w4col = W4_XR[3:0] - pixX[3:0];
    assign w5col = W5_XR[3:0] - pixX[3:0];
    assign w6col = W6_XR[3:0] - pixX[3:0];
    assign w7col = W7_XR[3:0] - pixX[3:0];
    assign w8col = W8_XR[3:0] - pixX[3:0];
    assign w9col = W9_XR[3:0] - pixX[3:0];
    assign w10col = W10_XR[3:0] - pixX[3:0];
    assign w11col = W11_XR[3:0] - pixX[3:0];
    
    // A  SLIDE LEFT col
    assign a1col = A1_XR[3:0] - pixX[3:0];
    assign a2col = A2_XR[3:0] - pixX[3:0];
    assign a3col = A3_XR[3:0] - pixX[3:0];
    assign a4col = A4_XR[3:0] - pixX[3:0];
    assign a5col = A5_XR[3:0] - pixX[3:0];
    assign a6col = A6_XR[3:0] - pixX[3:0];
    assign a7col = A7_XR[3:0] - pixX[3:0];
    assign a8col = A8_XR[3:0] - pixX[3:0];
    assign a9col = A9_XR[3:0] - pixX[3:0];
    assign a10col = A10_XR[3:0] - pixX[3:0];
    assign a11col = A11_XR[3:0] - pixX[3:0];
    assign a12col = A12_XR[3:0] - pixX[3:0];
    assign a13col = A13_XR[3:0] - pixX[3:0];
    
    // S  SLIDE DOWN col
    assign s1col = S1_XR[3:0] - pixX[3:0];
    assign s2col = S2_XR[3:0] - pixX[3:0];
    assign s3col = S3_XR[3:0] - pixX[3:0];
    assign s4col = S4_XR[3:0] - pixX[3:0];
    assign s5col = S5_XR[3:0] - pixX[3:0];
    assign s6col = S6_XR[3:0] - pixX[3:0];
    assign s7col = S7_XR[3:0] - pixX[3:0];
    assign s8col = S8_XR[3:0] - pixX[3:0];
    assign s9col = S9_XR[3:0] - pixX[3:0];
    assign s10col = S10_XR[3:0] - pixX[3:0];
    assign s11col = S11_XR[3:0] - pixX[3:0];
    assign s12col = S12_XR[3:0] - pixX[3:0];
    assign s13col = S13_XR[3:0] - pixX[3:0];
    
    // D  SLIDE RIGHT col
    assign d1col = D1_XR[3:0] - pixX[3:0];
    assign d2col = D2_XR[3:0] - pixX[3:0];
    assign d3col = D3_XR[3:0] - pixX[3:0];
    assign d4col = D4_XR[3:0] - pixX[3:0];
    assign d5col = D5_XR[3:0] - pixX[3:0];
    assign d6col = D6_XR[3:0] - pixX[3:0];
    assign d7col = D7_XR[3:0] - pixX[3:0];
    assign d8col = D8_XR[3:0] - pixX[3:0];
    assign d9col = D9_XR[3:0] - pixX[3:0];
    assign d10col = D10_XR[3:0] - pixX[3:0];
    assign d11col = D11_XR[3:0] - pixX[3:0];
    assign d12col = D12_XR[3:0] - pixX[3:0];
    assign d13col = D13_XR[3:0] - pixX[3:0];
    assign d14col = D14_XR[3:0] - pixX[3:0];
        
    // KEYS bit
    assign k1bit = k1data[k1col];
    assign k2bit = k2data[k2col];
    assign k3bit = k3data[k3col];
    assign k4bit = k4data[k4col];
    
    // W SLIDE UP bit
    assign w1bit = w1data[w1col];
    assign w2bit = w2data[w2col];
    assign w3bit = w3data[w3col];
    assign w4bit = w4data[w4col];
    assign w5bit = w5data[w5col];
    assign w6bit = w6data[w6col];
    assign w7bit = w7data[w7col];
    assign w8bit = w8data[w8col];
    assign w9bit = w9data[w9col];
    assign w10bit = w10data[w10col];
    assign w11bit = w11data[w11col];
    
    // A  SLIDE LEFT bit
    assign a1bit = a1data[a1col];
    assign a2bit = a2data[a2col];
    assign a3bit = a3data[a3col];
    assign a4bit = a4data[a4col];
    assign a5bit = a5data[a5col];
    assign a6bit = a6data[a6col];
    assign a7bit = a7data[a7col];
    assign a8bit = a8data[a8col];
    assign a9bit = a9data[a9col];
    assign a10bit = a10data[a10col];
    assign a11bit = a11data[a11col];    
    assign a12bit = a12data[a12col];    
    assign a13bit = a13data[a13col];
    
    // S  SLIDE DOWN bit
    assign s1bit = s1data[s1col];
    assign s2bit = s2data[s2col];
    assign s3bit = s3data[s3col];
    assign s4bit = s4data[s4col];
    assign s5bit = s5data[s5col];
    assign s6bit = s6data[s6col];
    assign s7bit = s7data[s7col];
    assign s8bit = s8data[s8col];
    assign s9bit = s9data[s9col];
    assign s10bit = s10data[s10col];
    assign s11bit = s11data[s11col];    
    assign s12bit = s12data[s12col];    
    assign s13bit = s13data[s13col];
    
    // D  SLIDE RIGHT bit
    assign d1bit = d1data[d1col];
    assign d2bit = d2data[d2col];
    assign d3bit = d3data[d3col];
    assign d4bit = d4data[d4col];
    assign d5bit = d5data[d5col];
    assign d6bit = d6data[d6col];
    assign d7bit = d7data[d7col];
    assign d8bit = d8data[d8col];
    assign d9bit = d9data[d9col];
    assign d10bit = d10data[d10col];
    assign d11bit = d11data[d11col];    
    assign d12bit = d12data[d12col];    
    assign d13bit = d13data[d13col];    
    assign d14bit = d14data[d14col];    
    
    // KEYS on
    assign k1on = k1map && k1bit;
    assign k2on = k2map && k2bit;
    assign k3on = k3map && k3bit;
    assign k4on = k4map && k4bit;
    assign kon = k1on | k2on | k3on | k4on;
    
    // W SLIDE UP on
    assign w1on = w1map && w1bit;
    assign w2on = w2map && w2bit;
    assign w3on = w3map && w3bit;
    assign w4on = w4map && w4bit;
    assign w5on = w5map && w5bit;
    assign w6on = w6map && w6bit;
    assign w7on = w7map && w7bit;
    assign w8on = w8map && w8bit;
    assign w9on = w9map && w9bit;
    assign w10on = w10map && w10bit;
    assign w11on = w11map && w11bit;
    assign won = w1on | w2on | w3on | w4on | w5on | w6on | w7on | w8on | w9on | w10on | w11on;    

    // A  SLIDE LEFT on
    assign a1on = a1map && a1bit;
    assign a2on = a2map && a2bit;
    assign a3on = a3map && a3bit;
    assign a4on = a4map && a4bit;
    assign a5on = a5map && a5bit;
    assign a6on = a6map && a6bit;
    assign a7on = a7map && a7bit;
    assign a8on = a8map && a8bit;
    assign a9on = a9map && a9bit;
    assign a10on = a10map && a10bit;
    assign a11on = a11map && a11bit;
    assign a12on = a12map && a12bit;
    assign a13on = a13map && a13bit;
    assign aon = a1on | a2on | a3on | a4on | a5on | a6on | a7on | a8on | a9on | a10on | a11on | a12on | a13on;    

    // S  SLIDE DOWN on
    assign s1on = s1map && s1bit;
    assign s2on = s2map && s2bit;
    assign s3on = s3map && s3bit;
    assign s4on = s4map && s4bit;
    assign s5on = s5map && s5bit;
    assign s6on = s6map && s6bit;
    assign s7on = s7map && s7bit;
    assign s8on = s8map && s8bit;
    assign s9on = s9map && s9bit;
    assign s10on = s10map && s10bit;
    assign s11on = s11map && s11bit;
    assign s12on = s12map && s12bit;
    assign s13on = s13map && s13bit;
    assign son = s1on | s2on | s3on | s4on | s5on | s6on | s7on | s8on | s9on | s10on | s11on | s12on | s13on;    

    // D  SLIDE RIGHT on
    assign d1on = d1map && d1bit;
    assign d2on = d2map && d2bit;
    assign d3on = d3map && d3bit;
    assign d4on = d4map && d4bit;
    assign d5on = d5map && d5bit;
    assign d6on = d6map && d6bit;
    assign d7on = d7map && d7bit;
    assign d8on = d8map && d8bit;
    assign d9on = d9map && d9bit;
    assign d10on = d10map && d10bit;
    assign d11on = d11map && d11bit;
    assign d12on = d12map && d12bit;
    assign d13on = d13map && d13bit;
    assign d14on = d14map && d14bit;
    assign don = d1on | d2on | d3on | d4on | d5on | d6on | d7on | d8on | d9on | d10on | d11on | d12on | d13on | d14on;
    
    assign keyInstrOn = kon | won | aon | son | don;
    //------------------------------------------------------
    // 4 z 4 grid display
    //------------------------------------------------------
    assign gridH1on = (GRID_X_L <= pixX) && (pixX <= GRID_X_R) && (GRID_H1_YT <= pixY) && (pixY <= GRID_H1_YB);
    assign gridH2on = (GRID_X_L <= pixX) && (pixX <= GRID_X_R) && (GRID_H2_YT <= pixY) && (pixY <= GRID_H2_YB);
    assign gridH3on = (GRID_X_L <= pixX) && (pixX <= GRID_X_R) && (GRID_H3_YT <= pixY) && (pixY <= GRID_H3_YB);
    assign gridH4on = (GRID_X_L <= pixX) && (pixX <= GRID_X_R) && (GRID_H4_YT <= pixY) && (pixY <= GRID_H4_YB);
    assign gridH5on = (GRID_X_L <= pixX) && (pixX <= GRID_X_R) && (GRID_H5_YT <= pixY) && (pixY <= GRID_H5_YB);
    assign gridV1on = (GRID_V1_XL <= pixX) && (pixX <= GRID_V1_XR) && (GRID_Y_T <= pixY) && (pixY <= GRID_Y_B);
    assign gridV2on = (GRID_V2_XL <= pixX) && (pixX <= GRID_V2_XR) && (GRID_Y_T <= pixY) && (pixY <= GRID_Y_B);
    assign gridV3on = (GRID_V3_XL <= pixX) && (pixX <= GRID_V3_XR) && (GRID_Y_T <= pixY) && (pixY <= GRID_Y_B);
    assign gridV4on = (GRID_V4_XL <= pixX) && (pixX <= GRID_V4_XR) && (GRID_Y_T <= pixY) && (pixY <= GRID_Y_B);
    assign gridV5on = (GRID_V5_XL <= pixX) && (pixX <= GRID_V5_XR) && (GRID_Y_T <= pixY) && (pixY <= GRID_Y_B);
    assign gridOn = gridH1on | gridH2on | gridH3on | gridH4on | gridH5on | gridV1on | gridV2on | gridV3on | gridV4on | gridV5on;
    //------------------------------------------------------
    // game box display
    //------------------------------------------------------
    assign box00on = (BOX0Q_XL <= pixX) && (pixX <= BOX0Q_XR) && (BOXQ0_YT <= pixY) && (pixY <= BOXQ0_YB);
    assign box01on = (BOX0Q_XL <= pixX) && (pixX <= BOX0Q_XR) && (BOXQ1_YT <= pixY) && (pixY <= BOXQ1_YB);
    assign box02on = (BOX0Q_XL <= pixX) && (pixX <= BOX0Q_XR) && (BOXQ2_YT <= pixY) && (pixY <= BOXQ2_YB);
    assign box03on = (BOX0Q_XL <= pixX) && (pixX <= BOX0Q_XR) && (BOXQ3_YT <= pixY) && (pixY <= BOXQ3_YB);
    assign box10on = (BOX1Q_XL <= pixX) && (pixX <= BOX1Q_XR) && (BOXQ0_YT <= pixY) && (pixY <= BOXQ0_YB);
    assign box11on = (BOX1Q_XL <= pixX) && (pixX <= BOX1Q_XR) && (BOXQ1_YT <= pixY) && (pixY <= BOXQ1_YB);
    assign box12on = (BOX1Q_XL <= pixX) && (pixX <= BOX1Q_XR) && (BOXQ2_YT <= pixY) && (pixY <= BOXQ2_YB);
    assign box13on = (BOX1Q_XL <= pixX) && (pixX <= BOX1Q_XR) && (BOXQ3_YT <= pixY) && (pixY <= BOXQ3_YB);
    assign box20on = (BOX2Q_XL <= pixX) && (pixX <= BOX2Q_XR) && (BOXQ0_YT <= pixY) && (pixY <= BOXQ0_YB);
    assign box21on = (BOX2Q_XL <= pixX) && (pixX <= BOX2Q_XR) && (BOXQ1_YT <= pixY) && (pixY <= BOXQ1_YB);
    assign box22on = (BOX2Q_XL <= pixX) && (pixX <= BOX2Q_XR) && (BOXQ2_YT <= pixY) && (pixY <= BOXQ2_YB);
    assign box23on = (BOX2Q_XL <= pixX) && (pixX <= BOX2Q_XR) && (BOXQ3_YT <= pixY) && (pixY <= BOXQ3_YB);
    assign box30on = (BOX3Q_XL <= pixX) && (pixX <= BOX3Q_XR) && (BOXQ0_YT <= pixY) && (pixY <= BOXQ0_YB);
    assign box31on = (BOX3Q_XL <= pixX) && (pixX <= BOX3Q_XR) && (BOXQ1_YT <= pixY) && (pixY <= BOXQ1_YB);
    assign box32on = (BOX3Q_XL <= pixX) && (pixX <= BOX3Q_XR) && (BOXQ2_YT <= pixY) && (pixY <= BOXQ2_YB);
    assign box33on = (BOX3Q_XL <= pixX) && (pixX <= BOX3Q_XR) && (BOXQ3_YT <= pixY) && (pixY <= BOXQ3_YB);
    assign boxOn = box00on | box01on | box02on | box03on | box10on | box11on | box12on | box13on |
                   box20on | box21on | box22on | box23on | box30on | box31on | box32on | box33on;
    
    assign boxmap = (box00on) ? 4'h0 :
                    (box01on) ? 4'h1:
                    (box02on) ? 4'h2:
                    (box03on) ? 4'h3:
                    (box10on) ? 4'h4:
                    (box11on) ? 4'h5:
                    (box12on) ? 4'h6:
                    (box13on) ? 4'h7:
                    (box20on) ? 4'h8:
                    (box21on) ? 4'h9:
                    (box22on) ? 4'ha:
                    (box23on) ? 4'hb:
                    (box30on) ? 4'hc:
                    (box31on) ? 4'hd:
                    (box32on) ? 4'he:
                    (box33on) ? 4'hf: 4'h0;
                    
    always @*
        case (boxmap)
            4'h0    :   data = cr00;
            4'h1    :   data = cr01;
            4'h2    :   data = cr02;
            4'h3    :   data = cr03;
            4'h4    :   data = cr10;
            4'h5    :   data = cr11;
            4'h6    :   data = cr12;
            4'h7    :   data = cr13;
            4'h8    :   data = cr20;
            4'h9    :   data = cr21;
            4'ha    :   data = cr22;
            4'hb    :   data = cr23;
            4'hc    :   data = cr30;
            4'hd    :   data = cr31;
            4'he    :   data = cr32;
            4'hf    :   data = cr33;
        endcase
        
    always @(refr_tick)
        case (data)
            12'd0   :   boxRGB = 12'b1110_0111_1111;
            12'd2   :   boxRGB = 12'b0000_0000_0011;
            12'd4   :   boxRGB = 12'b0000_0000_0111;
            12'd8   :   boxRGB = 12'b0000_0000_1111;
            12'd16  :   boxRGB = 12'b0000_0011_0000;
            12'd32  :   boxRGB = 12'b0000_0111_0000;
            12'd64  :   boxRGB = 12'b0000_1111_0000;
            12'd128 :   boxRGB = 12'b0000_0011_0011;
            12'd256 :   boxRGB = 12'b0000_0111_0111;
            12'd512 :   boxRGB = 12'b0000_0111_1111;
            12'd1024:   boxRGB = 12'b0000_1111_0111;
            12'd2048:   boxRGB = 12'b0000_1111_1111;
            default:    boxRGB = 12'b0000_0000_0000;    // black
        endcase
    //------------------------------------------------------
    // rgb multiplexing circuit
    //------------------------------------------------------
    
    always @*
        if (~videoOn)
            graphRGB = 12'b0000_0000_0000;
        else
            if (titleOn | tbarOn | keyInstrOn)
                graphRGB = titleRGB;
                //graphRGB = 12'b0000_0000_0000;
            else if (gridOn)
                graphRGB = titleRGB;
                //graphRGB = 12'b0000_0000_0000;
            else if (boxOn)
                graphRGB = boxRGB;
            else
                graphRGB = 12'b1111_0000_0000;  // red background
    
endmodule
