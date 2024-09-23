`timescale 1ns / 1ps

module uart_receiver(
    input clk_1MHz, rst,
    input dataValue,
    output [7:0] data
);
    // 100MHz clock --> baud period of 10416us, 10416 counts per period
    localparam BAUD_RATE = 9600;
    localparam BOARD_CLOCK = 100_000_000;
    localparam BAUD_CLOCK_PERIOD = BOARD_CLOCK / BAUD_RATE;     
    localparam BAUD_HALF_PERIOD = BAUD_CLOCK_PERIOD / 2;

    localparam ST_IDLE = 0;
    localparam ST_RECEIVING = 1;
    localparam ST_STOP = 2;

    reg [1:0] state, nextState;
    reg [15:0] count;
    reg count_CE;
    reg [3:0] bitCount, nextBitCount;
    reg [7:0] dataBuffer, nextDataBuffer;

    assign data = dataBuffer;

    always @(posedge clk_1MHz) begin
        if(rst) begin
            state <= ST_IDLE;
            count <= 16'b0;
            dataBuffer <= 8'b0;
            bitCount <= 3'b0;
            count_CE <= 1'b0;
        end
        else begin
            state <= nextState;
            dataBuffer <= nextDataBuffer;
            bitCount = nextBitCount;

            if(count_CE) begin
                count <= count + 1;
            end
            else begin
                count <= 16'b0;
            end
        end
    end

    always @(*) begin
        nextState = state;
        nextDataBuffer = dataBuffer;
        nextBitCount = bitCount;
        // count_CE = 1'b0;

        case(state) 
            ST_IDLE: begin
                // when dataValue goes low start receiving
                // start of the positive edge of the baud clock
                if(dataValue == 0) begin
                    count_CE = 1'b1;
                end
                
                // delay until end of baud period to transition
                if(count == BAUD_CLOCK_PERIOD - 1) begin
                    nextState = ST_RECEIVING;
                    count_CE = 1'b0;
                end
            end
            ST_RECEIVING: begin
                // sample bitValue at half point of baud cycle
                if((bitCount == 8) && (count == BAUD_CLOCK_PERIOD - 1)) begin
                    count_CE = 1'b0;
                    nextState = ST_STOP;
                    nextBitCount = 4'b0;
                end
                else if(count == BAUD_HALF_PERIOD - 1) begin
                    nextDataBuffer = {dataValue, dataBuffer[7:1]};
                    nextBitCount = bitCount + 1;
                end
                else if(count == BAUD_CLOCK_PERIOD - 1) begin
                    count_CE = 1'b0;
                end
                else begin
                    count_CE = 1'b1;
                end
            end
            ST_STOP: begin
                if(count == BAUD_CLOCK_PERIOD -1 ) begin
                    if(dataValue == 1'b1) begin
                        nextState = ST_IDLE;
                        count_CE = 1'b0;
                    end
                end
                else begin
                    count_CE = 1'b1;
                end
            end
        endcase
    end
endmodule