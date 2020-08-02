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

(* keep_hierarchy = "yes" *)
module brick_control(
    input clk,
    (* DONT_TOUCH = "1" *) input rst_n,
    input [3:0]ball_x,ball_y,
    (* DONT_TOUCH = "1" *) input life,fall_down,
    output reg [9:0]brick_x,brick_y,
    output reg complete
    );
    reg orginal_x=10'b1111111111;
    always@(posedge clk )
    begin
     brick_x<=orginal_x;
     brick_y<=4'b1001;
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
        end
    end
    always@(posedge clk)
        begin
        if(brick_x==0)
        complete<=1;
        end
endmodule
