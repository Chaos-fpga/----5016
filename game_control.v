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
    input clk,
    input rst_n,
    //input strike_brick,
    //input strike_board,
    input fall_down,
    output [1:0]game_status
    );
    wire status;
    parameter Idle=2'b00;
    parameter Start=2'b01;
    parameter Pause=2'b10;
    reg[1:0] next_status;
always@(posedge clk or negedge rst_n)
        begin
        if(rst_n)
            begin
            case(status)
                Idle: begin
                    if(rst_n) begin next_status=Start; end
                    else begin next_status=Start; end
                    end
                Start: begin
                    if(rst_n) begin next_status=Pause; end
                    else begin next_status=Start; end
                    end
                Pause: begin
                    if(rst_n) begin next_status=Start; end
                    else begin next_status=Start; end
                    end
            endcase
            end
        else if(fall_down) 
begin next_status=Idle;end
end
endmodule
