`timescale 1ns / 1ps

module tb_top();
    reg clk_1MHz, rst, load;
    reg [7:0] inData;
    wire [7:0] outData;
    
    top t(clk_1MHz, rst, load, inData, outData);
    
    always #500 clk_1MHz = ~clk_1MHz;
    
    initial begin
        clk_1MHz = 0;
        load = 0;
        inData = 8'b10010110;
        
        rst = 1;
        #(2* 104 * 1000) rst = 0;
        
        load = 1;
        #(104 * 1000) load = 0;
        #(10 * 104 * 1000);
        
        inData = 8'b00110101;
        load = 1;
        #(104 * 1000) load = 0;
        #(10 * 104 * 1000);
        
        $finish;
    end
endmodule
