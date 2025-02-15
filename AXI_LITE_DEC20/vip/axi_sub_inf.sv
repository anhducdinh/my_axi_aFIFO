module axi_sub_inf #( 
        parameter DATA_WIDTH = 8, 
        parameter ADDR_WIDTH = 8
    )
    (
    input                           s_axi_clk,
    input                           s_axi_resetn,
    // AW CHANNEL
    input       [ADDR_WIDTH-1:0]    s_axi_awaddr,
    input                           s_axi_awvalid,
    output reg                      s_axi_awready,
    // W CHANNEL
    input       [DATA_WIDTH-1:0]    s_axi_wdata,
    input                           s_axi_wvalid,
    output reg                      s_axi_wready,
    input                           s_axi_wlast,
    // B CHANNEL
    input                           s_axi_bready,
    output reg  [1:0]               s_axi_bresp,
    output reg                      s_axi_bvalid,
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
    //output reg  [ADDR_WIDTH-1:0]    address,
    output reg  [ADDR_WIDTH-1:0]    w_addr,
    output reg  [ADDR_WIDTH-1:0]    r_addr,
    output reg  [DATA_WIDTH-1:0]    wdata,
    input       [DATA_WIDTH-1:0]    rdata,

    output reg                      csr_read_enable,
    output reg                      csr_write_enable

);
    wire   access_read, access_write;

    always @(posedge s_axi_clk or negedge s_axi_resetn) begin
        s_axi_arready   = 1;
        s_axi_awready   = 1;
        s_axi_wready    = 1;
    end

    // SUBORDINATE RESPONSE FOR WRITING REQUEST
    always @(posedge s_axi_clk or negedge s_axi_resetn) begin
        if (~s_axi_resetn) begin
            s_axi_bresp <= 2'd0;
            s_axi_bvalid <= 0;
        end
        else begin
            
            if (s_axi_wvalid && s_axi_wready) begin
                if (s_axi_bready) begin
                    s_axi_bresp <= 2'd0;
                    s_axi_bvalid <= 1'b1;
                end
            end

            if (s_axi_bready && s_axi_bvalid) begin
                s_axi_bvalid <= 1'b0;
            end
        end
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

    assign csr_write_enable = s_axi_wvalid  && s_axi_wready;
    assign access_write     = s_axi_awvalid && s_axi_awready;

    assign csr_read_enable  = s_axi_rvalid  && s_axi_rready;
    assign access_read      = s_axi_rvalid && s_axi_rready;


    assign wdata            = (csr_write_enable)?   s_axi_wdata : 0;
    assign s_axi_rdata      = (csr_read_enable)?    rdata : 0;
    //assign address_read     = (access_read^access_write)? (s_axi_awaddr&access_write) | (s_axi_araddr&access_read) : 0;
    assign w_addr           = (access_write)? s_axi_awaddr : 0;
    assign r_addr           = (access_read)? s_axi_araddr : 0;

endmodule