onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_clk
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_resetn
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_awaddr
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_awvalid
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_awready
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_wdata
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_wvalid
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_wready
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_wlast
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_bready
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_bresp
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_bvalid
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_araddr
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_arvalid
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_arready
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_rdata
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_rvalid
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_rready
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_rlast
add wave -noupdate /fifo_read_write/top/DUT/csr_if/s_axi_rresp
add wave -noupdate /fifo_read_write/top/DUT/csr_if/w_addr
add wave -noupdate /fifo_read_write/top/DUT/csr_if/r_addr
add wave -noupdate /fifo_read_write/top/DUT/csr_if/wdata
add wave -noupdate /fifo_read_write/top/DUT/csr_if/rdata
add wave -noupdate /fifo_read_write/top/DUT/csr_if/csr_read_enable
add wave -noupdate /fifo_read_write/top/DUT/csr_if/csr_write_enable
add wave -noupdate /fifo_read_write/top/DUT/reg_write_data
add wave -noupdate /fifo_read_write/top/DUT/reg_read_data
add wave -noupdate /fifo_read_write/top/DUT/reg_read_enable
add wave -noupdate /fifo_read_write/top/DUT/reg_write_enable
add wave -noupdate /fifo_read_write/top/DUT/reg_w_addr
add wave -noupdate /fifo_read_write/top/DUT/reg_r_addr
add wave -noupdate /fifo_read_write/top/DUT/flush
add wave -noupdate -divider AXI_MANAGER
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_clk
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_resetn
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_awaddr
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_awvalid
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_awready
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_wdata
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_wvalid
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_wready
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_wlast
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_bready
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_bresp
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_bvalid
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_araddr
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_arvalid
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_arready
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_rdata
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_rvalid
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_rready
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_rlast
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_rresp
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/current_state
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/next_state
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/mode
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/init_transaction
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/init_transaction_d
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/start
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/start_write
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/start_read
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/write_done
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/read_done
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_berror
add wave -noupdate /fifo_read_write/top/AXI_MANAGER_0/m_axi_rerror
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {388 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 318
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {1020 ns}
