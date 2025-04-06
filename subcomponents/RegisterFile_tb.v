`timescale 1ns / 1ps

module RegisterFile_tb;

    // Inputs
    reg clk;
    reg Reset;
    reg RegFileRead;
    reg RegFileWrite;
    reg [7:0] Datain;
    reg [3:0] Source1;
    reg [3:0] Source2;
    reg [3:0] Destin;

    // Outputs
    wire [7:0] Dataout1;
    wire [7:0] Dataout2;

    // Instantiate the Unit Under Test (UUT)
    RegisterFile uut (
        .clk(clk),
        .Reset(Reset),
        .RegFileRead(RegFileRead),
        .RegFileWrite(RegFileWrite),
        .Datain(Datain),
        .Source1(Source1),
        .Source2(Source2),
        .Destin(Destin),
        .Dataout1(Dataout1),
        .Dataout2(Dataout2)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns clock period

    initial begin
        $dumpfile("Wavedumb.vcd");
        $dumpvars()
        // Initialize Inputs
        clk = 0;
        Reset = 1;
        RegFileRead = 0;
        RegFileWrite = 0;
        Datain = 0;
        Source1 = 0;
        Source2 = 0;
        Destin = 0;

        // Reset the system
        #10 Reset = 0;

        // Write value 8'hAA into register 3
        #10 RegFileWrite = 1;
            Datain = 8'hAA;
            Destin = 4'd3;
        #10 RegFileWrite = 0;

        // Write value 8'h55 into register 7
        #10 RegFileWrite = 1;
            Datain = 8'h55;
            Destin = 4'd7;
        #10 RegFileWrite = 0;

        // Read from register 3 and 7
        #10 RegFileRead = 1;
            Source1 = 4'd3;
            Source2 = 4'd7;
        #10 RegFileRead = 0;

        // Check output in waveform
        #20 $finish;
    end

endmodule