`timescale 1ns / 1ps

module uart_transmitter(
    input clk, rst, load,
    input [7:0] data,
    output reg bitValue
);
    localparam ST_IDLE = 0;
    localparam ST_START = 1;
    localparam ST_TRANSMIT = 2;
    localparam ST_STOP = 3;

    reg [1:0] state, nextState;
    reg [7:0] tempData, nextTempData;
    reg [2:0] bitCount, nextBitCount;

    always @(posedge clk) begin
        if(rst) begin
            state <= ST_IDLE;
            tempData <= 8'b0;
            bitCount <= 3'b0;
        end
        else begin
            state <= nextState;
            tempData <= nextTempData;
            bitCount <= nextBitCount;
        end
    end

    always @(*) begin
        nextState = state;
        nextTempData = tempData;
        nextBitCount = bitCount;
        bitValue = 1'b1;

        case(state) 
            ST_IDLE: begin
                bitValue = 1'b1;
                if(load) begin
                    nextState = ST_START;
                    nextTempData = data;
                end
            end
            ST_START: begin
                bitValue = 1'b0;
                nextState = ST_TRANSMIT;
            end
            ST_TRANSMIT: begin
                bitValue = tempData[0];
                nextTempData = {1'b1, tempData[7:1]};
                nextBitCount = bitCount + 1;

                if(bitCount == 7) begin
                    nextState = ST_STOP;
                end
            end
            ST_STOP: begin
                bitValue = 1'b1;
                nextState = ST_IDLE;
            end
        endcase
    end

endmodule