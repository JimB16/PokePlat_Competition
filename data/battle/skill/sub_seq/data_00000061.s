.include "source/macros_asm_.s"


Script_1: @ 0
	Cmd_37 0x0, 0x1, 0x62, Script_branch_dc
	JumpIf TstEq, 0x6, 0x1000, Script_branch_dc
	Cmd_12 0x10c, 0x2, 0x1
	Cmd_e
	Cmd_1e 0x1e
	Cmd_39 0x7, 0x20, 0xe
	Cmd_55 0x20, 0x2
	Cmd_3a 0x11, 0x2, 0x30, 0x2b
	Cmd_32 0xc, 0x2b, 0xffffffff
	Cmd_55 0x2b, 0x2
	Cmd_4e 0x3, 0x2b, 0x20, Script_branch_b4
	Cmd_39 0x7, 0x20, 0x2b
Script_branch_b4: @ b4
	Cmd_39 0x7, 0x14, 0xf
	Cmd_32 Cmd32_Orr, 0x6, 0x40
	Cmd_3c 0x2
Script_branch_dc: @ dc
	end
@ e0

@ end_0xe0
