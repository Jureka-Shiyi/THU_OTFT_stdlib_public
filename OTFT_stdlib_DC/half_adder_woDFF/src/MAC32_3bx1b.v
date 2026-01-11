module MAC32_3bx1b(
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
    input [2:0] weight17,
    input [2:0] weight18,
    input [2:0] weight19,
    input [2:0] weight20,
    input [2:0] weight21,
    input [2:0] weight22,
    input [2:0] weight23,
    input [2:0] weight24,
    input [2:0] weight25,
    input [2:0] weight26,
    input [2:0] weight27,
    input [2:0] weight28,
    input [2:0] weight29,
    input [2:0] weight30,
    input [2:0] weight31,
    input [2:0] weight32,
    input [31:0] in,
    output reg [7:0] out
);
    always @(posedge CLK) begin
        if (reset) begin
            out <= 0;
        end
        else begin
            out <= {3{in[0]}} & weight1 + {3{in[1]}} & weight2 + {3{in[2]}} & weight3 + {3{in[3]}} & weight4 + {3{in[4]}} & weight5 + {3{in[5]}} & weight6 + {3{in[6]}} & weight7 + {3{in[7]}} & weight8 + {3{in[8]}} & weight9 + {3{in[9]}} & weight10 + {3{in[10]}} & weight11 + {3{in[11]}} & weight12 + {3{in[12]}} & weight13 + {3{in[13]}} & weight14 + {3{in[14]}} & weight15 + {3{in[15]}} & weight16 + {3{in[16]}} & weight17 + {3{in[17]}} & weight18 + {3{in[18]}} & weight19 + {3{in[19]}} & weight20 + {3{in[20]}} & weight21 + {3{in[21]}} & weight22 + {3{in[22]}} & weight23 + {3{in[23]}} & weight24 + {3{in[24]}} & weight25 + {3{in[25]}} & weight26 + {3{in[26]}} & weight27 + {3{in[27]}} & weight28 + {3{in[28]}} & weight29 + {3{in[29]}} & weight30 + {3{in[30]}} & weight31 + {3{in[31]}} & weight32;
        end
    end

endmodule
