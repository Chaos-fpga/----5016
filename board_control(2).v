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


module board_control(
    input clk,
    input rst_n,
    input key_r,//初始低电平
    input key_l,//初始低电平
    input fall_down,
    output reg [3:0]board_x,board_y,
    output reg [1:0]life,
    output reg fin
    );
    reg [3:0]xboard_x[0:2];
    wire yboard_y;
    assign yboard_y=4'b0000;
    wire key_r1;
    wire key_l1;
    parameter reset=2'b00;
    parameter right = 2'b01;
    parameter left =2'b10;
    parameter pause=2'b11;
    reg [2:0] currentstate,nextstate;
    always@(posedge clk or negedge rst_n)
    begin
    if(fall_down==1)
        begin
            currentstate<=reset;
        end
    end
    always@(posedge clk or negedge rst_n)
   begin
        if(!rst_n)
            currentstate <= pause;
         else
            currentstate <= nextstate;
   end
    always@(posedge clk or negedge rst_n)
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
                if(xboard_x[2]<9)
                nextstate<=right;
                else if(xboard_x[2]==9)
                nextstate<=pause;
            end
        else if(key_l)
            begin
                if(xboard_x[0]<0)
                nextstate<=left;
                else if(xboard_x[0]==0)
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
                if(xboard_x[2]<9)
                nextstate<=right;
                else if(xboard_x[2]==9)
                nextstate<=pause;
            end
        else if(key_l)
            begin
                if(xboard_x[0]<0)
                nextstate<=left;
                else if(xboard_x[0]==0)
                nextstate<=pause;
            end
        end
        pause:
        begin
        if(!rst_n)
            begin 
                nextstate<=reset;
            end
        else if(xboard_x[0]==0)
            begin
                if(key_l)
                    nextstate<=pause;
                else if(key_r)
                    nextstate<=right;
            end
        else if(xboard_x[2]==9)
            begin
                if(key_l)
                    nextstate<=left;
                else if(key_r)
                    nextstate<=pause;
            end
        end
        endcase
    end//方向控制
    always@(posedge clk or negedge rst_n)
    begin
        case(currentstate)
            reset:
            begin 
                 xboard_x[0]<=4'b0011;
                 xboard_x[1]<=4'b0100;
                 xboard_x[2]<=4'b0101;
             end
             left:
             begin
                 xboard_x[0]<=xboard_x[0]-1'b1;
                 xboard_x[1]<=xboard_x[1]-1'b1;
                 xboard_x[2]<=xboard_x[2]-1'b1;
             end
             right:
             begin
                 xboard_x[0]<=xboard_x[0]+1'b1;
                 xboard_x[1]<=xboard_x[1]+1'b1;
                 xboard_x[2]<=xboard_x[2]+1'b1;
             end
             pause:
             begin
                 xboard_x[0]<=xboard_x[0];
                 xboard_x[1]<=xboard_x[1];
                 xboard_x[2]<=xboard_x[2];
             end
        endcase
     end
    always@(posedge clk or negedge rst_n)
    begin 
        if(!rst_n)  
        begin
            fin <= 1'b0;
            life<=2'b11;
        end
        else if(fall_down&&life!=1) 
        begin
            life<=life-1'b1;
            nextstate<=reset;
        end
        else if(life==1&&fall_down==1)
        begin
            fin<=1'b1;
            life<=life-1'b1;
            nextstate<=reset;
         end
     end//游戏结束判定
     endmodule
        