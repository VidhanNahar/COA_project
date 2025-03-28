module instMem_tb();
  reg clk, reset, instRead;
  reg [7:0] address;
  wire [24:0] data_out;
  wire [4:0] opcode;
  wire [3:0] dest;
  wire [3:0] source1;
  wire [3:0] source2;
  wire [7:0] imm;

  // Instantiate the Module
  instMEM inst1 (
    .clk(clk), 
    .reset(reset), 
    .address(address), 
    .instRead(instRead), 
    .data_out(data_out), 
    .opcode(opcode), 
    .dest(dest), 
    .source1(source1), 
    .source2(source2), 
    .imm(imm)
  );

  integer i;

  // Generate Clock
  always #5 clk = ~clk;

  initial begin
    $dumpfile("Wavedump.vcd");
    $dumpvars;

    // Initialize Signals
    clk = 0;
    reset = 1;
    instRead = 0;
    address = 0;

    // Reset Phase
    #10 reset = 0;
    instRead = 1;

    // Read Instructions and Display
    for (i = 0; i < 5; i = i + 1) begin
      address = i;
      #10; // Allow time for data to settle
      $display("Address=%h Data Out=%b Opcode=%b Dest=%b Src1=%b Src2=%b Imm=%b",
               address, data_out, opcode, dest, source1, source2, imm);
    end

    #20 $finish;
  end
endmodule