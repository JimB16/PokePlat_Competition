.include "source/macros_asm_.s"


Script_1: @ 0
	Cmd_a1 0x0, 0x0, 0x6, Script_branch_9c
	JumpIf TstNe, 0x6, 0xf0000000, Script_branch_90
	Cmd_32 Cmd32_Store, 0x9, 0x10000000
	Cmd_39 0xe, 0x9, 0xf
	Cmd_39 0xa, 0x6, 0x9
	Cmd_34 0x7, 0x1, 0x2f, 0x0
	Cmd_32 Cmd32_Store, 0x20, 0x7fff
	Cmd_1b 0x1
	Cmd_e
	Cmd_3c 0x4c
Script_branch_90: @ 90
	Cmd_26
	Cmd_f
	end
@ 9c

Script_branch_9c: @ 9c
	Cmd_11
	Cmd_e
	Cmd_1e 0x1e
	Cmd_12 0x274, 0x34, 0x8
	Cmd_e
	Cmd_1e 0x1e
	Cmd_32 Cmd32_Orr, 0x6, 0x2
	Cmd_32 Cmd32_Orr, 0xa, 0x80000000
	end
@ end_0xf8
@ f8

