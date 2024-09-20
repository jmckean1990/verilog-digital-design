`timescale 1ns / 1ps

module priority_encoder(
    input [7:0] y,
    output reg a, b, c, d
);
    always @(*) begin
        if(y[7] == 1) begin
            a = 1; b = 1; c = 1; d = 1;
        end
        else if(y[6] == 1) begin
            a = 1; b = 1; c = 0; d = 1;
        end
        else if(y[5] == 1) begin
            a = 1; b = 0; c = 1; d = 1;
        end
        else if(y[4] == 1) begin
            a = 1; b = 0; c = 0; d = 1;
        end
        else if(y[3] == 1) begin
            a = 0; b = 1; c = 1; d = 1;
        end
        else if(y[2] == 1) begin
            a = 0; b = 1; c = 0; d = 1;
        end
        else if(y[1] == 1) begin
            a = 0; b = 0; c = 1; d = 1;
        end
        else if(y[0] == 1) begin
            a = 0; b = 0; c = 0; d = 1;
        end
        else begin
            a = 0; b = 0; c = 0; d = 0;
        end
    end
endmodule