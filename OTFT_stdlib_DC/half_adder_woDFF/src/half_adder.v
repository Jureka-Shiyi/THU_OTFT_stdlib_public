module half_adder(
    input CLK,      // 时钟信号
    input in1,      // 输入1
    input in2,      // 输入2
    output reg sum, // 和输出
    output reg cout // 进位输出
);
    always @(posedge CLK) begin
        sum <= in1 ^ in2;  // 异或计算和
        cout <= in1 & in2; // 与计算进位
    end
endmodule


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

