onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/wresetn
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/rresetn
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/flush
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/w_clk
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/r_clk
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/write_data
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/wr_enable
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/rd_enable
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/read_data
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/full
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/empty
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/write_ptr
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/read_ptr
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/w_addr
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/r_addr
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/write_ptr_syn
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/read_ptr_syn
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/fifo_wr_enable
add wave -noupdate -expand -group u_fifo /fifo_read_write/top/DUT/u_fifo/fifo_rd_enable
add wave -noupdate -group fifo_mem /fifo_read_write/top/DUT/u_fifo/FIFO_MEMORY/data_in
add wave -noupdate -group fifo_mem /fifo_read_write/top/DUT/u_fifo/FIFO_MEMORY/w_clk
add wave -noupdate -group fifo_mem /fifo_read_write/top/DUT/u_fifo/FIFO_MEMORY/r_clk
add wave -noupdate -group fifo_mem /fifo_read_write/top/DUT/u_fifo/FIFO_MEMORY/rresetn
add wave -noupdate -group fifo_mem /fifo_read_write/top/DUT/u_fifo/FIFO_MEMORY/wresetn
add wave -noupdate -group fifo_mem /fifo_read_write/top/DUT/u_fifo/FIFO_MEMORY/fifo_wr_enable
add wave -noupdate -group fifo_mem /fifo_read_write/top/DUT/u_fifo/FIFO_MEMORY/fifo_rd_enable
add wave -noupdate -group fifo_mem /fifo_read_write/top/DUT/u_fifo/FIFO_MEMORY/flush
add wave -noupdate -group fifo_mem /fifo_read_write/top/DUT/u_fifo/FIFO_MEMORY/w_addr
add wave -noupdate -group fifo_mem /fifo_read_write/top/DUT/u_fifo/FIFO_MEMORY/r_addr
add wave -noupdate -group fifo_mem /fifo_read_write/top/DUT/u_fifo/FIFO_MEMORY/data_out
add wave -noupdate -group fifo_mem /fifo_read_write/top/DUT/u_fifo/FIFO_MEMORY/mem_array
add wave -noupdate -group fifo_write /fifo_read_write/top/DUT/u_fifo/FIFO_WRITE/w_clk
add wave -noupdate -group fifo_write /fifo_read_write/top/DUT/u_fifo/FIFO_WRITE/wresetn
add wave -noupdate -group fifo_write /fifo_read_write/top/DUT/u_fifo/FIFO_WRITE/flush
add wave -noupdate -group fifo_write /fifo_read_write/top/DUT/u_fifo/FIFO_WRITE/wr_enable
add wave -noupdate -group fifo_write /fifo_read_write/top/DUT/u_fifo/FIFO_WRITE/read_ptr
add wave -noupdate -group fifo_write /fifo_read_write/top/DUT/u_fifo/FIFO_WRITE/fifo_wr_enable
add wave -noupdate -group fifo_write /fifo_read_write/top/DUT/u_fifo/FIFO_WRITE/full
add wave -noupdate -group fifo_write /fifo_read_write/top/DUT/u_fifo/FIFO_WRITE/write_ptr
add wave -noupdate -group fifo_write /fifo_read_write/top/DUT/u_fifo/FIFO_WRITE/msb_equal
add wave -noupdate -group fifo_write /fifo_read_write/top/DUT/u_fifo/FIFO_WRITE/lsb_equal
add wave -noupdate -group fifo_read /fifo_read_write/top/DUT/u_fifo/FIFO_READ/r_clk
add wave -noupdate -group fifo_read /fifo_read_write/top/DUT/u_fifo/FIFO_READ/flush
add wave -noupdate -group fifo_read /fifo_read_write/top/DUT/u_fifo/FIFO_READ/rresetn
add wave -noupdate -group fifo_read /fifo_read_write/top/DUT/u_fifo/FIFO_READ/rd_enable
add wave -noupdate -group fifo_read /fifo_read_write/top/DUT/u_fifo/FIFO_READ/write_ptr
add wave -noupdate -group fifo_read /fifo_read_write/top/DUT/u_fifo/FIFO_READ/fifo_rd_enable
add wave -noupdate -group fifo_read /fifo_read_write/top/DUT/u_fifo/FIFO_READ/empty
add wave -noupdate -group fifo_read /fifo_read_write/top/DUT/u_fifo/FIFO_READ/read_ptr
add wave -noupdate -group fifo_read /fifo_read_write/top/DUT/u_fifo/FIFO_READ/msb_equal
add wave -noupdate -group fifo_read /fifo_read_write/top/DUT/u_fifo/FIFO_READ/lsb_equal
add wave -noupdate -group write_syn /fifo_read_write/top/DUT/u_fifo/write_syn/clk
add wave -noupdate -group write_syn /fifo_read_write/top/DUT/u_fifo/write_syn/resetn
add wave -noupdate -group write_syn /fifo_read_write/top/DUT/u_fifo/write_syn/syn_ptr_in
add wave -noupdate -group write_syn /fifo_read_write/top/DUT/u_fifo/write_syn/syn_ptr_out
add wave -noupdate -group write_syn /fifo_read_write/top/DUT/u_fifo/write_syn/syn_ptr_in_d
add wave -noupdate -group write_syn /fifo_read_write/top/DUT/u_fifo/write_syn/syn_ptr_in_2d
add wave -noupdate -group read_syn /fifo_read_write/top/DUT/u_fifo/read_syn/clk
add wave -noupdate -group read_syn /fifo_read_write/top/DUT/u_fifo/read_syn/resetn
add wave -noupdate -group read_syn /fifo_read_write/top/DUT/u_fifo/read_syn/syn_ptr_in
add wave -noupdate -group read_syn /fifo_read_write/top/DUT/u_fifo/read_syn/syn_ptr_out
add wave -noupdate -group read_syn /fifo_read_write/top/DUT/u_fifo/read_syn/syn_ptr_in_d
add wave -noupdate -group read_syn /fifo_read_write/top/DUT/u_fifo/read_syn/syn_ptr_in_2d
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_clk
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_resetn
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_awaddr
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_awvalid
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_awready
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_wdata
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_wvalid
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_wready
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_wlast
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_bready
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_bresp
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_bvalid
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_araddr
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_arvalid
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_arready
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_rdata
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_rvalid
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_rready
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_rlast
add wave -noupdate -group DUT /fifo_read_write/top/DUT/csr_rresp
add wave -noupdate -group DUT /fifo_read_write/top/DUT/w_clk
add wave -noupdate -group DUT /fifo_read_write/top/DUT/wresetn
add wave -noupdate -group DUT /fifo_read_write/top/DUT/write_enable
add wave -noupdate -group DUT /fifo_read_write/top/DUT/write_data
add wave -noupdate -group DUT /fifo_read_write/top/DUT/r_clk
add wave -noupdate -group DUT /fifo_read_write/top/DUT/rresetn
add wave -noupdate -group DUT /fifo_read_write/top/DUT/read_enable
add wave -noupdate -group DUT /fifo_read_write/top/DUT/read_data
add wave -noupdate -group DUT /fifo_read_write/top/DUT/flush
add wave -noupdate -group DUT /fifo_read_write/top/DUT/full
add wave -noupdate -group DUT /fifo_read_write/top/DUT/empty
add wave -noupdate -group DUT /fifo_read_write/top/DUT/reg_w_addr
add wave -noupdate -group DUT /fifo_read_write/top/DUT/reg_r_addr
add wave -noupdate -group DUT /fifo_read_write/top/DUT/reg_write_data
add wave -noupdate -group DUT /fifo_read_write/top/DUT/reg_read_data
add wave -noupdate -group DUT /fifo_read_write/top/DUT/reg_read_enable
add wave -noupdate -group DUT /fifo_read_write/top/DUT/reg_write_enable
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_clk
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_resetn
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_awaddr
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_awvalid
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_awready
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_wdata
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_wvalid
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_wready
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_wlast
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_bready
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_bresp
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_bvalid
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_araddr
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_arvalid
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_arready
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_rdata
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_rvalid
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_rready
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_rlast
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_rresp
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/current_state
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/next_state
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/mode
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/init_transaction
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/init_transaction_d
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/start
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/start_write
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/start_read
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/write_done
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/read_done
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_berror
add wave -noupdate -expand -group Manager /fifo_read_write/top/AXI_MANAGER_0/m_axi_rerror
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_clk
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_resetn
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_awaddr
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_awvalid
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_awready
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_wdata
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_wvalid
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_wready
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_wlast
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_bready
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_bresp
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_bvalid
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_araddr
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_arvalid
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_arready
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_rdata
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_rvalid
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_rready
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_rlast
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/s_axi_rresp
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/w_addr
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/r_addr
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/wdata
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/rdata
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/csr_read_enable
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/csr_write_enable
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/access_read
add wave -noupdate -expand -group Subordinate /fifo_read_write/top/DUT/csr_if/access_write
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9419 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 423
configure wave -valuecolwidth 129
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {5091 ns}
