module cntrlunit(
    input logic [31:0] ip_instr,
    output logic [3:0] ALUControl,
    output logic Branch,
    output logic MemtoReg,
    output logic MemWrite,
    output logic ALUSrc,
    output logic RegWrite,
    output logic Jump
);
logic [6:0] opcode;
logic [2:0] func3;
logic [6:0] func7;
assign opcode = ip_instr[6:0];
always_comb begin 
    Jump=0;
    Branch=0;
    MemtoReg=0;
    MemWrite=0;
    ALUSrc=0;
    RegWrite=0;
    ALUControl=4'b0000;
if(opcode==7'b0110011)begin//R-type
    func3=ip_instr[14:12];
    func7=ip_instr[31:25];
    Branch=0;
    MemtoReg=0;
    MemWrite=0;
    ALUSrc=0;
    RegWrite=1;
    Jump=0;
    if(func3==3'b000 && func7==7'b0000000) ALUControl=4'b0010;//add
    else if(func3==3'b000 && func7==7'b0100000) ALUControl=4'b0110;//sub
    else if(func3==3'b111) ALUControl=4'b0000;//and
    else if(func3==3'b110) ALUControl=4'b0001;//or
    else if(func3==3'b010) ALUControl=4'b0111;//slt
    else ALUControl=4'b0000;
end else if(opcode==7'b1101111)begin//J-type ( J instruction can be implemented using JAL instruction in RISC-V, which is a J-type instruction that performs an unconditional jump to a target address and saves the return address in a register.)
    Jump=1;
    Branch=0;
    MemtoReg=0;
    MemWrite=0;
    ALUSrc=0;
    RegWrite=1;
    ALUControl=4'b0000;
end else if(opcode==7'b0010011)begin 
    func3=ip_instr[14:12];
    Jump=0;
    Branch=0;
    MemtoReg=0;
    MemWrite=0;
    ALUSrc=1;
    RegWrite=1;
    if(func3==3'b000) ALUControl=4'b0010;//addi
    else if(func3==3'b111) ALUControl=4'b0000;//andi
    else if(func3==3'b110) ALUControl=4'b0001;//ori
    else ALUControl=4'b0000;
end else if(opcode==7'b0000011) begin //I-type (lw)
    Jump=0;
    Branch=0;
    MemtoReg=1;
    MemWrite=0;
    ALUSrc=1;
    RegWrite=1;
    ALUControl=4'b0010;
end else if(opcode==7'b1100111)begin
    Jump=1;
    Branch=0;
    MemtoReg=0;
    MemWrite=0;
    ALUSrc=1;
    RegWrite=1;
    ALUControl=4'b0010;
end else if(opcode==7'b0100011)begin //S-type (sw)
    Jump=0;
    Branch=0;
    MemtoReg=0;
    MemWrite=1;
    ALUSrc=1;
    RegWrite=0;
     ALUControl=4'b0010;
end else if(opcode==7'b1100011)begin
    Jump=0;
    Branch=1;
    MemtoReg=0;
    MemWrite=0;
    ALUSrc=0;
    RegWrite=0;
    ALUControl=4'b0110;
end else if(opcode==7'b0110111)begin
    Jump=0;
    Branch=0;
    MemtoReg=0;
    MemWrite=0;
    ALUSrc=1;
    RegWrite=1;
    ALUControl=4'b0010;
end else if(opcode==7'b0010111)begin
    Jump=0;
    Branch=0;
    MemtoReg=0;
    MemWrite=0;
    ALUSrc=1;
    RegWrite=1;
    ALUControl=4'b0010;
end
end
endmodule