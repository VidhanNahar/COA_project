module eightbitRegwithLoad(
    input clk,
    input Reset,
    input load,
    input [7:0] Datain,
    output reg [7:0] Dataout
);
    always @(posedge clk or posedge Reset) begin
        if (Reset)
            Dataout <= 8'b0;
        else if (load)
            Dataout <= Datain;
    end
endmodule

module Decoder4to16_withE(
    input [3:0] in,
    input enable,
    output [15:0] out
);
    assign out = (enable) ? (16'b1 << in) : 16'b0;
endmodule

module MUX16to1_8bit(
    input [127:0] in,
    input [3:0] sel,
    output [7:0] out
);
    assign out = in[sel*8 +: 8];  // Verilog slice
endmodule


module RegisterFile(
    input clk,
    input Reset,
    input RegFileRead,
    input RegFileWrite,
    input [7:0] Datain,
    input [3:0] Source1,
    input [3:0] Source2,
    input [3:0] Destin,
    output [7:0] Dataout1,
    output [7:0] Dataout2
);

    wire [15:0] write_enable;
    wire [127:0] reg_out_flat; // 16 registers × 8 bits

    // Decoder instantiation
    Decoder4to16_withE decoder(
        .in(Destin),
        .enable(RegFileWrite),
        .out(write_enable)
    );

    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : reg_inst
            eightbitRegwithLoad reg_instance (
                .clk(clk),
                .Reset(Reset),
                .load(write_enable[i]),
                .Datain(Datain),
                .Dataout(reg_out_flat[i*8 +: 8])  // slice for each 8-bit register
            );
        end
    endgenerate

    // MUXes (assumes you modify MUX16to1_8bit to accept flat vector)
    MUX16to1_8bit mux1(
        .in(reg_out_flat),
        .sel(Source1),
        .out(Dataout1)
    );
    MUX16to1_8bit mux2(
        .in(reg_out_flat),
        .sel(Source2),
        .out(Dataout2)
    );

endmodule
