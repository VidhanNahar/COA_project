module INport (
    input clk,
    input Reset,
    input INportRead,
    input [7:0] InpExtWorld1,
    input [7:0] InpExtWorld2,
    input [7:0] InpExtWorld3,
    input [7:0] InpExtWorld4,
    input [7:0] Address,
    output reg [7:0] Dataout
);

    always @(posedge clk or posedge Reset) begin

        if (Reset)
            Dataout <= 8'b0;
        
        else if (INportRead) begin
            case (Address)
                8'h00: Dataout <= InpExtWorld1;
                8'h01: Dataout <= InpExtWorld2;
                8'h02: Dataout <= InpExtWorld3;
                8'h03: Dataout <= InpExtWorld4;
                default: Dataout <= 8'b0;
            endcase
        end
    end
endmodule