`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 12:05:54
// Design Name: 
// Module Name: brick_control
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


module brick_control(
    input clk,rst_n,
    input ball_x,ball_y,
    output reg [9:0]brick_x,brick_y
    );
    reg orginal_x=10'b1111111111;
    always@(posedge clk or negedge rst_n)
    if(ball_y==8)
        begin
            if((orginal_x/(2'b10^(ball_x)))%2'b10==1)
                begin
                    orginal_x<=orginal_x-2'b10^(ball_x);
                end
            else
                begin
                    orginal_x<=orginal_x;
                end
            brick_x<=orginal_x;
            brick_y<=4'b1001;
        end
     else
        begin
            brick_x<=orginal_x;
            brick_y<=4'b1001;
        end
endmodule
