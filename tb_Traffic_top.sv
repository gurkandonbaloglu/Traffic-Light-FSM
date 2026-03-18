`timescale 1ns / 1ps

module tb_Traffic_top();
    logic clk_100MHz;
    logic TAORB;
    logic reset;
    logic [5:0] led;

    Traffic_top dut (
        .clk_100MHz(clk_100MHz),
        .TAORB(TAORB),
        .reset(reset),
        .led(led)
    );

    always #5 clk_100MHz = ~clk_100MHz; 

    initial begin
        clk_100MHz = 0;
        reset = 1;
        TAORB = 1; // traffic on A street
        
        #50 reset = 0; // release the system
        #200; // street A continues to green
        
        // traffic ends on street A
        TAORB = 0;
        // The yellow light will turn on, count for 5 seconds, then switch to red
        #800; 

        // traffic starts again on street A
        TAORB = 1;
        // B street will turn yellow, count for 5 seconds and turn red
        #800;

        $finish; // finish simulation
    end
endmodule