`timescale 1ns / 1ps

module SRAM_tb;

    // Inputs
    reg clk;
    reg Reset;
    reg [7:0] Address;
    reg SRAMRead;
    reg SRAMWrite;
    reg [7:0] Datain;

    // Output
    wire [7:0] Dataout;

    // Instantiate the Unit Under Test (UUT)
    SRAM uut (
        .clk(clk),
        .Reset(Reset),
        .Address(Address),
        .SRAMRead(SRAMRead),
        .SRAMWrite(SRAMWrite),
        .Datain(Datain),
        .Dataout(Dataout)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Enable waveform dump
        $dumpfile("Wavedumb.vcd");
        $dumpvars()

        // Initialize inputs
        clk = 0;
        Reset = 1;
        SRAMRead = 0;
        SRAMWrite = 0;
        Address = 0;
        Datain = 0;

        // Reset pulse
        #10 Reset = 0;

        // Write 0xA5 to address 5
        #10 SRAMWrite = 1;
            Address = 8'd5;
            Datain = 8'hA5;
        #10 SRAMWrite = 0;

        // Write 0x3C to address 10
        #10 SRAMWrite = 1;
            Address = 8'd10;
            Datain = 8'h3C;
        #10 SRAMWrite = 0;

        // Read from address 5
        #10 SRAMRead = 1;
            Address = 8'd5;
        #10 SRAMRead = 0;

        // Read from address 10
        #10 SRAMRead = 1;
            Address = 8'd10;
        #10 SRAMRead = 0;

        // Try reading from an uninitialized address (e.g., 20)
        #10 SRAMRead = 1;
            Address = 8'd20;
        #10 SRAMRead = 0;

        #20 $finish;
    end

endmodule
