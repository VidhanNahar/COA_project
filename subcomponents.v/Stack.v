`include "SRAM.v"

module Stack(
    input clk,
    input Reset,
    input StackRead,
    input StackWrite,
    input [7:0] Datain,
    output [7:0] Dataout
);

    wire [7:0] sram_out;
    reg [7:0] sp;  // Stack Pointer
    
    SRAM sram_instance(
        .clk(clk),
        .Reset(Reset),
        .Address(sp),
        .SRAMRead(StackRead),
        .SRAMWrite(StackWrite),
        .Datain(Datain),
        .Dataout(sram_out)
    );
    
    assign Dataout = sram_out;
    
    always @(posedge clk or posedge Reset) begin
        if (Reset) begin
            sp <= 8'hFF;  // Initialize Stack Pointer to the top
        end
        else if (StackWrite) begin
            sp <= sp - 1;  // Push
        end
        else if (StackRead) begin
            sp <= sp + 1;  // Pop
        end
    end

endmodule
