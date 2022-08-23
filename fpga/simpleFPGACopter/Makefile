all: tb_spiwishbone



tb_spiwishbone: tb_spiwishbone.v  spiwishbone.v spi_slave.v pwmdecoder_wb.v pwmdecoder.v
	iverilog -g2012 -o tb_spiwishbone tb_spiwishbone.v spiwishbone.v verilog-wishbone/rtl/axis_wb_master.v spi_slave.v FIFO_v.v pwmdecoder_wb.v pwmdecoder.v 
	vvp tb_spiwishbone


tb_pwmdecoder_wb: tb_pwmdecoder_wb.v   pwmdecoder_wb.v pwmdecoder.v
	iverilog -g2012 -o tb_pwmdecoder_wb tb_pwmdecoder_wb.v pwmdecoder_wb.v pwmdecoder.v 
	vvp tb_pwmdecoder_wb

clean:
	rm -rf  *.vcd  tb_spiwishbone tb_pwmdecoder_wb
		 
		 
		
