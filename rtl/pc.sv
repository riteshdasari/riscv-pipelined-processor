module pc(
    input logic clk,
    input logic enb,
    input logic [31:0]nx_pc,
    input logic rst_n,
    output logic [31:0] pc
);
always_ff @(posedge clk) begin
    if(!rst_n){
        pc<=0;
    }else if(enb==1){
        pc<=nx_pc;
end
endmodule
