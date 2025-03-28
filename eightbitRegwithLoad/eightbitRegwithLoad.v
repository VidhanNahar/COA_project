module eightbitReg (clk, reset, load, data_in, data_out);
    input clk, reset, load;
    input [7:0] data_in;
    output reg [7:0] data_out;

    wire [7:0] Y;
    assign Y = (load == 1'b1) ? data_in : data_out;

    always @(posedge clk ) begin
        if(reset == 1'b1)
            data_out <= 8'b0000_0000;
        else
            data_out <= Y;
    end
endmodule