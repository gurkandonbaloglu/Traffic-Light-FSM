module Traffic (
    input logic clk,
    input logic rst,
    input logic TAORB,
    output logic [5:0] led
);

    typedef enum bit [1:0] {
        GREENRED = 2'b00,
        YELLOWRED = 2'b01,
        REDGREEN = 2'b10,
        REDYELLOW = 2'b11
    } state_t;

    state_t state_reg, state_next;
    logic [2:0] timer_reg, timer_next; 

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state_reg <= GREENRED;
            timer_reg <= 3'd0;
        end else begin
            state_reg <= state_next;
            timer_reg <= timer_next;
        end
    end

    always_comb begin
        state_next = state_reg;
        timer_next = timer_reg; 
        led = 6'b000000;

        case (state_reg)
            GREENRED: begin
                led = 6'b001100;
                if (!TAORB) begin
                    state_next = YELLOWRED;
                    timer_next = 3'd0;
                end
            end
            YELLOWRED: begin
                led = 6'b010100;
                if (timer_reg < 3'd4) begin
                    timer_next = timer_reg + 1;
                end else begin
                    state_next = REDGREEN;
                    timer_next = 3'd0;
                end
            end
            REDGREEN: begin
                led = 6'b100001;
                if (TAORB) begin
                    state_next = REDYELLOW;
                    timer_next = 3'd0;
                end
            end
            REDYELLOW: begin
                led = 6'b100010;
                if (timer_reg < 3'd4) begin
                    timer_next = timer_reg + 1;
                end else begin
                    state_next = GREENRED;
                    timer_next = 3'd0;
                end
            end
            default: state_next = GREENRED;
        endcase
    end
endmodule