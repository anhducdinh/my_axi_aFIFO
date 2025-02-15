module tb();
	parameter ADDR_WIDTH=8;
	parameter DATA_WIDTH=8;

	reg 					axi_resetn; 	
	reg 					axi_clk;    	
	wire [ADDR_WIDTH-1:0]	axi_aw_addr; 	
	wire 					axi_aw_valid;	
	wire 					axi_aw_ready;
	wire [DATA_WIDTH-1:0]	axi_w_data; 	
	wire 					axi_w_valid; 	
	wire 					axi_w_ready; 	
	wire 					axi_w_last; 	
	wire [1:0]				axi_b_resp;  	
	wire 					axi_b_valid; 	
	wire 					axi_b_ready; 	
	wire					axi_b_error;
	wire [ADDR_WIDTH-1:0]	axi_ar_addr;	
	wire 					axi_ar_valid;	
	wire 					axi_ar_ready;	
	wire [DATA_WIDTH-1:0]	axi_r_data;		
	wire [1:0]				axi_r_resp;		
	wire 					axi_r_valid;	
	wire 					axi_r_ready;
	wire					axi_r_error;
	wire					axi_r_last;

	reg  [DATA_WIDTH-1:0] 	wdata, rdata, addr;	
	reg 					w_clk;
	reg  					write_enable;
	reg  [DATA_WIDTH-1:0]	write_data;
	reg 					r_clk;
	reg  					read_enable;
	wire [DATA_WIDTH-1:0]	read_data;

	reg						fail_flag;

	
    fifo_top #(
         .DATA_WIDTH(8)
        ,.ADDR_WIDTH(8)
        )
        DUT 
		(// instance name
        .csr_clk               (axi_clk),
        .csr_resetn            (axi_resetn),
        .csr_awaddr            (axi_aw_addr),
        .csr_awvalid           (axi_aw_valid),
        .csr_awready           (axi_aw_ready),
        .csr_wdata             (axi_w_data),
        .csr_wvalid            (axi_w_valid),
        .csr_wready            (axi_w_ready),
        .csr_wlast             (axi_w_last),
        .csr_bready            (axi_b_ready),
        .csr_bresp             (axi_b_resp),
        .csr_bvalid            (axi_b_valid),
        .csr_araddr            (axi_ar_addr),
        .csr_arvalid           (axi_ar_valid),
        .csr_arready           (axi_ar_ready),    
        .csr_rdata             (axi_r_data),
        .csr_rvalid            (axi_r_valid),
        .csr_rready            (axi_r_ready),
        .csr_rlast             (axi_r_last),
        .csr_rresp             (axi_r_resp),
        .w_clk                 (w_clk),
		.wresetn			   (wresetn),
        .write_enable          (write_enable),
        .write_data            (write_data),
        .r_clk         		   (r_clk),
		.rresetn			   (rresetn),
        .read_enable           (read_enable),
        .read_data             (read_data)

	);
	
    axi_lite_manager
        #(
         .DATA_WIDTH(8)
        ,.ADDR_WIDTH(8)
        ) AXI_MANAGER_0
        (	
        // AW Channel
		 .m_axi_clk      	    (axi_clk    	)
		,.m_axi_resetn      	(axi_resetn 	)
		,.m_axi_awaddr      	(axi_aw_addr 	)
		,.m_axi_awvalid      	(axi_aw_valid	)
		,.m_axi_awready      	(axi_aw_ready	)
							
		//W Channel   	
		,.m_axi_wdata        	(axi_w_data 	)
		,.m_axi_wvalid       	(axi_w_valid 	)
		,.m_axi_wready       	(axi_w_ready 	)
		,.m_axi_wlast        	(axi_w_last 	)
		
		//B Channel
		,.m_axi_bresp      	    (axi_b_resp  	)
		,.m_axi_bvalid     	    (axi_b_valid 	)
		,.m_axi_bready     	    (axi_b_ready 	)
		//,.m_axi_berror  		(axi_b_error	)
		
		// AR Channel
		,.m_axi_araddr       	(axi_ar_addr	)
		,.m_axi_arvalid  		(axi_ar_valid	)
		,.m_axi_arready  		(axi_ar_ready	)
		// R Channel
		,.m_axi_rdata	    	(axi_r_data		)
		,.m_axi_rresp	    	(axi_r_resp		)
		,.m_axi_rvalid	    	(axi_r_valid	)
		,.m_axi_rready	    	(axi_r_ready	)
		,.m_axi_rlast	    	(axi_r_rlast	)
		//,.m_axi_rerror  		(axi_r_error	)
	);
	logic [63:0][7:0]mem;
	integer i;

	assign	wresetn = axi_resetn;
	assign	rresetn = axi_resetn;

	initial begin
		axi_clk = 0;
		w_clk   = 0;
		r_clk   = 0;
		fail_flag=0;
		axi_resetn = 1;
		#20;
		axi_resetn = 0;
		#40;
		axi_resetn = 1;
	end

	//----------------------------
	// CLOCK SOURCE
	//----------------------------
	initial begin
		forever begin
			#10;
			axi_clk = ~axi_clk;
		end
	end

	initial begin
		forever begin
			#25;
			w_clk = ~w_clk;
		end
	end

	initial begin
		forever begin
			#15;
			r_clk = ~r_clk;
		end
	end

	task get_result();
		if (fail_flag) begin
		$display("================================");
		$display("============ FAILED ============");
		$display("================================");
		end
		else begin
		$display("================================");
		$display("============ PASSED ============");
		$display("================================");
		end
	endtask

	task test_end();
		begin
			#50;
			get_result();
			$finish();
		end
	endtask

	initial begin
		#200;
/*
		for (i=0; i<64; i++) begin
			wdata = $random;
			addr = i;
			AXI_MANAGER_0.write(addr,wdata);
			#20;
			AXI_MANAGER_0.read(addr,rdata);
			if (rdata != wdata) begin
				$display("%0t, FAILED Register %0h failed, expected 8'h%0h, got 8'h%0h", $time, addr, wdata, rdata);
			end
		end
*/	

	end

    

endmodule