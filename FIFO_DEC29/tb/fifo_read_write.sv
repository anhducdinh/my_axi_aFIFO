module fifo_read_write();

    tb top();

    integer         i;
    reg [7:0]       addr, wdata, rdata;

    initial begin
        #200;
        // reg_test();
        fork
            begin
                write_test();
            end

            begin
                #700;
                read_test();
            end

        join
        top.test_end();
    end

    task reg_test();
    begin
        for (i=0; i<15; i++) begin
            wdata = $random;
            addr = 0;
            top.AXI_MANAGER_0.write(addr,wdata);
            #40;
            top.AXI_MANAGER_0.read(addr,rdata);
            if (rdata[0] != wdata[0]) begin
                $display("%0t, FAILED Register %0h failed, expected 8'h%0h, got 8'h%0h", $time, addr, wdata[0], rdata[0]);
                top.fail_flag = 1;
            end
        end
    end
    endtask

    task write_test();
        for (i=0; i<70; i++) begin
            top.write_enable = 1;
            wdata = $random;
            #10;
            top.write_enable = 0;
            $display("Write data = %0d",wdata);
        end
    endtask

    task read_test();
        for (i=0; i<70; i++) begin
            top.read_enable = 1;
            rdata = top.read_data;
            #10;
            top.read_enable = 0;
            $display("Read data = %0d",rdata);
        end
    endtask

endmodule