`timescale 1ns/1ps

module tb_mips_decoder;

    reg [31:0] instruction;
    wire RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
    wire [1:0] ALUOp;

    // Instantiate the decoder
    mips_decoder uut (
        .instruction(instruction),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    initial begin
        // Setup for waveform dump
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_mips_decoder);

        $display("Time\tOpcode\t\tRegDst ALUSrc MemtoReg RegWrite MemRead MemWrite Branch ALUOp");
        $monitor("%0dns\t%h\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%02b",
            $time, instruction[31:26], RegDst, ALUSrc, MemtoReg,
            RegWrite, MemRead, MemWrite, Branch, ALUOp);

        // Apply different MIPS instructions

        // R-type (e.g., add $t1, $t2, $t3) – opcode = 0
        instruction = 32'b000000_01010_01011_01001_00000_100000;
        #10;

        // lw (e.g., lw $t0, 4($t1)) – opcode = 100011
        instruction = 32'b100011_01001_01000_0000000000000100;
        #10;

        // sw (e.g., sw $t0, 4($t1)) – opcode = 101011
        instruction = 32'b101011_01001_01000_0000000000000100;
        #10;

        // beq (e.g., beq $t1, $t2, label) – opcode = 000100
        instruction = 32'b000100_01001_01010_0000000000000010;
        #10;

        $finish;
    end

endmodule
