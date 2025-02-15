module axi_sub_read_interface #( 
        parameter DATA_WIDTH = 8, 
        parameter ADDR_WIDTH = 8
    )
    (
    input                           s_axi_clk,
    input                           s_axi_resetn,
    // AR CHANNEL
    input       [ADDR_WIDTH-1:0]    s_axi_araddr,
    input                           s_axi_arvalid,
    output reg                      s_axi_arready,    
    // R CHANNEL
    output reg  [DATA_WIDTH-1:0]    s_axi_rdata,
    output reg                      s_axi_rvalid,
    input                           s_axi_rready,
    output reg                      s_axi_rlast,
    input                           s_axi_rresp,

    // Interract port
    output reg  [ADDR_WIDTH-1:0]    r_addr,
    input       [DATA_WIDTH-1:0]    rdata,

    output reg                      read_enable
);
    wire   access_read;

    always @(posedge s_axi_clk or negedge s_axi_resetn) begin
        s_axi_arready   = 1;
    end

    always @(posedge s_axi_clk or negedge s_axi_resetn) begin
        if (~s_axi_resetn) begin
            s_axi_rvalid <= 0;
        end
        else begin

            if (s_axi_arvalid && s_axi_rready) begin // start reading process
                s_axi_rvalid <= 1'b1;
            end

            if (s_axi_rvalid && s_axi_rready) begin
                s_axi_rvalid <= 1'b0;
            end

        end
    end

    assign read_enable  = s_axi_rvalid  && s_axi_rready;
    assign access_read      = s_axi_rvalid && s_axi_rready;

    assign s_axi_rdata      = (read_enable)?    rdata : 0;
    //assign address_read     = (access_read^access_write)? (s_axi_awaddr&access_write) | (s_axi_araddr&access_read) : 0;
    assign r_addr           = (access_read)? s_axi_araddr : 0;

endmodule