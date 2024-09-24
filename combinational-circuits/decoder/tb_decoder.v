`timescale 1ns / 1ps

module tb_decoder();
    reg a, enable;
    wire y0, y1;
    
    decoder d(a, enable, y0, y1);
    
    initial begin
        $monitor("a=%b\tenable=%b\ty0=%b\ty1=%b", a, enable, y0, y1);
        
        a = 0;
        enable = 0;
        
        #10 enable = 1;
        #10 a = 1;
        #10 $finish;
        
    end
endmodule
