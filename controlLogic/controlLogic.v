module Mux32to1_1bit(S, I, Y, E);
    input E;
    input [4:0] S;
    input [31:0] I;
    output wire Y;

    assign Y = (E == 1'b1) ? I[S] : 1'b0;
endmodule

module ControlLogic clk, Reset, T1, T2, T3, T4, Zflag, Cflag, Opcode, PCupdate, SRAMRead, SRAMWrite, StackRead, StackWrite, ALUSave, ZflagSave, CflagSave, INportRead, OUTportWrite, RegFileRead, RegFileWrite);
    input clk, Reset, T1, T2, T3, T4, Zflag, Cflag;
    input [4:0] Opcode;
    output wire PCupdate, SRAMRead, SRAMWrite, StackRead, StackWrite, ALUSave, ZflagSave, CflagSave, INportRead, OUTportWrite, RegFileRead, RegFileWrite;

    Mux32to1_1bit inst1(Opcode, 32'h00801000, SRAMWrite, T3);
    Mux32to1_1bit inst3(Opcode, 32'h1fa417fe, ALUSave, T2);
    Mux32to1_1bit inst2(Opcode, 32'h00400800, SRAMRead, T3);
    Mux32to1_1bit inst4(Opcode, 32'h070001fe, ZflagSave, T2);
    Mux32to1_1bit inst5(Opcode, 32'h07e413fe, RegFileRead, T1);
    Mux32to1_1bit inst6(Opcode, 32'h07000110, CflagSave, T1);
    Mux32to1_1bit inst7(Opcode, 32'h07580ffe, RegFileWrite, T4);
    Mux32to1_1bit inst8(Opcode, 32'h00040000, StackWrite, T3);
    Mux32to1_1bit inst9(Opcode, 32'h00200000, OUTportWrite, T3);
    Mux32to1_1bit inst10(Opcode, 32'h00080000, StackRead, T3);
    Mux32to1_1bit inst11(Opcode, 32'h00100000, INportRead, T3);
    Mux32to1_1bit inst12(Opcode, {3'b0, ~Zflag, Zflag, 9'b0, ~Cflag, Cflag, ~Zflag, Zflag, 1'b1, 13'b0}, PCupdate, T4);
endmodule