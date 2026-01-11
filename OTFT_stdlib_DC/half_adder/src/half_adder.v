module half_adder(
    input CLK,
    input reset,
    input in1,
    input in2,
    output reg sum,
    output reg cout
);
    always @(posedge CLK) begin
        if (reset) begin
            sum <= 0;
	    cout <= 0;
        end
        else begin
            sum <= in1 ^ in2;
            cout <= in1 & in2;
        end
    end
endmodule

