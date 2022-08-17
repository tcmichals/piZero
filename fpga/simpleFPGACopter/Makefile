


all: testbench

testbench: testbench.v
	iverilog -o testbench testbench.v verilog-wishbone/rtl/axis_wb_master.v 
	vvp testbench

tb_toplevelbus: tb_toplevelbus.v toplevelbus.v oneshot_wb.v pwmdecoder_wb.v wishbone_mux.v led_wb.v
		iverilog -o tb_toplevelbus tb_toplevelbus.v toplevelbus.v oneshot_wb.v pwmdecoder_wb.v wishbone_mux.v verilog-wishbone/rtl/axis_wb_master.v led_wb.v
		vvp tb_toplevelbus



wishbone_mux.v:
	python3 ./verilog-wishbone/rtl/wb_mux.py -p 2 -n wishbone_mux -o wishbone_mux.v
	

SPI_Slave_TB: spi-slave/Verilog/sim/SPI_Slave_TB.sv	
		iverilog -g2012 -o SPI_Slave_TB spi-slave/Verilog/sim/SPI_Slave_TB.sv spi-slave/Verilog/source/SPI_Slave.v spi-master/Verilog/source/SPI_Master.v
		vvp SPI_Slave_TB

toplevel: toplevel.v toplevelbus.v oneshot_wb.v pwmdecoder_wb.v led_wb.v tb_toplevelbus.v
	iverilog -g2012 -o toplevel toplevel.v toplevelbus.v oneshot_wb.v pwmdecoder_wb.v wishbone_mux.v verilog-wishbone/rtl/axis_wb_master.v led_wb.v  spi-slave/Verilog/source/SPI_Slave.v spi-master/Verilog/source/SPI_Master.v  memory/Verilog/source/RAM_1Port.v memory/Verilog/source/RAM_2Port.v memory/Verilog/source/FIFO.v
	vvp tb_toplevel

tb_axis_spi: tb_axis_spi.v spi-slave/Verilog/source/SPI_Slave.v axis_spi.v
	iverilog -g2012 -o tb_axis_spi tb_axis_spi.v spi-slave/Verilog/source/SPI_Slave.v axis_spi.v memory/Verilog/source/FIFO.v memory/Verilog/source/RAM_2Port.v
	vvp tb_axis_spi

tb_axiswishbone: tb_axiswishbone.v simplecounter_wb.v
	iverilog -g2012 -o tb_axiswishbone tb_axiswishbone.v verilog-wishbone/rtl/axis_wb_master.v simplecounter_wb.v  memory/Verilog/source/FIFO.v memory/Verilog/source/RAM_2Port.v
	vvp tb_axiswishbone

tb_spiwishbone: tb_spiwishbone.v  spiwishbone.v
	iverilog -g2012 -o tb_spiwishbone tb_spiwishbone.v spiwishbone.v verilog-wishbone/rtl/axis_wb_master.v spi-slave/Verilog/source/SPI_Slave.v FIFO_v.v
	vvp tb_spiwishbone

clean:
	rm -rf testbench.vcd testbench tb_toplevelbus tb_toplevelbus.vcd tb_axis_spi *.vcd tb_axiswishbone tb_spiwishbone
		 
		 
		
