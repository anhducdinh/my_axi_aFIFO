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

	reg [DATA_WIDTH-1:0] 	wdata, rdata, addr;	
	
	
    dummy #(
         .DATA_WIDTH(8)
        ,.ADDR_WIDTH(8)
        )
        DUT // instance name
        (	// AW Channel
		 .s_axi_clk      	    (axi_clk    	)
		,.s_axi_resetn      	(axi_resetn 	)
		,.s_axi_awaddr      	(axi_aw_addr 	)
		,.s_axi_awvalid      	(axi_aw_valid	)
		,.s_axi_awready      	(axi_aw_ready	)
							
		//W Channel   	
		,.s_axi_wdata        	(axi_w_data 	)
		,.s_axi_wvalid       	(axi_w_valid 	)
		,.s_axi_wready       	(axi_w_ready 	)
		,.s_axi_wlast        	(axi_w_last 	)
		
		//B Channel
		,.s_axi_bresp           (axi_b_resp  	)
		,.s_axi_bvalid    	    (axi_b_valid 	)
		,.s_axi_bready     	    (axi_b_ready 	)
		// ,.BERROR		(axi_b_error	)
		
		// AR Channel
		,.s_axi_araddr       	(axi_ar_addr	)
		,.s_axi_arvalid  		(axi_ar_valid	)
		,.s_axi_arready  		(axi_ar_ready	)
		// R Channel
		,.s_axi_rdata	    	(axi_r_data		)
		,.s_axi_rresp	    	(axi_r_resp		)
		,.s_axi_rvalid	    	(axi_r_valid	)
		,.s_axi_rready	    	(axi_r_ready	)
		// ,.RERROR		(axi_r_error	)
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
		//,.m_axi_rerror  		(axi_r_error	)
	);
	logic [63:0][7:0]mem;
	integer i;

	initial begin
		axi_clk = 0;
		axi_resetn = 1;
		#20;
		axi_resetn = 0;
		#40;
		axi_resetn = 1;
	end

	initial begin
		forever begin
			#10;
			axi_clk = ~axi_clk;
		end
	end



	initial begin
		#200;

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
	
		$finish();

	end

    

endmodule