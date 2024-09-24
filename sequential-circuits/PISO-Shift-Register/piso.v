`timescale 1ns / 1ps

module piso(
    input clk, load,
    input [7:0] data,
    output reg value
);
    reg [7:0] temp;
    
    always @(posedge clk) begin
        if(load) begin
            temp <= data;     
            value <= 1'b0;   
        end
        else begin
//            value <= temp[0];
//            temp = {1'b1, temp[7:1]};
            
            value <= temp[0];
            temp <= temp >> 1;
            temp[7] <= 1'b1;
            
//            temp[7] <= 1'b1;
//            temp[6] <= temp[7];
//            temp[5] <= temp[6];
//            temp[4] <= temp[5];
//            temp[3] <= temp[4];
//            temp[2] <= temp[3];
//            temp[1] <= temp[2];
//            temp[0] <= temp[1];
//            value <= temp[0];
        end
    end
endmodule


