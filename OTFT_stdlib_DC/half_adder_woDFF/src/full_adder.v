module full_adder(
    input CLK,
    input reset,
    input in1,
    input in2,
    input cin,
    output reg sum,
    output reg cout
);
    always @(posedge CLK) begin
        if (reset) begin
            sum <= 0;
	    cout <= 0;
        end
        else begin
            sum <= in1 ^ in2 ^ cin;
            cout <= (in1 & in2) | (in1 & cin) | (in2 & cin);
        end
    end
endmodule

