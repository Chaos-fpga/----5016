`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/28 11:48:37
// Design Name: 
// Module Name: game_control
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


module game_control(
	output TMDS_Tx_Clk_P,  
	output TMDS_Tx_Clk_N,  
	output [2:0]TMDS_Tx_Data_N,   
	output [2:0]TMDS_Tx_Data_P,
    input clk,
    input key_l,key_r,launch
    );
    wire fall_down;
    wire [1:0]game_status;
    wire [3:0]board_x;
    wire board_y;
    wire [3:0]ball_x;
    wire [3:0]ball_y;
    wire [9:0]brick_x;
    wire [9:0]brick_y;
    wire life;
    wire fin;
    wire clk_system;
    wire clk_system5x;
    wire [23:0]RGB_Data;
    wire [23:0]RGB_In;
    wire RGB_HSync;
    wire RGB_VSync;
    wire RGB_VDE;
    wire [11:0]Set_X;
    wire [11:0]Set_Y;
    wire complete;
    clk_wiz_0 clk_10(
        .clk_out1(clk_system),
        .clk_out2(clk_system5x),
        .clk_in1(clk)
    );
    rgb2dvi_0 rgb2dvi(
        .TMDS_Clk_p(TMDS_Tx_Clk_P),
        .TMDS_Clk_n(TMDS_Tx_Clk_N),
        .TMDS_Data_p(TMDS_Tx_Data_P),
        .TMDS_Data_n(TMDS_Tx_Data_N),
        .aRst_n(1),
        .vid_pData(RGB_Data),
        .vid_pVDE(RGB_VDE),
        .vid_pHSync(RGB_HSync),
        .vid_pVSync(RGB_VSync),
        .PixelClk(clk_system),
        .SerialClk(clk_system5x)
     );
     turn2rgb rgb(
        .clk(clk_system),
        .RGB_VDE(RGB_VDE),
        .CounterX(Set_X),
        .CounterY(Set_Y),
        .board_x(board_x),
        .board_y(board_y),
        .brick_x(brick_x),
        .brick_y(brick_y),
        .ball_x(ball_x),
        .ball_y(ball_y),
        .rgb(RGB_In)
        );
    Driver_HDMI Driver_HDMI_0(
        .clk(clk_system), //Clock
        .Rst(1), //Reset signal, low reset
        .Video_Mode(0), //Video format, 0 is 1920*1080@60Hz, [1 is 1280*720@60Hz]
        .RGB_In(RGB_In), //Input data
        .RGB_Data(RGB_Data), //Output Data
        .RGB_HSync(RGB_HSync), //Line signal
        .RGB_VSync(RGB_VSync), //Field signal
        .RGB_VDE(RGB_VDE), //Data valid signal
        .Set_X(Set_X), //Image coordinate X
         .Set_Y(Set_Y) //Image coordinate Y
    );

//    wire pixclk;  
//	wire[7:0]   R,G,B;  
//	wire HS,VS,DE;  
//	wire VGA_HS, VGA_VS, VGA_D;
//	assign VGA_HS   =   HS;  
//	assign VGA_VS   =   VS;  
//	assign  VGA_D   =   {R[7:4],G[7:2],B[7:4]};
//	hdmi_data_gen u0_hdmi 
//	(  
//	    .pix_clk            (pixclk),  
//	    .turn_mode          (key_l),  
//	    .VGA_R              (R),  
//	    .VGA_G              (G),  
//	    .VGA_B              (B),  
//	    .VGA_HS             (HS),  
//	    .VGA_VS             (VS),  
//	    .VGA_DE             (DE)
//	);  
//	wire pixclk_X5;  
//	//wire i2c_clk;  
//	wire lock;  
//	wire[23:0]  RGB;  
//	assign RGB={R,G,B};  
//	HDMI_FPGA_ML_0  u1_hdmi
//	(  
//	   // .i2c_clk            (i2c_clk),  
//	    .PXLCLK_I            (pixclk),  
//	    .PXLCLK_5X_I         (pixclk_X5),  
//	    .LOCKED_I           (lock),  
//	    .RST_N              (lock),  
//	    .VGA_RGB             (RGB),  
//	    .VGA_HS           (HS),  
//	    .VGA_VS           (VS),  
//	    .VGA_DE              (DE),  
//	    .HDMI_CLK_P           (TMDS_Tx_Clk_P),  
//	    .HDMI_CLK_N         (TMDS_Tx_Clk_N),  
//	    .HDMI_D2_P         (TMDS_Tx_Data_P[2]),  
//	    .HDMI_D2_N         (TMDS_Tx_Data_N[2]),  
//	    .HDMI_D1_P         (TMDS_Tx_Data_P[1]),  
//	    .HDMI_D1_N         (TMDS_Tx_Data_N[1]),  
//	    .HDMI_D0_P         (TMDS_Tx_Data_P[0]),  
//	    .HDMI_D0_N         (TMDS_Tx_Data_N[0])  
//	);  
//	clk_wiz_0   u3_clk  
//(  
//    .clk_in1            (clk),  
//    .reset              (1'b1),  
//    .clk_out1           (pixclk),  
//    .clk_out2           (pixclk_X5),  
//   // .clk_out3           (i2c_clk),  
//    .locked             (lock)  
//);  
    ball_control ball_control_1(
             .clk(clk),
            .rst_n(1),
            .key_r(key_r),
            .key_l(key_l),
            .board_x(board_x),
            .board_y(board_y),
            .brick_x(brick_x),
            .brick_y(brick_y),
            .launch(launch),
            .fall_down(fall_down),
             .life(life),
             .fin(fin),
             .bball_x(ball_x),
            .bball_y(ball_y)
    ) ;
    board_control board_control_1(
    .clk(clk),
    .rst_n(1),
    .key_r(key_r),//初始低电平
    .key_l(key_l),//初始低电平
    .fall_down(fall_down),
    .board_x(board_x),
    .board_y(board_y)
    );   
    brick_control brick_control_1(
    .clk(clk),
    .rst_n(1),
    .ball_x(ball_x),
    .ball_y(ball_y),
    .fall_down(fall_down),
    .life(life),
    .complete(complete),
    .brick_x(brick_x),
    .brick_y(brick_y)
    );

endmodule
