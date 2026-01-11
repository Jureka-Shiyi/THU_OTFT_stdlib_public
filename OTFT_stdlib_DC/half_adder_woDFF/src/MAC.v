`define NUM_MAC 32
`define BITS_IN 1
`define BITS_WEIGHT 1
`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC) genvar unpk_idx; generate for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) begin; assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; end; endgenerate

module MAC(
    input CLK,
    input reset,
    input [`BITS_IN*`NUM_MAC-1:0] in_packed,
    input [`BITS_WEIGHT*`NUM_MAC-1:0] weight_packed,
    output reg [`BITS_IN+`BITS_WEIGHT+$clog2(`NUM_MAC)-2:0] out
); 
    genvar i;
    integer j;
    wire [`BITS_IN-1:0] in[`NUM_MAC-1:0];
    wire [`BITS_WEIGHT-1:0] weight[`NUM_MAC-1:0];
    wire [`BITS_IN+`BITS_WEIGHT-2:0] out_i[`NUM_MAC-1:0];
    reg [`BITS_IN+`BITS_WEIGHT+$clog2(`NUM_MAC)-2:0] out_s;

    `UNPACK_ARRAY(`BITS_IN, `NUM_MAC, in, in_packed);//_reg);
    `UNPACK_ARRAY(`BITS_WEIGHT, `NUM_MAC, weight, weight_packed);//_reg);

    generate
        if (`BITS_IN == 1) begin
            for(i=0; i<`NUM_MAC; i=i+1) begin
                assign out_i[i] = {`BITS_WEIGHT{in[i]}} & weight[i];
            end
        end
        else begin
            for(i=0; i<`NUM_MAC; i=i+1) begin
                assign out_i[i] = in[i] * weight[i];
            end
        end
    endgenerate

    always @(*) begin
        out_s = 0;
        for(j=0; j<`NUM_MAC; j=j+1) begin
            out_s = out_s + out_i[j];
        end
    end

    always @(posedge CLK) begin
        if(reset) begin
            out <= 0;
        end 
        else begin
            out <= out_s;
        end
    end
endmodule
