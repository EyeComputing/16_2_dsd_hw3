`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/10/29 17:44:23
// Design Name: 
// Module Name: top_counter
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


module top_counter(
    input clk,
    input rst,
    input push,
    output [3:0] min,
    output [3:0] sec_1, 
    output [3:0] sec_2,
    output [3:0] msec_1,
    output [3:0] msec_2
    );
    
    
    wire tc0, tc1, tc2, tc3, tc4, tc5;
    
    
    inc_module push_module(
        .clk(clk),
        .push(push),
        .inc(tc0)
        );
    
    CounterTo9 counter_msec_2 (
        .clk(clk),
        .rst(rst),
        .inc(tc0),
        .TC(tc1),
        .Dout(msec_2)
        );
    CounterTo9 counter_msec_1 (
        .clk(clk),
        .rst(rst),
        .inc(tc1),
        .TC(tc2),
        .Dout(msec_1)
        );    
    CounterTo9 counter_sec_1 (
        .clk(clk),
        .rst(rst),
        .inc(tc2),
        .TC(tc3),
        .Dout(sec_1)
        );    
    counter_0to5 counter_sec_2 (
        .clk(clk),
        .rst(rst),
        .inc(tc3),
        .TC(tc4),
        .Dout(sec_2)
        );
    CounterTo9 counter_min (
        .clk(clk),
        .rst(rst),
        .inc(tc4),
        .TC(tc5),
        .Dout(min)
        );        
    
    
endmodule









