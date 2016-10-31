`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/10/29 16:52:01
// Design Name: 
// Module Name: Top_module
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


module Top_module(
    input clk,
    input rst,
    input push,
	output ssA,
    output ssB,
    output ssC,
    output ssD,
    output ssE,
    output ssF,
    output ssG,
    output ssDP,
    output AN0,
    output AN1,
    output AN2,
    output AN3,
    output AN4,
    output AN5,
    output AN6,
    output AN7
    );
    
    wire [3:0] min, sec_1, sec_2, msec_1, msec_2;
    
    top_counter top_counter (
        .clk(clk),
        .rst(rst),
        .push(push),
        .min(min),
        .sec_1(sec_1),
        .sec_2(sec_2),
        .msec_1(msec_1),
        .msec_2(msec_2)
        );
   
    ss_drive counter_ss_drive (
            .clk(clk),
            .data4(min),
            .data3(sec_2),
            .data2(sec_1),
            .data1(msec_1),
            .data0(msec_2),
            .mask('b1111_1111),
            .ssA(ssA),
            .ssB(ssB),
            .ssC(ssC),
            .ssD(ssD),
            .ssE(ssE),
            .ssF(ssF),
            .ssG(ssG),
            .ssDP(ssDP),
            .AN0(AN0),
            .AN1(AN1),
            .AN2(AN2),
            .AN3(AN3),
            .AN4(AN4),
            .AN5(AN5),
            .AN6(AN6),
            .AN7(AN7)
            );
    
    
    
endmodule

















