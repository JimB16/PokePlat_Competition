.include "source/macros_asm_.s"


Script_1: @ 0
	JumpIfPkmnBattleData Ne, 0x2, 0x40, 0x0, Script_branch_74
	JumpIf TstNe, 0xa, 0x10001, Script_branch_74
	Cmd_3c 0x4c
	Cmd_38 0x2, 0x3
	Cmd_3a 0x7, 0x2, 0x40, 0x9
	Cmd_12 0x1f4, 0x2, 0x2
	Cmd_e
	Cmd_1e 0x1e
	end
@ 74

Script_branch_74: @ 74
	Cmd_32 Cmd32_Orr, 0xa, 0x40
	end
@ 88

@ end_0x88
