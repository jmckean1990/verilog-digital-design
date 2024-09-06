`timescale 1ns / 1ps

module counter #(parameter DIVIDER = 2)(
	input clk, rst,
  	output [31:0] count
);
  
  reg [31:0] temp = 32'b0;
  
  always @(posedge clk) begin
    if(rst | temp == DIVIDER - 1) begin
      temp <= 32'b0;
    end
    else begin
    	temp <= temp + 1;
    end
  end
  
  assign count = temp;
  
endmodule

module clock_divider #(parameter DIVIDER = 2)(
	input clk, rst,
  	output reg q
);
  reg state, nextState;
  wire [31:0] count;  
  
  counter #(DIVIDER) pulseCounter(clk, rst, count);
  
  always @(posedge clk) begin
    if(rst) begin
      state <= 0;
    end 
    else begin
    	state <= nextState;
    end
  end
  
  always @(*) begin
    nextState = state;  // default
    
    case(state)
        0: begin
            if(count == DIVIDER - 1) begin
                nextState = 1;
            end 
            q = 1'b0;
        end
        1: begin
            if(count == DIVIDER - 1) begin
                nextState = 0;
            end
            q = 1'b1;
        end
    endcase
  end
  
endmodule
