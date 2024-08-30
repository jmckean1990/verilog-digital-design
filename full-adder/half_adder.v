`timescale 1ns / 1ps

/////////////////
// Entity
module half_adder(
    input a, b,
    output c, s);
/////////////////

/////////////////
// Architecture
    assign c = a & b;
    assign s = a ^ b;
/////////////////
endmodule