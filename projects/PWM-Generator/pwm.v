`timescale 1ns / 1ps

module pwm #(parameter DUTY_CYCLE = 50, MAX_CYCLES = 100)(
    input clk, rst,
    output signal
);
    localparam ST_ZERO = 0;
    localparam ST_ONE = 1;

    reg state, nextState;
    reg [31:0] count, nextCount;
    
    assign signal = (state == ST_ZERO) ? 0 : 1;
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            state <= ST_ZERO;
            count <= 0;
        end
        else begin
            state <= nextState;
            count <= nextCount;
        end
    end
    
    always @(*) begin
        // defaults
        nextCount = count;
        nextState = state;
        
        case(state)
            ST_ZERO: begin
                if(count < MAX_CYCLES - DUTY_CYCLE - 1) begin
                    nextCount = count + 1;
                end
                else begin 
                    nextCount = 0;
                    nextState = ST_ONE;
                end
            end
            
            ST_ONE: begin
                if(count < DUTY_CYCLE - 1) begin
                    nextCount = count + 1;
                end
                else begin 
                    nextCount = 0;
                    nextState = ST_ZERO;
                end
            end
        endcase
    end
endmodule
