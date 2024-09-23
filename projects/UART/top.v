`timescale 1ns / 1ps

module top(
    input clk_100MHz, rst, load,
    input [7:0] inData,
    output [7:0] outData
);
    wire bitValue, clock_baud_9600;
    
    clock_divider #(5208) cd(clk_100MHz, rst, clock_baud_9600);
    uart_transmitter ut(clock_baud_9600, rst, load, inData, bitValue);
    uart_receiver ur(clk_100MHz, rst, bitValue, outData);
endmodule
