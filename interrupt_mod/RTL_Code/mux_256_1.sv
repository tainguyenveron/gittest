module mux_256_1 #(
	parameter DATA_WIDTH = 8
)(
	input  logic [7:0] sel_enc,
	output logic [DATA_WIDTH-1:0] out
	);
	always_comb begin
		case(sel_enc)
			8'h00: out = 8'hff;	//255
			8'h01: out = 8'hfe;	//254
			8'h02: out = 8'hfd;	//253
			8'h03: out = 8'hfc;	//252
			8'h04: out = 8'hfb;	//251
			8'h05: out = 8'hfa;	//250
			8'h06: out = 8'hf9;	//249
			8'h07: out = 8'hf8;	//248
			8'h08: out = 8'hf7;	//247
			8'h09: out = 8'hf6;	//246
			8'h0a: out = 8'hf5;	//245
			8'h0b: out = 8'hf4;	//244
			8'h0c: out = 8'hf3;	//243
			8'h0d: out = 8'hf2;	//242
			8'h0e: out = 8'hf1;	//241
			8'h0f: out = 8'hf0;	//240

			8'h10: out = 8'hef;	//239
			8'h11: out = 8'hee;	//238
			8'h12: out = 8'hed;	//237
			8'h13: out = 8'hec;	//236
			8'h14: out = 8'heb;	//235
			8'h15: out = 8'hea;	//234
			8'h16: out = 8'he9;	//233
			8'h17: out = 8'he8;	//232
			8'h18: out = 8'he7;	//231
			8'h19: out = 8'he6;	//230
			8'h1a: out = 8'he5;	//229
			8'h1b: out = 8'he4;	//228
			8'h1c: out = 8'he3;	//227
			8'h1d: out = 8'he2;	//226
			8'h1e: out = 8'he1;	//225
			8'h1f: out = 8'he0;	//224

			8'h20: out = 8'hdf;	//223
			8'h21: out = 8'hde;	//222
			8'h22: out = 8'hdd;	//221
			8'h23: out = 8'hdc;	//220
			8'h24: out = 8'hdb;	//219
			8'h25: out = 8'hda;	//218
			8'h26: out = 8'hd9;	//217
			8'h27: out = 8'hd8;	//216
			8'h28: out = 8'hd7;	//215
			8'h29: out = 8'hd6;	//214
			8'h2a: out = 8'hd5;	//213
			8'h2b: out = 8'hd4;	//212
			8'h2c: out = 8'hd3;	//211
			8'h2d: out = 8'hd2;	//210
			8'h2e: out = 8'hd1;	//209
			8'h2f: out = 8'hd0;	//208

			8'h30: out = 8'hcf;	//207
			8'h31: out = 8'hce;	//206
			8'h32: out = 8'hcd;	//205
			8'h33: out = 8'hcc;	//204
			8'h34: out = 8'hcb;	//203
			8'h35: out = 8'hca;	//202
			8'h36: out = 8'hc9;	//201
			8'h37: out = 8'hc8;	//200
			8'h38: out = 8'hc7;	//199
			8'h39: out = 8'hc6;	//198
			8'h3a: out = 8'hc5;	//197
			8'h3b: out = 8'hc4;	//196
			8'h3c: out = 8'hc3;	//195
			8'h3d: out = 8'hc2;	//194
			8'h3e: out = 8'hc1;	//193
			8'h3f: out = 8'hc0;	//192

			8'h40: out = 8'hbf;	//191
			8'h41: out = 8'hbe;	//190
			8'h42: out = 8'hbd;	//189
			8'h43: out = 8'hbc;	//188
			8'h44: out = 8'hbb;	//187
			8'h45: out = 8'hba;	//186
			8'h46: out = 8'hb9;	//185
			8'h47: out = 8'hb8;	//184
			8'h48: out = 8'hb7;	//183
			8'h49: out = 8'hb6;	//182
			8'h4a: out = 8'hb5;	//181
			8'h4b: out = 8'hb4;	//180
			8'h4c: out = 8'hb3;	//179
			8'h4d: out = 8'hb2;	//178
			8'h4e: out = 8'hb1;	//177
			8'h4f: out = 8'hb0;	//176

			8'h50: out = 8'haf;	//175
			8'h51: out = 8'hae;	//174
			8'h52: out = 8'had;	//173
			8'h53: out = 8'hac;	//172
			8'h54: out = 8'hab;	//171
			8'h55: out = 8'haa;	//170
			8'h56: out = 8'ha9;	//169
			8'h57: out = 8'ha8;	//168
			8'h58: out = 8'ha7;	//167
			8'h59: out = 8'ha6;	//166
			8'h5a: out = 8'ha5;	//165
			8'h5b: out = 8'ha4;	//164
			8'h5c: out = 8'ha3;	//163
			8'h5d: out = 8'ha2;	//162
			8'h5e: out = 8'ha1;	//161
			8'h5f: out = 8'ha0;	//160

			8'h60: out = 8'h9f;	//159
			8'h61: out = 8'h9e;	//158
			8'h62: out = 8'h9d;	//157
			8'h63: out = 8'h9c;	//156
			8'h64: out = 8'h9b;	//155
			8'h65: out = 8'h9a;	//154
			8'h66: out = 8'h99;	//153
			8'h67: out = 8'h98;	//152
			8'h68: out = 8'h97;	//151
			8'h69: out = 8'h96;	//150
			8'h6a: out = 8'h95;	//149
			8'h6b: out = 8'h94;	//148
			8'h6c: out = 8'h93;	//147
			8'h6d: out = 8'h92;	//146
			8'h6e: out = 8'h91;	//145
			8'h6f: out = 8'h90;	//144

			8'h70: out = 8'h8f;	//143
			8'h71: out = 8'h8e;	//142
			8'h72: out = 8'h8d;	//141
			8'h73: out = 8'h8c;	//140
			8'h74: out = 8'h8b;	//139
			8'h75: out = 8'h8a;	//138
			8'h76: out = 8'h89;	//137
			8'h77: out = 8'h88;	//136
			8'h78: out = 8'h87;	//135
			8'h79: out = 8'h86;	//134
			8'h7a: out = 8'h85;	//133
			8'h7b: out = 8'h84;	//132
			8'h7c: out = 8'h83;	//131
			8'h7d: out = 8'h82;	//130
			8'h7e: out = 8'h81;	//129
			8'h7f: out = 8'h80;	//128

			8'h80: out = 8'h7f;	//127
			8'h81: out = 8'h7e;	//126
			8'h82: out = 8'h7d;	//125
			8'h83: out = 8'h7c;	//124
			8'h84: out = 8'h7b;	//123
			8'h85: out = 8'h7a;	//122
			8'h86: out = 8'h79;	//121
			8'h87: out = 8'h78;	//120
			8'h88: out = 8'h77;	//119
			8'h89: out = 8'h76;	//118
			8'h8a: out = 8'h75;	//117
			8'h8b: out = 8'h74;	//116
			8'h8c: out = 8'h73;	//115
			8'h8d: out = 8'h72;	//114
			8'h8e: out = 8'h71;	//113
			8'h8f: out = 8'h70;	//112

			8'h90: out = 8'h6f;	//111
			8'h91: out = 8'h6e;	//110
			8'h92: out = 8'h6d;	//109
			8'h93: out = 8'h6c;	//108
			8'h94: out = 8'h6b;	//107
			8'h95: out = 8'h6a;	//106
			8'h96: out = 8'h69;	//105
			8'h97: out = 8'h68;	//104
			8'h98: out = 8'h67;	//103
			8'h99: out = 8'h66;	//102
			8'h9a: out = 8'h65;	//101
			8'h9b: out = 8'h64;	//100
			8'h9c: out = 8'h63;	//99
			8'h9d: out = 8'h62;	//98
			8'h9e: out = 8'h61;	//97
			8'h9f: out = 8'h60;	//96

			8'ha0: out = 8'h5f;	//95
			8'ha1: out = 8'h5e;	//94
			8'ha2: out = 8'h5d;	//93
			8'ha3: out = 8'h5c;	//92
			8'ha4: out = 8'h5b;	//91
			8'ha5: out = 8'h5a;	//90
			8'ha6: out = 8'h59;	//89
			8'ha7: out = 8'h58;	//88
			8'ha8: out = 8'h57;	//87
			8'ha9: out = 8'h56;	//86
			8'haa: out = 8'h55;	//85
			8'hab: out = 8'h54;	//84
			8'hac: out = 8'h53;	//83
			8'had: out = 8'h52;	//82
			8'hae: out = 8'h51;	//81
			8'haf: out = 8'h50;	//80

			8'hb0: out = 8'h4f;	//79
			8'hb1: out = 8'h4e;	//78
			8'hb2: out = 8'h4d;	//77
			8'hb3: out = 8'h4c;	//76
			8'hb4: out = 8'h4b;	//75
			8'hb5: out = 8'h4a;	//74
			8'hb6: out = 8'h49;	//73
			8'hb7: out = 8'h48;	//72
			8'hb8: out = 8'h47;	//71
			8'hb9: out = 8'h46;	//70
			8'hba: out = 8'h45;	//69
			8'hbb: out = 8'h44;	//68
			8'hbc: out = 8'h43;	//67
			8'hbd: out = 8'h42;	//66
			8'hbe: out = 8'h41;	//65
			8'hbf: out = 8'h40;	//64

			8'hc0: out = 8'h3f;	//63
			8'hc1: out = 8'h3e;	//62
			8'hc2: out = 8'h3d;	//61
			8'hc3: out = 8'h3c;	//60
			8'hc4: out = 8'h3b;	//59
			8'hc5: out = 8'h3a;	//58
			8'hc6: out = 8'h39;	//57
			8'hc7: out = 8'h38;	//56
			8'hc8: out = 8'h37;	//55
			8'hc9: out = 8'h36;	//54
			8'hca: out = 8'h35;	//53
			8'hcb: out = 8'h34;	//52
			8'hcc: out = 8'h33;	//51
			8'hcd: out = 8'h32;	//50
			8'hce: out = 8'h31;	//49
			8'hcf: out = 8'h30;	//48

			8'hd0: out = 8'h2f;	//47
			8'hd1: out = 8'h2e;	//46
			8'hd2: out = 8'h2d;	//45
			8'hd3: out = 8'h2c;	//44
			8'hd4: out = 8'h2b;	//43
			8'hd5: out = 8'h2a;	//42
			8'hd6: out = 8'h29;	//41
			8'hd7: out = 8'h28;	//40
			8'hd8: out = 8'h27;	//39
			8'hd9: out = 8'h26;	//38
			8'hda: out = 8'h25;	//37
			8'hdb: out = 8'h24;	//36
			8'hdc: out = 8'h23;	//35
			8'hdd: out = 8'h22;	//34
			8'hde: out = 8'h21;	//33
			8'hdf: out = 8'h20;	//32

			8'he0: out = 8'h1f;	//31
			8'he1: out = 8'h1e;	//30
			8'he2: out = 8'h1d;	//29
			8'he3: out = 8'h1c;	//28
			8'he4: out = 8'h1b;	//27
			8'he5: out = 8'h1a;	//26
			8'he6: out = 8'h19;	//25
			8'he7: out = 8'h18;	//24
			8'he8: out = 8'h17;	//23
			8'he9: out = 8'h16;	//22
			8'hea: out = 8'h15;	//21
			8'heb: out = 8'h14;	//20
			8'hec: out = 8'h13;	//19
			8'hed: out = 8'h12;	//18
			8'hee: out = 8'h11;	//17
			8'hef: out = 8'h10;	//16

			// 8'hff: out = 8'h07;	//7
			default: out = 8'h00;
		endcase
	end

endmodule

