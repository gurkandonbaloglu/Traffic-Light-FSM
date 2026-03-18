module Traffic_top (
    input logic clk_100MHz,
    input logic TAORB,
    input logic reset,
    output logic [5:0] led
);
    wire w_1Hz;

    halfsecond uno (
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .clk_halfsec(w_1Hz)
    );

    Traffic r4 (
        .clk(w_1Hz),
        .rst(reset),
        .TAORB(TAORB),
        .led(led)
    );
endmodule