module axi_lite_manager #(  parameter DATA_WIDTH = 8, 
                            parameter ADDR_WIDTH = 8) 
    (
    input                           m_axi_clk,
    input                           m_axi_resetn,
    // AW CHANNEL
    output reg  [ADDR_WIDTH-1:0]    m_axi_awaddr,
    output reg                      m_axi_awvalid,
    input                           m_axi_awready,
    // W CHANNEL
    output reg  [DATA_WIDTH-1:0]    m_axi_wdata,
    output reg                      m_axi_wvalid,
    input                           m_axi_wready,
    output reg                      m_axi_wlast,
    // B CHANNEL
    output reg                      m_axi_bready,
    input     [1:0]                 m_axi_bresp,
    input                           m_axi_bvalid,
    // AR CHANNEL
    output reg  [ADDR_WIDTH-1:0]    m_axi_araddr,
    output reg                      m_axi_arvalid,
    input                           m_axi_arready,    
    // R CHANNEL
    input      [DATA_WIDTH-1:0]     m_axi_rdata,
    input                           m_axi_rvalid,
    output reg                      m_axi_rready,
    input                           m_axi_rlast,
    output    [1:0]                 m_axi_rresp
    );

    parameter   [1:0]               IDLE    = 2'd0,
                                    START   = 2'd1,
                                    WRITE   = 2'd2,
                                    READ    = 2'd3;

    parameter                       AXI_READ = 0,
                                    AXI_WRITE = 1;

    reg     [1:0]       current_state, next_state;
    reg                 mode;
    reg                 init_transaction, init_transaction_d;
    wire                start;
    reg                 start_write, start_read;
    wire                write_done, read_done;

    reg                 m_axi_berror;
    reg                 m_axi_rerror;

    always @(posedge m_axi_clk or negedge m_axi_resetn) begin
        if (~m_axi_resetn) begin
            init_transaction_d = 1'd0;
            init_transaction   = 1'd0;
        end
        else begin
            init_transaction_d = init_transaction;
        end
    end

    assign write_done   = m_axi_bready && m_axi_bvalid;
    assign read_done    = m_axi_rready && m_axi_rvalid;
    assign start        = init_transaction & ~init_transaction_d;

    always @(posedge m_axi_clk or negedge m_axi_resetn) begin
        if (~m_axi_resetn) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        start_read = 0;
        start_write = 0;
        next_state = current_state;
        case(current_state)

            IDLE: begin
                if (start)
                    next_state = START;
                else
                    next_state = IDLE;
            end

            START: begin
                if (mode==AXI_WRITE) begin
                    next_state = WRITE;
                    start_write = 1'b1;
                end
                else if (mode==AXI_READ) begin
                    next_state = READ;
                    start_read = 1'b1;
                end
                else
                    next_state = START;
            end

            WRITE: begin
                if (write_done) begin
                    next_state = IDLE;
                end
            end

            READ: begin
                if (read_done) begin
                    next_state = IDLE;
                end
            end

        default: next_state = current_state;

        endcase
    end

    // AW channel interface

    always @(posedge m_axi_clk or negedge m_axi_resetn) begin
        if (~m_axi_resetn) begin
            m_axi_awvalid <= 1'd0;
        end
        else begin
            // Set m_axi_awvalid on only in write transaction
            // and when m_axi_awready is on, clear this bit
            // At this point, we will wait to stop AXI WRITE ADDRESS
            // handshake by capture axi_awready and axi_awvalid.
            // Handshakes finishes when these signals active at the same time

            if (start_write)
                m_axi_awvalid <= 1'b1;

            if (m_axi_awready&&m_axi_awvalid)
                m_axi_awvalid <= 1'b0;

        end
    end

    // W channel interface

    always @(posedge m_axi_clk or negedge m_axi_resetn) begin
        if (~m_axi_resetn) begin
            m_axi_wvalid <= 1'b0;
        end
        else begin
            if (start_write)
                m_axi_wvalid <= 1'b1;

            if (m_axi_wready&&m_axi_wvalid)
                m_axi_wvalid <= 1'b0;
        end
    end   

    // B channel interface

    always @(posedge m_axi_clk or negedge m_axi_resetn) begin
        if (~m_axi_resetn) begin
            m_axi_bready <= 1'b0;
        end
        else begin
            // always ready to receive response
            m_axi_bready <= 1'b1;
            // check error
            if (m_axi_bvalid && m_axi_bready) begin
                if (m_axi_bresp > 0) begin
                    m_axi_berror <= 1'd1;
                end
                else begin
                    m_axi_berror <= 1'd0;
                end
            end

        end
    end 

    // AR channel interface

    always @(posedge m_axi_clk or negedge m_axi_resetn) begin
        if (~m_axi_resetn) begin
            m_axi_arvalid <= 1'd0;
        end
        else begin

            if (start_read)
                m_axi_arvalid <= 1'b1;

            if (m_axi_arready&&m_axi_arvalid)
                m_axi_arvalid <= 1'b0;

        end
    end

    // R channel interface

    always @(posedge m_axi_clk or negedge m_axi_resetn) begin
    if (~m_axi_resetn) begin
        m_axi_rready <= 1'd0;
    end
    else begin
        // always ready to receive data
        m_axi_rready <= 1'd1;
        // check error
            if (m_axi_rvalid && m_axi_rready) begin
                if (m_axi_rresp > 0) begin
                    m_axi_rerror <= 1'd1;
                end
                else begin
                    m_axi_rerror <= 1'd0;
                end
            end
        end
    end

    task write(input reg [ADDR_WIDTH-1:0] addr, input reg [DATA_WIDTH-1:0] wdata);
        begin
            mode            = AXI_WRITE;
            m_axi_awaddr    = addr;
            m_axi_wdata     = wdata;
            @(posedge m_axi_clk);
            init_transaction = 1;
            fork
                begin // thread 1
                    wait(write_done);
                    $display("At %0t, Write data %0h to address %0h", $time, wdata, addr);
                end

                begin // thread 2
                    #300;
                    $display("At %0t, Writing access is hanging --FAIL-- ", $time);
                end
            join_any
            disable fork;
            init_transaction = 0;
        end
    endtask

    task read(input reg [ADDR_WIDTH-1:0] addr, output reg [DATA_WIDTH-1:0] rdata);
        begin
            mode            = AXI_READ;
            m_axi_araddr    = addr;
            @(posedge m_axi_clk);
            init_transaction = 1;
            fork
                begin // thread 1
                    wait(read_done);
                    // $display("At %0t, Read data from address %0h", $time, addr);
                end

                begin // thread 2
                    #300;
                    $display("At %0t, Reading access is hanging --FAIL-- ", $time);
                end
            join_any
            disable fork;
            @(posedge m_axi_clk);
            rdata = m_axi_rdata;
            $display("At %0t, Read data %0h from address %0h", $time, rdata,addr);
            init_transaction = 0;
        end
    endtask

endmodule
