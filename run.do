
vlog -f srcfile.txt

vsim -voptargs=+acc fifo_tb

add wave *

add wave -position insertpoint  \
sim:/fifo_tb/DUT/FIFO_MEM/fifo_mem_reg \
sim:/fifo_tb/DUT/FIFO_MEM/r_addr \
sim:/fifo_tb/DUT/FIFO_MEM/r_data \
sim:/fifo_tb/DUT/FIFO_MEM/w_addr \
sim:/fifo_tb/DUT/FIFO_MEM/w_data
add wave -position insertpoint  \
sim:/fifo_tb/DUT/FIFO_RD_LOGIC/rptr2wl
add wave -position insertpoint  \
sim:/fifo_tb/DUT/FIFO_WR_LOGIC/rptr \
sim:/fifo_tb/DUT/FIFO_WR_LOGIC/rptr2wl \
sim:/fifo_tb/DUT/FIFO_WR_LOGIC/wptr2rl
add wave -position insertpoint  \
sim:/fifo_tb/DUT/FIFO_RD_LOGIC/wptr2rl