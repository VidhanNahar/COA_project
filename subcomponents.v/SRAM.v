module SRAM(
    input clk,
    input Reset,
    input [7:0] Address,
    input SRAMRead,
    input SRAMWrite,
    input [7:0] Datain,
    output reg [7:0] Dataout
);

    reg [7:0] datamem [0:255];
    
    always @(posedge clk or posedge Reset) begin
        if (Reset) begin
            Dataout <= 8'b0;
        end
        else if (SRAMRead) begin
            Dataout <= datamem[Address];
        end
        else if (SRAMWrite) begin
            datamem[Address] <= Datain;
        end
    end
    
endmodule
