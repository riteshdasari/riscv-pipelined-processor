module imm_gen(
    input logic [31:0] ip_instr,
    output logic [31:0] imm_out
);
logic [6:0] opcode;
assign opcode = ip_instr[6:0];
always_comb begin 
    if(opcode==7'b0110011)begin
        imm_out=32'b0;
    end else if(opcode==7'b0010011||opcode==7'b0000011||opcode==7'b1100111)begin
        imm_out={{20{ip_instr[31]}},ip_instr[31:20]};
    end else if(opcode==7'b0100011)begin
        imm_out={{20{ip_instr[31]}},ip_instr[30:25],ip_instr[11:7]};
    end else if(opcode==7'b1100011)begin
        imm_out={{19{ip_instr[31]}},ip_instr[31],ip_instr[7],ip_instr[30:25], ip_instr[11:8],1'b0};
    end else if(opcode==7'b0110111||opcode==7'b0010111)begin
        imm_out={ip_instr[31:12],12'b0};
    end else if(opcode==7'b1101111)begin
        imm_out={{11{ip_instr[31]}},ip_instr[31],ip_instr[19:12],ip_instr[20],ip_instr[30:21],1'b0};
    end else begin
        imm_out=32'b0;
    end
end
endmodule