module rice_encode(
    input CLK,
    input reset,
    input [7:0] data_in,
    input [3:0] k,
    output reg [15:0] code_out,
    output reg valid
);

    integer q, r;
    reg [15:0] temp_code_out;

    always @(posedge CLK or posedge reset) begin
        if (reset) begin
            code_out <= 0;
            valid <= 0;
        end else begin
            q = data_in >> k;
            r = data_in & ((1 << k) - 1);

            temp_code_out = (1 << q) - 1;
            temp_code_out = {temp_code_out, 1'b0, r};

            code_out <= temp_code_out;
            valid <= 1;
        end
    end
endmodule

