`timescale 1ns / 1ps

`include "SRAM.v"
`include "Stack.v"

module Stack_tb;

    // Inputs
    reg clk;
    reg Reset;
    reg StackRead;
    reg StackWrite;
    reg [7:0] Datain;

    // Outputs
    wire [7:0] Dataout;

    // Instantiate the Stack
    Stack uut (
        .clk(clk),
        .Reset(Reset),
        .StackRead(StackRead),
        .StackWrite(StackWrite),
        .Datain(Datain),
        .Dataout(Dataout)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("Wavedumb.vcd");
        $dumpvars();

        // Initialize inputs
        clk = 0;
        Reset = 1;
        StackRead = 0;
        StackWrite = 0;
        Datain = 0;

        // Apply reset
        #10 Reset = 0;

        // Push 0x11
        #10 StackWrite = 1; Datain = 8'h11;
        #10 StackWrite = 0;

        // Push 0x22
        #10 StackWrite = 1; Datain = 8'h22;
        #10 StackWrite = 0;

        // Push 0x33
        #10 StackWrite = 1; Datain = 8'h33;
        #10 StackWrite = 0;

        // Pop (should get 0x33)
        #10 StackRead = 1;
        #10 StackRead = 0;

        // Pop (should get 0x22)
        #10 StackRead = 1;
        #10 StackRead = 0;

        // Pop (should get 0x11)
        #10 StackRead = 1;
        #10 StackRead = 0;

        #20 $finish;
    end

endmodule
