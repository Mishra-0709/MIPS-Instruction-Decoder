#  MIPS Instruction Decoder – Verilog RTL Design

##  Project Overview

This project implements a **MIPS instruction decoder** in **Verilog**, designed to translate a 32-bit instruction into control signals for a simplified single-cycle MIPS architecture. The decoder extracts the **opcode** field (bits `[31:26]`) and generates key control signals based on instruction type: **R-type**, **load/store**, and **branch** instructions.

Simulation was performed using **EDA Playground**, and **EPWave** was used for waveform inspection.

---

##  Features

-  Supports `R-type`, `lw`, `sw`, `beq` instructions  
-  Outputs all primary control signals:
  - `RegDst`, `ALUSrc`, `MemtoReg`, `RegWrite`, `MemRead`, `MemWrite`, `Branch`, `ALUOp[1:0]`  
-  100% combinational logic  
-  Waveform and output table for verification

---

##  File Structure

| File                 | Description                                |
|----------------------|--------------------------------------------|
| `mips_decoder.v`     | Main RTL design of MIPS instruction decoder |
| `tb_mips_decoder.v`  | Testbench with waveform and instruction inputs |
| `dump.vcd`           | Waveform dump file generated on simulation |

---

##  Instruction Format

All MIPS instructions are 32 bits wide. The **opcode** resides in bits `[31:26]`:
[31:26] Opcode (6 bits)
[25:0] Remaining instruction fields (rs, rt, rd, imm)


---

##  Instruction Decoding Logic

| Opcode (hex) | Binary     | Instruction Type | Meaning       | Control Signal Set |
|--------------|------------|------------------|----------------|---------------------|
| `0x00`       | `000000`   | R-type           | add, sub, etc. | `RegWrite=1`, `ALUOp=10`, `RegDst=1` |
| `0x23`       | `100011`   | Load Word (lw)   | Mem Read      | `RegWrite=1`, `MemRead=1`, `ALUSrc=1` |
| `0x2b`       | `101011`   | Store Word (sw)  | Mem Write     | `MemWrite=1`, `ALUSrc=1` |
| `0x04`       | `000100`   | Branch Equal     | BEQ           | `Branch=1`, `ALUOp=01` |

---

##  Simulation Waveform

###  Instruction Decode Waveform
![image](https://github.com/user-attachments/assets/97f98091-6401-4f6c-9a69-2a147df7bd2c)
![image](https://github.com/user-attachments/assets/2427fff4-f3b2-40ce-af64-38e654c2f22f)


> These show bit-level transitions of instructions and corresponding control signals.

###  Tabular Output from Testbench

![image](https://github.com/user-attachments/assets/7b105f15-3b79-4ae2-b8a6-acc92e1363b3)

###  Observations

- Instruction `0x014B_4820` is decoded as R-type → `RegWrite=1`, `ALUOp=10`, `RegDst=1`
- Instruction `0x8D28_0004` is `lw` → `ALUSrc=1`, `MemRead=1`, `RegWrite=1`
- Instruction `0xAD28_0004` is `sw` → `ALUSrc=1`, `MemWrite=1`
- Instruction `0x112A_0002` is `beq` → `Branch=1`, `ALUOp=01`

---


