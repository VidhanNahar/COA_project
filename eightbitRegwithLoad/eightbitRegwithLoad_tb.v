module eightbitReg_tb();

reg clk, reset, load;
reg [7:0] data_in;
wire [7:0] data_out;

eightbitReg inst1 (
    .clk(clk),
    .reset(reset),
    .load(load),
    .data_in(data_in),
    .data_out(data_out) 
);

integer i;

always #50 clk = ~clk;

initial begin
    $dumpfile("Wavedump.vcd");
    $dumpvars;

    clk = 1'b0;
    reset = 1'b0;
    load = 1'b0;
    data_in = 8'b0000_0000;

    #70 reset = 1'b1;

    #100 reset = 1'b0;
    data_in = 8'b1000_0001;
    load = 1'b1;

    #100 reset = 1'b0;
    data_in = 8'b0000_0000;
    load = 1'b0;

    #500 $finish;
end

endmodule