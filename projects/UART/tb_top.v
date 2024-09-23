`timescale 1ns / 1ps

module tb_top();
    reg clk_100MHz, rst, load;
    reg [7:0] inData;
    wire [7:0] outData;
    
    top t(clk_100MHz, rst, load, inData, outData);
    
    always #5 clk_100MHz = ~clk_100MHz;
    
    initial begin
        clk_100MHz = 0;
        load = 0;
        inData = 8'b10010110;
        
        rst = 1;
        #(2* 104 * 1000) rst = 0;
        
        #(104 * 1000) load = 1;
        #(104 * 1000) load = 0;
        #(10 * 104 * 1000);
        
        inData = 8'b00110101;
        load = 1;
        #(104 * 1000) load = 0;
        #(10 * 104 * 1000);
        
        $finish;
    end
endmodule
