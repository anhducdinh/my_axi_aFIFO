module axi_sub_write_interface #( 
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
    // Interract port
    //output reg  [ADDR_WIDTH-1:0]    address,
    output reg  [ADDR_WIDTH-1:0]    w_addr,
    output reg  [DATA_WIDTH-1:0]    wdata,
    output reg                      write_enable

);
    wire   access_write;

    always @(posedge s_axi_clk or negedge s_axi_resetn) begin
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

    assign write_enable     = s_axi_wvalid  && s_axi_wready;
    assign access_write     = s_axi_awvalid && s_axi_awready;

    assign wdata            = (write_enable)?   s_axi_wdata : 0;
    //assign address_read     = (access_read^access_write)? (s_axi_awaddr&access_write) | (s_axi_araddr&access_read) : 0;
    assign w_addr           = (access_write)? s_axi_awaddr : 0;

endmodule