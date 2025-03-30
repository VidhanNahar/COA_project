module OUTport (
    input clk,
    input Reset,
    input [7:0] Address,
    input [7:0] Datain,
    input OUTportWrite,
    output reg [7:0] OutExtWorld1,
    output reg [7:0] OutExtWorld2,
    output reg [7:0] OutExtWorld3,
    output reg [7:0] OutExtWorld4
);

    always @(posedge clk or posedge Reset) begin
        if (Reset) begin
            OutExtWorld1 <= 8'b0;
            OutExtWorld2 <= 8'b0;
            OutExtWorld3 <= 8'b0;
            OutExtWorld4 <= 8'b0;
        end else if (OUTportWrite) begin
            case (Address)
                8'h00: OutExtWorld1 <= Datain;
                8'h01: OutExtWorld2 <= Datain;
                8'h02: OutExtWorld3 <= Datain;
                8'h03: OutExtWorld4 <= Datain;
            endcase
        end
    end
endmodule