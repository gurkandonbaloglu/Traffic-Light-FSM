module halfsecond (
    input logic clk_100MHz,
    input logic reset,
    output logic clk_halfsec
);
    logic [25:0] r_count = 0;
    logic r_half = 0;

    always_ff @(posedge clk_100MHz or posedge reset) begin
        if(reset)
            r_count <= 26'b0; 
        else begin
            
            if(r_count == 4) begin 
                r_count <= 26'b0;
                r_half <= ~r_half;
            end else begin
                r_count <= r_count + 1;
            end
        end
    end
    assign clk_halfsec = r_half;
endmodule