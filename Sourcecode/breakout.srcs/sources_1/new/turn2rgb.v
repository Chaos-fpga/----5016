`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/01 14:02:46
// Design Name: 
// Module Name: turn2rgb
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

(* keep_hierarchy = "yes" *)
module turn2rgb(
    (* DONT_TOUCH = "1" *) input clk,
    (* DONT_TOUCH = "1" *)  input RGB_VDE,
    input [11:0] CounterX,
    input [11:0] CounterY,
    input [3:0]ball_x,ball_y,
    (* DONT_TOUCH = "1" *) input [9:0]brick_x,brick_y,
    input [3:0]board_x,
   (* DONT_TOUCH = "1" *)  input board_y,
    output reg [23:0] rgb
    );
    reg [7:0] VGA_G_reg,VGA_B_reg,VGA_R_reg;
    always@(*)
    begin
        VGA_R_reg<=8'd255;
        VGA_G_reg<=8'd255;
        VGA_B_reg<=8'd255;
     if((CounterX>=ball_x*192)&&(CounterX<=(ball_x+1)*192)&&(CounterY>=ball_y*108)&&(CounterY<=(ball_y+1)*108))
   begin    VGA_R_reg<=0;                //LCD显示全绿
            VGA_G_reg<=8'd255;
            VGA_B_reg<=0;
   end
   if ((CounterY<=108)&&(CounterX>=0)&&(CounterX<=192))
   begin
        if((brick_x/1000000000)%10==1)
        begin
        VGA_R_reg<=0;            //LCD显示全黑
        VGA_G_reg<=0;
        VGA_B_reg<=0;
        end
        else
        begin
            VGA_R_reg<=8'd255;                //LCD显示全bai
            VGA_G_reg<=8'd255;
            VGA_B_reg<=8'd255;
            end
   end
   if((CounterY<=108)&&(CounterX>=192)&&(CounterX<=384))
   begin
        if((brick_x/100000000)%10==1)
        begin
        VGA_R_reg<=0;            //LCD显示全黑
        VGA_G_reg<=0;
        VGA_B_reg<=0;
        end
        else
        begin
            VGA_R_reg<=8'd255;                //LCD显示全bai
            VGA_G_reg<=8'd255;
            VGA_B_reg<=8'd255;
            end
        end
  if((CounterY<=108)&&(CounterX>=384)&&(CounterX<=576))
   begin
        if((brick_x/10000000)%10==1)
        begin
        VGA_R_reg<=0;            //LCD显示全黑
        VGA_G_reg<=0;
        VGA_B_reg<=0;
        end
        else
        begin
            VGA_R_reg<=8'd255;                //LCD显示全bai
            VGA_G_reg<=8'd255;
            VGA_B_reg<=8'd255;
            end
        end
   if((CounterY<=108)&&(CounterX>=576)&&(CounterX<=768))
   begin
        if((brick_x/1000000)%10==1)
        begin
        VGA_R_reg<=0;            //LCD显示全黑
        VGA_G_reg<=0;
        VGA_B_reg<=0;
        end
        else
        begin
            VGA_R_reg<=8'd255;                //LCD显示全bai
            VGA_G_reg<=8'd255;
            VGA_B_reg<=8'd255;
            end
        end
   if((CounterY<=108)&&(CounterX>=768)&&(CounterX<=916))
   begin
        if((brick_x/100000)%10==1)
        begin
        VGA_R_reg<=0;            //LCD显示全黑
        VGA_G_reg<=0;
        VGA_B_reg<=0;
        end
        else
        begin
            VGA_R_reg<=8'd255;                //LCD显示全bai
            VGA_G_reg<=8'd255;
            VGA_B_reg<=8'd255;
            end
        end
   if((CounterY<=108)&&(CounterX>=916)&&(CounterX<=1152))
   begin
        if((brick_x/10000)%10==1)
        begin
        VGA_R_reg<=0;            //LCD显示全黑
        VGA_G_reg<=0;
        VGA_B_reg<=0;
        end
        else
        begin
            VGA_R_reg<=8'd255;                //LCD显示全bai
            VGA_G_reg<=8'd255;
            VGA_B_reg<=8'd255;
            end
        end
   if((CounterY<=108)&&(CounterX>=1152)&&(CounterX<=1344))
   begin
        if((brick_x/1000)%10==1)
        begin
        VGA_R_reg<=0;            //LCD显示全黑
        VGA_G_reg<=0;
        VGA_B_reg<=0;
        end
        else
        begin
            VGA_R_reg<=8'd255;                //LCD显示全bai
            VGA_G_reg<=8'd255;
            VGA_B_reg<=8'd255;
            end
        end
   if((CounterY<=108)&&(CounterX>=1344)&&(CounterX<=1536))
   begin
        if((brick_x/100)%10==1)
        begin
        VGA_R_reg<=0;            //LCD显示全黑
        VGA_G_reg<=0;
        VGA_B_reg<=0;
        end
        else
        begin
            VGA_R_reg<=8'd255;                //LCD显示全bai
            VGA_G_reg<=8'd255;
            VGA_B_reg<=8'd255;
            end
        end  
   if((CounterY<=108)&&(CounterX>=1536)&&(CounterX<=1728))
   begin
        if((brick_x/10)%10==1)
        begin
        VGA_R_reg<=0;            //LCD显示全黑
        VGA_G_reg<=0;
        VGA_B_reg<=0;
        end
        else
        begin
            VGA_R_reg<=8'd255;                //LCD显示全bai
            VGA_G_reg<=8'd255;
            VGA_B_reg<=8'd255;
            end
        end  
   if((CounterY<=108)&&(CounterX>=1728)&&(CounterX<=1920))
   begin
        if((brick_x/1)%10==1)
        begin
        VGA_R_reg<=0;            //LCD显示全黑
        VGA_G_reg<=0;
        VGA_B_reg<=0;
        end
        else
        begin
            VGA_R_reg<=8'd255;                //LCD显示全bai
            VGA_G_reg<=8'd255;
            VGA_B_reg<=8'd255;
            end
        end
    if((CounterY<=1080)&&(CounterY>=972)&&(CounterX>=(board_x-1)*192)&&(CounterX<=(board_x+1)*192))  
    begin     
			     VGA_R_reg<=0;                         //LCD显示全蓝
                 VGA_G_reg<=0;
                 VGA_B_reg<=8'd255;
    end
     rgb<={VGA_R_reg,VGA_G_reg,VGA_B_reg};
    end
endmodule
