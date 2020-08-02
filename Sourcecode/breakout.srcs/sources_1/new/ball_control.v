`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/28 14:45:12
// Design Name: 
// Module Name: ball_control
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
module ball_control(
    input clk,rst_n,
    input [3:0]board_x,
    input board_y,
    input [9:0]brick_x,brick_y,
    (* DONT_TOUCH = "1" *) input key_r,
    (* DONT_TOUCH = "1" *) input key_l,
    input launch,//置低电平
    output reg fall_down=1'b0,
    output reg [3:0]bball_x,bball_y,
    output reg fin,life
    );
    reg [3:0] ball_x,ball_y;
    reg [2:0] currentstate,nextstate,fstate;  
    parameter pause=4'b000;
    parameter hit_a=4'b001;//左墙上到下
    parameter hit_b=4'b010;//左墙下到上
    parameter hit_c=4'b011;//右墙上到下
    parameter hit_d=4'b100;//右墙下到上
    parameter fall=4'b101;//掉落
    parameter fill=4'b110;//上方没有砖块时的球填充
   always@(posedge clk or negedge rst_n)
   begin
        if(!rst_n)
            currentstate <= pause;
         else
            currentstate <= nextstate;
   end
   always@(posedge clk)
   begin 
        case(currentstate)
            pause:
            begin
               if(launch==1)
                    nextstate<=hit_c;
               else
                    nextstate<=pause; 
            end
            hit_a://A类打击
            begin
                if(0==ball_x)
                begin 
                    nextstate<=hit_b;
                end
                else if(1==ball_y&&(board_x-1)<=ball_x&&(board_x+1)>=ball_x)
                begin
                    nextstate<=hit_d;
                end
                else if(1==ball_y&&((board_x-1)>=ball_x||(board_x+1)<=ball_x))
                begin
                     nextstate<=fall;
                     fall_down<=1'b1;
                end
                else
                begin
                    nextstate<=hit_a;
                end
            end
            hit_b://B类打击
            begin
                if(9==ball_x)
                begin 
                    nextstate<=hit_a;
                end
                else if(1==ball_y&&(board_x-1)<=ball_x&&(board_x+1)>=ball_x)
                begin
                    nextstate<=hit_c;
                end
                else if(1==ball_y&&((board_x-1)>=ball_x||(board_x+1)<=ball_x))
                begin
                     nextstate<=fall;
                     fall_down<=1'b1;
                end
                else
                begin
                    nextstate<=hit_b;
                end
            end
            hit_c://C类打击
            begin
                if(9==ball_x)
                begin 
                    nextstate<=hit_d;
                end
                else if(brick_x/(2'b10^(ball_x))%2'b10&&ball_y==brick_y-1'b1)
                begin
                    nextstate<=hit_b;
                end
                else if(~(brick_x/(2'b10^(ball_x))%2'b10)&&ball_y==brick_y-1'b1)
                begin
                    fstate<=hit_c;
                    nextstate<=fill;
                end
                else
                begin
                    nextstate<=hit_c;
                end
            end
            hit_d://D类打击
            begin
                if(0==ball_x)
                begin 
                    nextstate<=hit_c;
                end
                else if(9==ball_y)
                begin
                    nextstate<=hit_a;
                end
                else if(brick_x/(2'b10^(ball_x))%2'b10&&ball_y==brick_y-1'b1)
                begin
                    nextstate<=hit_a;
                end
                else if(~(brick_x/(2'b10^(ball_x))%2'b10)&&ball_y==brick_y-1'b1)
                begin
                    fstate<=hit_d;
                    nextstate<=fill;
                end
                else
                begin
                    nextstate<=hit_d;
                end
            end   
            fall:
             begin
                    fall_down<=1;
                    ball_x<=4'b0100;
                    ball_y<=4'b0001;
                    if(!rst_n) //生命计算                   
                         begin
                               fin <= 1'b0;
                               life<=2'b11;
                         end
                    else if(fall_down&&life!=1) 
                         begin
                               life<=life-1'b1;
                                nextstate<=pause;
                         end
                    else if(life==1&&fall_down==1)
                        begin
                                 fin<=1'b1;//游戏结束
                                life<=life-1'b1;
                                    nextstate<=pause;
                        end
             end    
             fill:
             begin
                   if(fstate==hit_c)
                        nextstate<=hit_b;
                   else if(fstate<=hit_d)
                        nextstate<=hit_a; 
             end          
            endcase
end   
always@(posedge clk)
begin
case(currentstate)
pause:begin bball_x<=board_x;bball_y<=board_y+1'b1;end
hit_a:begin bball_x<=ball_x-1'b1;bball_y<=ball_y-1'b1;    end
hit_b:begin bball_x<=ball_x+1'b1;bball_y<=ball_y-1'b1;    end
hit_c:begin bball_x<=ball_x+1'b1;bball_y<=ball_y+1'b1;    end
hit_d:begin bball_x<=ball_x-1'b1;bball_y<=ball_y+1'b1;    end
fill:begin bball_x<=ball_x;bball_y<=ball_y+1'b1;  end
endcase
end
endmodule
