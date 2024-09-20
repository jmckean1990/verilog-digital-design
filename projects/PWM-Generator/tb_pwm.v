`timescale 1ns / 1ps

module tb_pwm();
    reg clk, rst;
    wire signal_1, signal_2, signal_3, signal_4, sample_9600, baud_9600_clk;
    
    // 10 kHz frequency, 75% duty cycle
    pwm #(75, 100) pwm1(
        .clk(clk),
        .rst(rst),
        .signal(signal_1)
    );
    
    // 20 kHz frequency, 50% duty cycle
    pwm #(25, 50) pwm2(
        .clk(clk),
        .rst(rst),
        .signal(signal_2)
    );
    
    // 50 kHz frequency, 25% duty cycle
    pwm #(5, 20) pwm3(
        .clk(clk),
        .rst(rst),
        .signal(signal_3)
    );
    
    // 100 kHz frequency, 90% duty cycle
    pwm #(9, 10) pwm4(
        .clk(clk),
        .rst(rst),
        .signal(signal_4)
    );
    
    // 9600 Hz frequency, 50% duty cycle baud clock
    pwm #(52, 104) pwm5(
        .clk(clk),
        .rst(rst),
        .signal(baud_9600_clk)
    );
    
    // 9600 Hz frequency, 1/6% duty cycle
    // 104 / 16 = 6.5
    pwm #(1, 6) pwm6(
        .clk(clk),
        .rst(rst),
        .signal(sample_9600)
    );
    
    // 1 MHz clock 
    always #500 clk = ~clk;
    
    initial begin
        clk = 0;
        
        rst = 1;
        #10;
        rst = 0;
        
        #2_000_000;
        $finish;
    end

endmodule
