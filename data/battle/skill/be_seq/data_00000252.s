.include "source/macros_asm_.s"


Script_1: @ 0
	JumpIfPkmnBattleData Ne, 0x1, 0x4f, 0x0, Script_branch_90
	Cmd_37 0x0, 0x1, 0x1a, Script_branch_90
	JumpIfPkmnBattleData TstNe, 0x1, 0x3b, 0x400, Script_branch_90
	Cmd_34 0xa, 0x1, 0x3b, 0x8000000
	Cmd_34 0x7, 0x1, 0x4f, 0x5
	Cmd_15 0x409, 0x2, 0x1
	Cmd_32 Cmd32_Store, Var_2, 0x2000005a
	end
@ 90

Script_branch_90: @ 90
	Cmd_32 Cmd32_Orr, 0xa, 0x40
	end
@ a4

@ end_0xa4
