`timescale 1ns / 1ps

// 8x3 priority encoder with valid(d) output
module tb_priority_encoder();
    reg [7:0] y;
    wire a, b, c, d;
    
    priority_encoder pe(y, a, b, c, d);
    
    initial begin
        y = 8'b00000000;
        #10
        #10 y = 8'b00000001;
        #10 y = 8'b00000011;
        #10 y = 8'b00000101;
        #10 y = 8'b00001001;
        #10 y = 8'b00010001;
        #10 y = 8'b00100001;
        #10 y = 8'b01000001;
        #10 y = 8'b11000001;
        #10 $finish;
        
    end
endmodule