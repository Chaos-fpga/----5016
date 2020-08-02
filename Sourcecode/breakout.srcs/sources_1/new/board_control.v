`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/28 14:20:23
// Design Name: 
// Module Name: board_control
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
module board_control(
    input clk,
    input rst_n,
    input key_r,//初始低电平
    input key_l,//初始低电平
    input fall_down,
    output reg [3:0]board_x,
   (* DONT_TOUCH = "1" *)  output reg board_y
    );
    reg [3:0]xboard_x;
    wire yboard_y;
    assign yboard_y=4'b0000;
    wire key_r1;
    wire key_l1;
    parameter reset=2'b00;
    parameter right = 2'b01;
    parameter left =2'b10;
    parameter pause=2'b11;
    reg [1:0] currentstate,nextstate;
    always@(posedge clk)
    begin    
        case(currentstate)
        reset:
        begin
        if(!rst_n)
            begin 
                nextstate<=reset;
            end
        else if(key_r)
            begin
                nextstate<=right;
            end
        else if(key_l)
            begin
                nextstate<=left;
            end
        end
        left:
        begin
        if(!rst_n)
            begin 
                nextstate<=reset;
            end
        else if(key_r)
            begin
                if(xboard_x+1<9)
                nextstate<=right;
                else if(xboard_x+1==9)
                nextstate<=pause;
            end
        else if(key_l)
            begin
                if(xboard_x-1<0)
                nextstate<=left;
                else if(xboard_x-1==0)
                nextstate<=pause;
            end
        end
        right:
        begin
        if(!rst_n)
            begin 
                nextstate<=reset;
            end
        else if(key_r)
            begin
                if(xboard_x+1<9)
                nextstate<=right;
                else if(xboard_x+1==9)
                nextstate<=pause;
            end
        else if(key_l)
            begin
                if(xboard_x-1<0)
                nextstate<=left;
                else if(xboard_x-1==0)
                nextstate<=pause;
            end
        end
        pause:
        begin
        if(!rst_n)
            begin 
                nextstate<=reset;
            end
        else if(xboard_x-1==0)
            begin
                if(key_l)
                    nextstate<=pause;
                else if(key_r)
                    nextstate<=right;
            end
        else if(xboard_x+1==9)
            begin
                if(key_l)
                    nextstate<=left;
                else if(key_r)
                    nextstate<=pause;
            end
        end
        endcase
        if(fall_down)
            nextstate<=reset;
        currentstate<=nextstate;
    end//方向控制
    always@(posedge clk )
    begin
        case(currentstate)
            reset:
            begin 
                 xboard_x<=4'b0011;
             end
             left:
             begin
                 xboard_x<=xboard_x-1'b1;
             end
             right:
             begin
                 xboard_x<=xboard_x+1'b1;
             end
             pause:
             begin
                 xboard_x<=xboard_x;
             end
        endcase
            board_x<=xboard_x; 
     end
     endmodule
        