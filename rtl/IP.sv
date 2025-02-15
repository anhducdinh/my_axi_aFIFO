module IP#( 
        parameter DATA_WIDTH = 8, 
        parameter ADDR_WIDTH = 8
    )
    (
        //input       [ADDR_WIDTH-1:0]    address,
        input       [ADDR_WIDTH-1:0]    r_addr,
        input       [ADDR_WIDTH-1:0]    w_addr,
        input       [DATA_WIDTH-1:0]    wdata,
        output reg  [DATA_WIDTH-1:0]    rdata,

        input                           csr_read_enable,
        input                           csr_write_enable
    );

    reg [63:0][7:0]             mem;

    always_comb begin
        if (csr_write_enable)   mem[w_addr] = wdata;
        if (csr_read_enable)    rdata = mem[r_addr];
    end



endmodule