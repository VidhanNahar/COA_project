module instMEM (clk, reset, address, instRead, data_out, opcode, dest, source1, source2, imm);
input clk, reset, instRead;
input [7:0] address;
output reg [24:0] data_out;
output reg [4:0] opcode;
output reg [3:0] dest;
output reg [3:0] source1;
output reg [3:0] source2;
output reg [7:0] imm;

// reg [24:0] instmemory [0:255];
reg [24:0] instmemory [0:4]; // For Testing

always @(posedge clk)
begin
    if(reset == 1'b1)
        begin
            data_out <= 0;
            opcode <= 0;
            dest <= 0;
            source1 <= 0;
            source2 <= 0;
            imm <= 0;
        end
    else   
        begin
            if(instRead == 1'b1)
                begin
                    data_out <= instmemory[address] [24:0];
                    opcode <= instmemory[address] [24:20];
                    dest <= instmemory[address] [19:16];
                    source1 <= instmemory[address] [15:12];
                    source2 <= instmemory[address] [11:8];
                    imm <= instmemory[address] [7:0];
                end
        end
end

initial
    begin
        $readmemb("inst_mem_file.dat", instmemory);  
    end

endmodule