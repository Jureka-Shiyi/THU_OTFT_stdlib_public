module MAC16_3bx1b(
    input CLK,
    input reset,
    input [2:0] weight1,
    input [2:0] weight2,
    input [2:0] weight3,
    input [2:0] weight4,
    input [2:0] weight5,
    input [2:0] weight6,
    input [2:0] weight7,
    input [2:0] weight8,
    input [2:0] weight9,
    input [2:0] weight10,
    input [2:0] weight11,
    input [2:0] weight12,
    input [2:0] weight13,
    input [2:0] weight14,
    input [2:0] weight15,
    input [2:0] weight16,
    input [15:0] in,
    output reg [6:0] out
);
    always @(posedge CLK) begin
        if (reset) begin
            out <= 0;
        end
        else begin
            out <= {3{in[0]}} & weight1 + {3{in[1]}} & weight2 + {3{in[2]}} & weight3 + {3{in[3]}} & weight4 + {3{in[4]}} & weight5 + {3{in[5]}} & weight6 + {3{in[6]}} & weight7 + {3{in[7]}} & weight8 + {3{in[8]}} & weight9 + {3{in[9]}} & weight10 + {3{in[10]}} & weight11 + {3{in[11]}} & weight12 + {3{in[12]}} & weight13 + {3{in[13]}} & weight14 + {3{in[14]}} & weight15 + {3{in[15]}} & weight16;
        end
    end

endmodule
