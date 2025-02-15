vlog -f compile.f
vsim -voptargs="+acc" fifo_read_write
do wave.do
run -all