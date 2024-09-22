`timescale 1ns / 1ps

module tb_uart_receiver();
    reg clk, rst, dataValue;
    wire [7:0] data;

    uart_receiver ur(clk, rst, dataValue, data);

    always #500 clk = ~clk;

    initial begin
        clk = 0;
        dataValue = 1;

        rst = 1;
        #1000;
        rst = 0;
        #4000;

        // start bit
        dataValue = 0;
        
        #(104 * 1000) dataValue = 1;
        #(104 * 1000) dataValue = 0;
        #(104 * 1000) dataValue = 1;
        #(104 * 1000) dataValue = 0;
        #(104 * 1000) dataValue = 0;
        #(104 * 1000) dataValue = 1;
        #(104 * 1000) dataValue = 1;
        #(104 * 1000) dataValue = 0;
        
        // stop bit
        #(104 * 1000) dataValue = 1;

        // start bit
        #(104 * 1000) dataValue = 0;
        
        #(104 * 1000) dataValue = 1;
        #(104 * 1000) dataValue = 1;
        #(104 * 1000) dataValue = 1;
        #(104 * 1000) dataValue = 1;
        #(104 * 1000) dataValue = 0;
        #(104 * 1000) dataValue = 0;
        #(104 * 1000) dataValue = 1;
        #(104 * 1000) dataValue = 1;
        
        // stop bit
        #(104 * 1000) dataValue = 1;


        $finish;
    end
endmodule