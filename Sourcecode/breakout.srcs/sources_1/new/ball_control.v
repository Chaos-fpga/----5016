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
    input launch,//�õ͵�ƽ
    output reg fall_down=1'b0,
    output reg [3:0]bball_x,bball_y,
    output reg fin,life
    );
    reg [3:0] ball_x,ball_y;
    reg [2:0] currentstate,nextstate,fstate;  
    parameter pause=4'b000;
    parameter hit_a=4'b001;//��ǽ�ϵ���
    parameter hit_b=4'b010;//��ǽ�µ���
    parameter hit_c=4'b011;//��ǽ�ϵ���
    parameter hit_d=4'b100;//��ǽ�µ���
    parameter fall=4'b101;//����
    parameter fill=4'b110;//�Ϸ�û��ש��ʱ�������
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
            hit_a://A����
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
            hit_b://B����
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
            hit_c://C����
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
            hit_d://D����
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
                    if(!rst_n) //��������                   
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
                                 fin<=1'b1;//��Ϸ����
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