module adder_4(
    input CLK,
    input reset,
    input [7:0] in1, 
    input [7:0] in2,
    input [7:0] in3,
    input [7:0] in4,
    output reg [10:0] out
);
    always @(posedge CLK) begin
        if (reset) begin
            out <= 0;
        end
        else begin
            out <= in1 + {in2, 1'b0} + {in3, 2'b0} + {in4, 3'b0};
        end
    end

endmodule
