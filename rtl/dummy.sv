module dummy #( 
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
    input                           s_axi_rresp

);
    reg [63:0][7:0]                 mem;
    reg [7:0]                       mem_addr;
    reg [7:0]                       mem_wdata;
    wire                             write_en;
    wire                            read_en;

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

            if (s_axi_awvalid && s_axi_awready) begin
                mem_addr <= s_axi_awaddr;
            end
            
            if (s_axi_wvalid && s_axi_wready) begin
                mem_wdata   <= s_axi_wdata;
                //write_en    <=  1;

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
    
    assign write_en = s_axi_wvalid && s_axi_wready;
    assign read_en  = s_axi_rvalid && s_axi_rready;

    always_comb begin
        if (write_en)   mem[s_axi_awaddr] = s_axi_wdata;
        if (read_en)    s_axi_rdata = mem[s_axi_araddr];
    end

    // SUBORDINATE RESPONSE FOR MANAGER READING REQUEST
    
    always @(posedge s_axi_clk or negedge s_axi_resetn) begin
        if (~s_axi_resetn) begin
            s_axi_rvalid <= 0;
        end
        else begin
            if (s_axi_arvalid && s_axi_arready) begin
                mem_addr <= s_axi_araddr;
            end

            if (s_axi_arvalid && s_axi_rready) begin // start reading process
                s_axi_rvalid <= 1'b1;
            end

            if (s_axi_rvalid && s_axi_rready) begin
                s_axi_rvalid <= 1'b0;
            end

        end
    end
    

endmodule
/*
    always @(posedge s_axi_clk or negedge s_axi_resetn) begin
        if (~s_axi_resetn) begin
        end
        else begin
        end
    end
    */