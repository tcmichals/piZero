all: tb_spiwishbone



tb_spiwishbone: tb_spiwishbone.v  spiwishbone.v spi_slave.v pwmdecoder_wb.v pwmdecoder.v
	iverilog -g2012 -o tb_spiwishbone tb_spiwishbone.v spiwishbone.v verilog-wishbone/rtl/axis_wb_master.v spi_slave.v FIFO_v.v pwmdecoder_wb.v pwmdecoder.v 
	vvp tb_spiwishbone


tb_pwmdecoder_wb: tb_pwmdecoder_wb.v   pwmdecoder_wb.v pwmdecoder.v
	iverilog -g2012 -o tb_pwmdecoder_wb tb_pwmdecoder_wb.v pwmdecoder_wb.v pwmdecoder.v 
	vvp tb_pwmdecoder_wb



tb_mux_oneshotpwmled: tb_mux_oneshotpwmled.v  mux_oneshotpwmled.v threeport_mux.v
	iverilog -g2012 -o tb_mux_oneshotpwmled tb_mux_oneshotpwmled.v mux_oneshotpwmled.v threeport_mux.v
	vvp tb_mux_oneshotpwmled

clean:
	rm -rf  *.vcd  tb_spiwishbone tb_pwmdecoder_wb tb_mux_oneshotpwmled
		 
		 
		
