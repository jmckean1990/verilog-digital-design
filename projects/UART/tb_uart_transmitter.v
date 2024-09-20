`timescale 1ns / 1ps

module tb_uart_transmitter();
    reg clk, rst, load;
    reg [7:0] data;
    wire bitValue;

    uart_transmitter ut_dut(clk, rst, load, data, bitValue);

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        data = 8'b10010110;
        load = 0;

        rst = 1;
        #10 rst = 0;
        
        load = 1;
        #10; load = 0;
        #80;
        #40;
        
        data = 8'b00001110;
        load = 1;
        #10 load = 0;
        #80;
        #40;
        $finish;
    end
endmodule