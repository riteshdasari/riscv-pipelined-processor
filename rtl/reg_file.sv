module regfile(
    input logic clk,
    input logic rst_n,
    input logic [4:0] A1,
    input logic [4:0] A2,
    input logic [4:0] A3,
    input logic [31:0] Wd,
    input logic We,
    output logic [31:0] rd1,
    output logic [31:0] rd2
);
logic [31:0] registers[31:0];
// If register file reads are synchronous:
// Cycle N:    Control signals are generated from instruction, but operands are not ready
// Cycle N+1:  Operands arrive, but control signals now correspond to the next instruction
// Result:     Control and data become misaligned → ALU operates on wrong inputs (incorrect execution)
//Because x0(zero register) must ALWAYS return 0, even if someone tries to write to it, so we put condition of A1==0 instead of direcltly writing to the register file.
assign rd1 = (A1==0)?32'h00000000:registers[A1];
assign rd2 = (A2==0)?32'h00000000:registers[A2];
//In systemverilog , you can write constants in binary,hexadecimal, or decimal format. The prefix 0b indicates binary, 0x indicates hexadecimal, and no prefix indicates decimal. For example, 32'h00000000 represents a 32-bit hexadecimal constant with the value of zero.
//for A3==0 , it would be a zero register and it should not be written to, so we put condition of A3!=0 before writing to the register file.
int i;//prefered declare out of procedural block to avoid multiple declaration error.
always_ff @(posedge clk)begin 
    if(!rst_n)begin
        for(i=0;i<32;i++) registers[i]<=32'h0;
    end
    else if(We && (A3!=0)) registers[A3]<=Wd;
end
endmodule