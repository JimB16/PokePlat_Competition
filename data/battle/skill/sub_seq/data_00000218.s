.include "source/macros_asm_.s"


Script_1: @ 0
	JumpIf TstNe, 0xa, 0x10001, Script_branch_e8
	Cmd_d2 0x2, Script_branch_e8
	JumpIfPkmnBattleData Eq, 0x2, 0x1a, 0x79, Script_branch_e8
	JumpIfPkmnBattleData Ne, 0x2, 0x51, 0x0, Script_branch_e8
	JumpIfPkmnBattleData Eq, 0x2, 0x37, 0x70, Script_branch_e8
	JumpIfPkmnBattleData Ne, 0x2, 0x56, 0x0, Script_branch_e8
	JumpIfPkmnBattleData Ne, 0x2, 0x55, 0x0, Script_branch_e8
	Cmd_3c 0x4c
	Cmd_34 0xa, 0x2, 0x3b, 0x4000000
	Cmd_34 0x7, 0x2, 0x51, 0x5
	Cmd_12 0x46f, 0x2, 0x2
	Cmd_e
	Cmd_1e 0x1e
	end
@ e8

Script_branch_e8: @ e8
	Cmd_32 Cmd32_Orr, 0xa, 0x40
	end
@ end_0xfc
@ fc

