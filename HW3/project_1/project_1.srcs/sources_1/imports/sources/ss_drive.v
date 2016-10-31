`timescale 1ns / 1ps

module ss_drive(
    input clk,
    input [3:0] data4,
    input [3:0] data3,
    input [3:0] data2,
    input [3:0] data1,
    input [3:0] data0,
	input [7:0] mask,
    output ssA,
    output ssB,
    output ssC,
    output ssD,
    output ssE,
    output ssF,
    output ssG,
    output ssDP,
    output reg AN7,
    output reg AN6,
    output reg AN5,
    output reg AN4,
    output reg AN3,
    output reg AN2,
    output reg AN1,
    output reg AN0
    );
    
	 
	reg dp;
	reg [2:0] sel;
	reg [3:0] data;
	integer cnt;
	

	always @(posedge clk)
	   /*
		if(rst)
			begin
			cnt <= 0;
			sel <= 3'b000;
			end
		else */
		if (cnt < 2500)
			begin
			cnt <= cnt + 1;
			sel <= sel;
			end
		else 
			begin
			cnt <= 0;
			sel <= sel + 1;
			end

	always @(data4,data3, data2, data1, data0, sel, mask)
		case(sel)
			3'b000 : begin
				data = data0;
				dp = 1;
				AN7 = 1;
                AN6 = 1;
                AN5 = 1;
                AN4 = 1;
				AN3 = 1;
				AN2 = 1;
				AN1 = 1;
				AN0 = 0 | (~mask[0]);
				end
			3'b001 : begin
                data = data1;
                dp = 1;
                AN7 = 1;
                AN6 = 1;
                AN5 = 1;
                AN4 = 1;
                AN3 = 1;
                AN2 = 1;
                AN1 = 0 | (~mask[1]);
                AN0 = 1;
                end
            3'b010 : begin
                data = data2;
                dp = 0;
                AN7 = 1;
                AN6 = 1;
                AN5 = 1;
                AN4 = 1;
                AN3 = 1;
                AN2 = 0 | (~mask[2]);
                AN1 = 1;
                AN0 = 1;
                end                				
			3'b011 : begin
                data = data3;
                dp = 1;
                AN7 = 1;
                AN6 = 1;
                AN5 = 1;
                AN4 = 1;
                AN3 = 0 | (~mask[3]);
                AN2 = 1;
                AN1 = 1;
                AN0 = 1;
                end      
        	3'b100 : begin
                data = data4;
                dp = 1;
                AN7 = 1;
                AN6 = 1;
                AN5 = 1;
                AN4 = 0 | (~mask[4]);
                AN3 = 1;
                AN2 = 1;
                AN1 = 1;
                AN0 = 1;
                end
          default : begin
               data = 4'b0000;
               dp = 1;
               AN7 = 1;
               AN6 = 1;
               AN5 = 1;
               AN4 = 1;
               AN3 = 1;
               AN2 = 1;
               AN1 = 1;
               AN0 = 1;
               end 
		endcase
	
	ss_decoder data_decode (
    .Din(data), 
    .Dp(dp),
    .a(ssA), 
    .b(ssB), 
    .c(ssC), 
    .d(ssD), 
    .e(ssE), 
    .f(ssF), 
    .g(ssG), 
    .dp(ssDP)
    );

		


endmodule
