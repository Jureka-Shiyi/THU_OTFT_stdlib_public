module ring_oscillator (
    input wire CLK,
    input wire reset,
    output reg period
);

    reg [37:0] inverter_chain;
    
    reg start_reg;
    reg end_reg;

    always @(posedge CLK or posedge reset) begin
        if (reset) begin
            start_reg <= 1'b0;
            inverter_chain <= 38'b0;
            end_reg <= 1'b0;
            period <= 1'b0;
        end else begin

            start_reg <= ~start_reg;
            inverter_chain[0] <= start_reg;
            
            inverter_chain[1] <= ~inverter_chain[0];
            inverter_chain[2] <= ~inverter_chain[1];
            inverter_chain[3] <= ~inverter_chain[2];
            inverter_chain[4] <= ~inverter_chain[3];
            inverter_chain[5] <= ~inverter_chain[4];
            inverter_chain[6] <= ~inverter_chain[5];
            inverter_chain[7] <= ~inverter_chain[6];
            inverter_chain[8] <= ~inverter_chain[7];
            inverter_chain[9] <= ~inverter_chain[8];
            inverter_chain[10] <= ~inverter_chain[9];
            inverter_chain[11] <= ~inverter_chain[10];
            inverter_chain[12] <= ~inverter_chain[11];
            inverter_chain[13] <= ~inverter_chain[12];
            inverter_chain[14] <= ~inverter_chain[13];
            inverter_chain[15] <= ~inverter_chain[14];
            inverter_chain[16] <= ~inverter_chain[15];
            inverter_chain[17] <= ~inverter_chain[16];
            inverter_chain[18] <= ~inverter_chain[17];
            inverter_chain[19] <= ~inverter_chain[18];
            inverter_chain[20] <= ~inverter_chain[19];
            inverter_chain[21] <= ~inverter_chain[20];
            inverter_chain[22] <= ~inverter_chain[21];
            inverter_chain[23] <= ~inverter_chain[22];
            inverter_chain[24] <= ~inverter_chain[23];
            inverter_chain[25] <= ~inverter_chain[24];
            inverter_chain[26] <= ~inverter_chain[25];
            inverter_chain[27] <= ~inverter_chain[26];
            inverter_chain[28] <= ~inverter_chain[27];
            inverter_chain[29] <= ~inverter_chain[28];
            inverter_chain[30] <= ~inverter_chain[29];
            inverter_chain[31] <= ~inverter_chain[30];
            inverter_chain[32] <= ~inverter_chain[31];
            inverter_chain[33] <= ~inverter_chain[32];
            inverter_chain[34] <= ~inverter_chain[33];
            inverter_chain[35] <= ~inverter_chain[34];
            inverter_chain[36] <= ~inverter_chain[35];
            inverter_chain[37] <= ~inverter_chain[36];

            end_reg <= ~inverter_chain[37];
            
            period <= end_reg;
        end
    end
endmodule

