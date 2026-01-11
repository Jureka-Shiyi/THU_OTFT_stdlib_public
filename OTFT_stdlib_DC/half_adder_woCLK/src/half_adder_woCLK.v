module half_adder_woCLK(
    input reset,   // 保留复位端口
    input in1,
    input in2,
    output reg sum,
    output reg cout
);

// 组合逻辑always块：敏感列表包含reset、in1、in2（或用@(*)自动包含）
always @(*) begin
    if (reset) begin
        sum = 1'b0;    // 复位有效时，输出置0
        cout = 1'b0;
    end else begin
        sum = in1 ^ in2;  // 复位无效时，执行半加器逻辑
        cout = in1 & in2;
    end
end

endmodule