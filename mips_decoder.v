module mips_decoder(
    input [31:0] instruction,
    output reg RegDst,
    output reg ALUSrc,
    output reg MemtoReg,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch,
    output reg [1:0] ALUOp
);

    wire [5:0] opcode;
    assign opcode = instruction[31:26]; // Bits [31:26] hold the opcode

    always @(*) begin
        // Default all signals to 0
        RegDst    = 0;
        ALUSrc    = 0;
        MemtoReg  = 0;
        RegWrite  = 0;
        MemRead   = 0;
        MemWrite  = 0;
        Branch    = 0;
        ALUOp     = 2'b00;

        case (opcode)
            6'b000000: begin // R-type
                RegDst    = 1;
                ALUSrc    = 0;
                MemtoReg  = 0;
                RegWrite  = 1;
                MemRead   = 0;
                MemWrite  = 0;
                Branch    = 0;
                ALUOp     = 2'b10;
            end
            6'b100011: begin // lw
                RegDst    = 0;
                ALUSrc    = 1;
                MemtoReg  = 1;
                RegWrite  = 1;
                MemRead   = 1;
                MemWrite  = 0;
                Branch    = 0;
                ALUOp     = 2'b00;
            end
            6'b101011: begin // sw
                RegDst    = 1'bx; // Don't care
                ALUSrc    = 1;
                MemtoReg  = 1'bx; // Don't care
                RegWrite  = 0;
                MemRead   = 0;
                MemWrite  = 1;
                Branch    = 0;
                ALUOp     = 2'b00;
            end
            6'b000100: begin // beq
                RegDst    = 1'bx;
                ALUSrc    = 0;
                MemtoReg  = 1'bx;
                RegWrite  = 0;
                MemRead   = 0;
                MemWrite  = 0;
                Branch    = 1;
                ALUOp     = 2'b01;
            end
            default: begin
                // Can add more instructions like addi, slti, etc.
            end
        endcase
    end

endmodule
