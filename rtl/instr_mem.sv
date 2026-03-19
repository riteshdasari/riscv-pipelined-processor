module instr_mem(
    input logic [31:0] pc_op,
    output logic [31:0] instr
);
//right shift by 2 means integer division by 4(floor) for positive integers 
logic [31:0] mem[0:255];
//verilog is runned by simulators like icarus verilog 
//These simulators has system tasks.
//System tasks in Verilog/SystemVerilog are built-in procedures provided by the simulator, invoked using $, that perform operations outside the hardware model (such as I/O, simulation control, timing, and data initialization), and are generally not synthesizable.
//System tasks can only be executed inside procedural blocks (initial or always).
//An initial block is a procedural block that runs once at the very start of simulation (time = 0).
initial begin 
    int i;
    for (i=0;i<256;i++) begin
    //not supposed to use assign inside procedural block
        mem[i] = 32'h00000000;
    end
//memh indicates that the file is in hexadecimal format. The file should contain the instructions in hexadecimal format, one instruction per line.
    $readmemh("programs/program1.hex",mem);
end 
assign instr = ((pc_op>>2)<256)?mem[pc_op>>2]:32'h00000000;
endmodule