`timescale 1ns / 1ps

module inc_module(
    input clk,
    input push,
    output reg inc
    );    

    reg [3:0] temp_1;
    always @(posedge clk) temp_1 <= push;
    reg [3:0] temp_2;
    always @(posedge clk) temp_2 <=temp_1;
    reg [3:0] temp_3;
    always @(posedge clk) temp_3 <= temp_2;
    
    reg isClicked = 1'b0;
    
    always @(posedge clk, posedge temp_3)
    begin
    if(temp_3) begin
        if(isClicked) begin
            inc <= 1'b1;
            isClicked <= 1'b0;
            end
        else begin
            inc <= 1'b0;
            isClicked <= 1'b1;
            end
        end
    end
endmodule
