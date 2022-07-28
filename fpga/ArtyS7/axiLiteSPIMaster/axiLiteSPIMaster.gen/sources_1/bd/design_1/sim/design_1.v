//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
//Date        : Fri Jun 10 15:37:52 2022
//Host        : VERITY-1171 running 64-bit Ubuntu 20.04.4 LTS
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_board_cnt=5,da_clkrst_cnt=1,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (ddr_clock,
    reset);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.DDR_CLOCK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.DDR_CLOCK, CLK_DOMAIN design_1_ddr_clock, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input ddr_clock;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset;

  wire ddr_clock_1;
  wire reset_1;
  wire [0:0]reset_inv_0_Res;

  assign ddr_clock_1 = ddr_clock;
  assign reset_1 = reset;
  design_1_clk_wiz_0_0 clk_wiz_0
       (.clk_in1(ddr_clock_1),
        .reset(reset_inv_0_Res));
  design_1_reset_inv_0_1 reset_inv_0
       (.Op1(reset_1),
        .Res(reset_inv_0_Res));
endmodule
