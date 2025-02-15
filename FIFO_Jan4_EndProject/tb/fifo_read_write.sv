module fifo_read_write();

    tb top();

    integer         i,j;
    reg [7:0]       addr, wdata, rdata;
    reg [7:0]       write_array[$];   // queue declaration
    reg [7:0]       read_array[$];
    

    initial begin
        #200;
        $display("\nRegister test begin\n");
        reg_test();
        $display("\nRegister test end\n");

        $display("Clear flush (if set to 1)");
        
        // force top.DUT.flush = 0;
        top.AXI_MANAGER_0.write(8'h00,8'h00);
        $display("\nFIFO read write test begin\n");

        scoreboard();
        top.enable_scbd=1;

        fork
            begin
                write_test();
            end

            begin
                #5000;
                read_test();
            end
        join
        // top.enable_scbd=0;
        #50;
        $display("\nFIFO read write test end\n");
        top.test_end();
    end

    task reg_test();
    begin
        for (i=0; i<15; i++) begin
            wdata = $random;
            addr = 0;
            top.AXI_MANAGER_0.write(addr,wdata);
            // #40;
            top.AXI_MANAGER_0.read(addr,rdata);
            if (rdata[0] != wdata[0]) begin
                $display("%0t, FAILED Register %0h failed, expected 8'h%0h, got 8'h%0h", $time, addr, wdata[0], rdata[0]);
                top.fail_flag = 1;
            end
        end
    end
    endtask

    task write_test();
        begin
            top.write_enable = 1;
            for (i=0; i<100; i++) begin
                // Create a if assignment here
                // Check bit full -> if full = 1, do not write, otherwise keep writing
                // How to check bit full? read status register
                // Code here
                wdata = $random;
                top.write_data = wdata;
                write_array.push_front(wdata);
                @(posedge top.DUT.w_clk);
                if (top.DUT.full != 1'b0) begin
                    $display("FIFO is full");
                    $display("Waiting for reading");
                    wait(top.DUT.full == 1'b0);
                    @(posedge top.DUT.w_clk);
                end
                // $display("Write data = %0d", wdata);
            end
            top.write_enable = 0;
        end
    endtask

    task read_test();
        begin
            top.read_enable = 1;
            @(posedge top.DUT.r_clk);
            for (j=0; j<100; j++) begin
                @(posedge top.DUT.r_clk);
                // Create a if assignment here
                // Check bit empty -> if empty = 1, do not read, otherwise keep reading
                // How to check bit empty? read status register
                // Code here
                // empty = rdata[0]
                // top.AXI_MANAGER_0.read(8'h1,rdata);
                
                if (top.DUT.empty != 1'b0) begin
                    $display("FIFO is empty");
                    if (top.write_enable) begin
                        $display("Waiting for writing new data");
                        wait(top.DUT.empty==1'b0);
                    end
                end
                rdata = top.read_data;
                if ( |rdata !== 1'bX)
                    read_array.push_front(rdata);
                
                
                // $display("Read data = %0d",rdata);
            end
            top.read_enable = 0;
        end
    endtask

    task scoreboard();
        reg     [7:0] w_data;
        reg     [7:0] r_data;

        begin
            fork
            while(top.enable_scbd) begin
                // @(posedge top.axi_clk);
                #1
                if (read_array.size() > 0) begin
                    r_data = read_array.pop_back();
                    w_data = write_array.pop_back();
                    if (r_data == w_data) begin
                        $display("At %0t, Write %0h, Read %0h",$time,w_data,r_data);
                    end 
                    else begin
                        $display("ERROR! Expected %0h, received %0h",w_data,r_data);
                        top.fail_flag = 1;
                        top.num_errors ++;
                    end
                    
                    if (top.num_errors > 10) begin
                        $display("\nNumber of errors exceed 10.");
                        top.test_end();
                    end
                end 
            end
            join_none
        end
    endtask

endmodule