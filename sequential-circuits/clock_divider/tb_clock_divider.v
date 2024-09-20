`timescale 1ns / 1ps

module tb();
  reg clk, rst;
  wire q;
  
  clock_divider #(4) cd(clk, rst, q);
//  counter c(clk, rst, count);
  
  // 1MHz Clock Signal
  always begin
    #500 clk = ~clk;
  end
  
 task delay;
   input integer time_units;
   
   begin
     # (time_units * 1000);
   end
 endtask
  
//  initial begin
//  $dumpfile("dump.vcd");
//  $dumpvars;
//  #10000; 
//  $finish;
//end
  
  initial begin
    clk = 0;
    
    rst = 1;
    delay(1);
    rst = 0;
    
    delay(22);
    
    rst = 1;
    delay(1);
    rst = 0;
    
    delay(22);
    $finish;
  end
  
endmodule
