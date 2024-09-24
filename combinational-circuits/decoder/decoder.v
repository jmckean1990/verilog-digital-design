`timescale 1ns / 1ps

module decoder(
    input a, enable,
//    output reg y0, y1
    output y0, y1
);
    // generates two and gates
    assign y0 = (enable & ~a) ? 1'b1 : 1'b0;
    assign y1 = (enable & a) ? 1'b1 : 1'b0;
    
    // generates three mux gates
//    always @* begin
//        if(!enable) begin
//            y0 = 1'b0;
//            y1 = 1'b0;
//        end
//        else begin
//            if(!a) begin
//                y0 = 1'b1;
//                y1 = 1'b0;
//            end
//            else begin
//                y0 = 1'b0;
//                y1 = 1'b1;
//            end
//        end
//    end
endmodule
