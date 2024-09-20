`timescale 1ns / 1ps

module top(
    input a, b,cin, 
    output c, s
);
    wire c1, c2, s1;
    half_adder ha1(a, b, c1, s1);
    half_adder ha2(s1, cin, c2, s);
    assign c = c1 | c2;
endmodule
