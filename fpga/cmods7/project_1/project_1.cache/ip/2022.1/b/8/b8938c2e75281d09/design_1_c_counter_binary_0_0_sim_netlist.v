// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
// Date        : Tue Jun 21 10:25:10 2022
// Host        : hp running 64-bit Ubuntu 22.04 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_c_counter_binary_0_0_sim_netlist.v
// Design      : design_1_c_counter_binary_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s25csga225-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_c_counter_binary_0_0,c_counter_binary_v12_0_15,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_counter_binary_v12_0_15,Vivado 2022.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (CLK,
    THRESH0,
    Q);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:thresh0_intf:l_intf:load_intf:up_intf:sinit_intf:sset_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 thresh0_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME thresh0_intf, LAYERED_METADATA undef" *) output THRESH0;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value data} bitwidth {attribs {resolve_type generated dependency bitwidth format long minimum {} maximum {}} value 16} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}} DATA_WIDTH 16}" *) output [15:0]Q;

  wire CLK;
  wire [15:0]Q;
  wire THRESH0;

  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "16" *) 
  (* C_XDEVICEFAMILY = "spartan7" *) 
  (* c_count_by = "1" *) 
  (* c_count_mode = "0" *) 
  (* c_count_to = "1" *) 
  (* c_has_load = "0" *) 
  (* c_has_thresh0 = "1" *) 
  (* c_latency = "1" *) 
  (* c_load_low = "0" *) 
  (* c_restrict_count = "0" *) 
  (* c_thresh0_value = "1111111111111110" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_counter_binary_v12_0_15 U0
       (.CE(1'b1),
        .CLK(CLK),
        .L({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .LOAD(1'b0),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(THRESH0),
        .UP(1'b1));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
pOoCy2lYSLdoKW5+30MbT0kuTiRSJJ4jG7/RQeB9eRVWQwL+y1zWMiA09vc76Tm9Rm62Cxs2gO7D
cjnDEBDTj9JD9pG0UZ4qvjorK7qe6ttWdmBnoDWg7u86SxcI9hFq/+WSIIz2nufv18Jw1CdSZZOy
fCT9rx9380uRhjUSqF4=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
w0+6vlnZpk2rtsD4bdd9LWwLOAaGlFa69N2rasBQ5mfULBHdtMEL9pZ+aHU222MNGvYQsqWvMFAX
ZesYGDQv4e1JRb1BpT/jMo86E62GcoY5Sma8x/T4td4zjf0tiKaBP1Veutb3G2ureWf4YyEtS8Kg
0PbkWpeGMRgAOQdiRWzcZPYx3TUExmrrpy9HrfwUmeKPRnrLj5W77hmCzmmY/53V9Md+OUxZ1ud9
ra8U2X1hpvTj8Igqf7zkxVLE84R1u3R0xstKE7AwHtdQLmfOOTdMaIeA0cXdV4Fq+KbQfLKFpCch
DBJGJEKdw9bsv3LDnU2dwusgZdqMlPyniUhHIw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
ltA4GqALLdRzzHvj261Uwyntak7z4EkFduT9K3QGtHb0sATa3ybVqK8ZI4jQfsAU7X0LxSWB4LoB
EFa45I2fE9dxusPz3iWXrfp4gx+koM3MHUXxrPW4jG2EucHFZqktvn1Le6uXQTfIURspnbJdYYLN
gfsKiiF0MyJaAIqneyk=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FfEP5FVX1Ax5kxu3ZOO1vQ9h+VBDpOGG5H86yMu1QcxnGqo9gnUM01F3P96BdUFjnV725KGMIQni
FqRDoY3T9Ab12xgASphiapofR3LD5psN/JEAIwqfr0LAp+qbJG9vsC++s2ZWr5bT40BWrvc2jxSi
Mi9YGtaFzL/QmiZd5c8rctXA06pFCKZTPrpVbHHVLIxt3wRGSfzPS5Adi6/wI6QDGsNH6a/h9Rtx
LuJWu70Te3UtGxU4L6xsNyvbBZ4CCFz0dL447PvB0CTDucB/adAFHdWo0DhlvfzkmkoGEAhixHmj
AoxUm5dvM43CGcaupKLSyc0TidiSEq+GR7l2NQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ZQjvUbsJRfCx35iNqwoFQmy1CIf6Coiu+UjavEdAZwIWsKthBwuj7XZZrMuAVlWaw7ztRQITxIW9
joM5AKjSyOnQP0f19GFwzJf84AeawIF3W9rKLzDq3SOmO06CNxp31zfLk/c+P2Aynl/Jtva1fUn+
ZF04qq8HtC+QFVbXW41MZFd1Q/xtg+Oldf7hPUXUSbzn733pCcjZe3zSpulIMxkV5fk6YIh0+pJe
FvtHzhcQPf+iDQm82ToezAiqE2VGuquf6pVU84b/8tWxFyqvKnXHdfXGLEBP/P8+ifSgyJsyvbli
DuFRBrF+POpxQ584I5j7CL45AdM45WR9270K2w==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
I8jEzvdjBEX5gYqZOZMUoavSPVwkkhEzNXKZi6Gv+UZEzEyUPN1l9Jdmm/OohZWWJebb0ecKEuTu
VzUnDYkQifscYwKLjT++bhkfP4fHR6IIJnlOajPL1U2absc717Uq65HLaP0ISJfczzo4S5Mq4/hU
Rj95X70zIG4pYiyaOllA1V+RNsA8rd8f45qhX1XuzYpufo4yOkEdXFfuzY1bDq2nK2OMRH+4TOXw
XMXsCKqNTpsyaEsutNj+rZ7eONFsaOylKo5ofdpJ7IxWzO1aaCcYaqmbNCpkUqe5RQvLE4FuE8Nc
kmvAvUj3g/pJm2VGGdJ2nOsn2uyD9ptFCVK/nQ==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
SEnqVTEa7lkg72h4bpTlKL4fhEuzRqr3rTaNC4OrFZR9Cmrlss8ucbtz4kUEBRUrIzx8ZMZ08aDm
ncvKMpDrsOi59zmzvYyoJ1TK502awdtp+k9xaIVQ0qsM1TxTMEiq6w388MnoJjwOZ7BhuBa1GHgd
Dx/0z+9+rmVCuHs+HULZnwjMyc6gfx7LRVbLQPb0S4Oh9i+rXperDiv5N7FQeNdfsDeRCLVRB8U+
OU60liE0nqP2X7bte91esX0nspE9bMEb88nopvRxFTNBXG/PoJoQvlFjrUXWbVELwUtfC4YAkcvq
eB2RVDysb8DuzJ1PztoiUPf6FAvw6WhfDouB4A==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
k8QHc8h8draQ9agAUUfM6s9ta/pxWprdP2NhBlzOaFB4j4J1MHoYvPuMlWY3IJ+53iC58d58V0KQ
DSf99XKI/DpI43M7z3Rgp6WKRkU72yQMB/tXQk3sQKHKE6DVb5qPkMC13hq+bkDwfv5JMbQX9lwx
tWwloAcpFCR03nGPXqH3V+FDys7YFNmWUI7F6BYxX4W4/4feSosYPgETUP5gLQPnK2SXr1PUeuuW
7UIFcKUwBjx7S6gYUPq3hlO6AFN7ync67eZp8N1tozzGnF23XCk7gUU6srDt2QOWbA0sBL6TTsrI
WW1ADpBsIdstAGiZnMRRGDeA6rN2JiwulhuiWHQAuKSkUSbuIT6uPRmlnd31uhSh7aTrvogfUJSz
uGNb/TAHJkpHm4yL40iI8yO7JTcwLuy2ahdpE16AMDfZJFU4IGouo/H5+p6SO+jvzHZYkIWZusPm
nBK++GQUzk/PMlSRT0cCTnxIgVAFToP96NqnZtn2E47iYToxig/+YKBy

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
LAw56NZhBnNhisjUaakOb87L4sBFj31jlxTUnVSf9FfOIV53do249b3JPp4K8xGqQsYrn2pUQ4U5
FOdo/y2m6aKiAdn9UA1Nx3HHK46586WxtcSd74xxYlIKJMy+xE1yeJIeWoC/+HvDmglnTzt9aJaA
6XKocO7esAOu13fafAa/D4l+73oqYb+v1wIcK34mj43NqEWg+qxUVG5vj9kDrx0l72qkTMtQeCMZ
j9Rr2RJ9uMO8H71F9qVSbAIun5zjMh+cd29z54TJZTanzFEdpk6UmY6Fopv5VuIykHN10J8fpmUH
HEQQJDGCCq33NL6UiradkAd+1GvEk6iYZmweRA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
JHl2ZIfILHKAjdcKwBHaEE1FcpSWfRRpAkws3esT1Fkp9RmbuVbzkkLSdSVDNDtwJWHu+oXcWU9U
uzi0iwZg9+nGg/Otss5XzRW79xc9q45m+2heAJ1ugXzCab4+0+0lOybQ0JmLDlwq61GED/kr+xu6
mM+RW/8KBGloqV+Ou4DID9xf5AC/CZSKwwpuMxaZ8G23gpVN99iRGidwvnZPjHm3yuJ9HjyhuIFt
HT/+iJtwQU5duvBL5EVjLfqYvg8wI9ciXauEkraUT27Qqhp9jzcLRDrkIySM8ZAXywXD7h0v2XgI
9mjo+HhUhflwNumH+BrL8EZWZC88mhPET9WySA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
6mpLzkIEhh2epZm78Z3IA3TQCP4Es/a1CweXwVD5Fox5jYGq2NZYa8pTRJXkH+S01eDQWAeIoVhg
9PwPAu20qyReATWWJkEzuF/B3e8yzGeZPbD6nDb5hqcAPM9ldaTMx+viU0CFsx0iilPEB7pQZC/6
DAz/pwCT+DDa38uHEt+oDLPPUEvEfU/7SmF/KU0s/yD0AHBXDtYdyyNhNUXU4pVgujME68BIKFHo
EX4Fs1aZevbdnd5joJgu90uXqmEsjMqUOHlMPpvKu61F5I9wWeHdh/TE9Ve2D3TnE3opYExvgEIq
/Mtlyufff+AYrG0XdZIXuzTZCP5WA6JFQTls9g==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 11168)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
