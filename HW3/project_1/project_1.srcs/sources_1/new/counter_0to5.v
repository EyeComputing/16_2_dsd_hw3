`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/10/29 18:14:49
// Design Name: 
// Module Name: counter_0to5
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


module counter_0to5(
    input clk,
    input rst,
    input inc,
    output TC,
    output reg[3:0] Dout
    );
    
    wire fin;
    // reg first;
    //reg inc;
     /*   
        always@(posedge clk, posedge push)
        begin
        if(push) 
        
        end
       */ 
    reg [3:0] temp_1;
    always @(posedge clk) temp_1 <= rst;
    reg [3:0] temp_2;
    always @(posedge clk) temp_2 <=temp_1;
    reg [3:0] temp_3;
    always @(posedge clk) temp_3 <= temp_2;
        
    always@(posedge clk, posedge temp_3)
    begin
    if(temp_3) Dout <= 4'd0;
    // else if(push) Dout <= Dout;
    else if(inc)
        if(fin) Dout <= 4'd0;
        else  Dout <= Dout +1;
    end
        
    assign fin = (Dout == 4'd5)? 1:0;
    assign TC = fin & inc;
        
    
endmodule
