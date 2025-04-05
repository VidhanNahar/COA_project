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
    wire [7:0] reg_out[0:15];
    
    Decoder4to16_withE decoder(.in(Destin), .enable(RegFileWrite), .out(write_enable));
    
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : reg_inst
            eightbitRegwithLoad reg_instance (
                .clk(clk),
                .Reset(Reset),
                .load(write_enable[i]),
                .Datain(Datain),
                .Dataout(reg_out[i])
            );
        end
    endgenerate
    
    MUX16to1_8bit mux1(.in(reg_out), .sel(Source1), .out(Dataout1));
    MUX16to1_8bit mux2(.in(reg_out), .sel(Source2), .out(Dataout2));
    
endmodule
