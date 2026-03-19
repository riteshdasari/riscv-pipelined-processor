module alu(
    input logic [31:0] SRCA,
    input logic [31:0] SRCB,
    input logic [2:0] ALUControl,
    output logic [31:0] ALUResult,
    output logic zero
);
//general format for any constant in systemverilog is <size>'<base><value>, where size is the number of bits, base is b for binary, o for octal, d for decimal, and h for hexadecimal, and value is the actual constant value. For example, 32'h00000000 represents a 32-bit hexadecimal constant with the value of zero.
//The zero flag is generated inside the ALU in parallel with the result, avoiding an extra 32-bit comparison outside and keeping the critical path short and efficient.
//There are no explicit flags register in RISCV.Instead: Comparisons are done using instructions (slt, beq, etc.)
//ZERO is often derived internally, not stored globally (following up point for previous point).
always_comb begin 
if(ALUControl==3'b000) ALUResult = SRCA&SRCB;
else if(ALUControl==3'b001) ALUResult = SRCA|SRCB;
else if(ALUControl==3'b010) ALUResult = SRCA+SRCB;
else if(ALUControl==3'b110) ALUResult = SRCA-SRCB;
else if(ALUControl==3'b111) ALUResult = (SRCA<SRCB)?32'h00000001:32'h00000000;
else ALUResult = 32'h00000000;
zero = (ALUResult==32'h00000000)?1'b1:1'b0;
end

endmodule