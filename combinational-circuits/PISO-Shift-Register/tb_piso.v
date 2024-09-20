`timescale 1ns / 1ps

module tb_piso();
    reg clk, load;
    wire out;
    reg [7:0] data1 = 8'b10010110, data2 = 8'b01101001;
    
    piso ps_reg(
        .clk(clk),
        .load(load),
        .data(data2),
        .value(out));
    
    always #10 clk = ~clk;
    
    initial begin
        clk = 1'b0;
        load = 1'b1;
        #40;
        load = 1'b0;
        
        #(9*20);
        #(9*20);
        
        $finish;
    end
endmodule
