.include "source/macros_asm_.s"


Script_1: @ 0
	JumpIf TstNe, Var_Weather, 0x7000, Script_branch_28
	Cmd_32 Cmd32_Store, Var_3, 0x20000076
	end
@ 28

Script_branch_28: @ 28
	Cmd_32 Cmd32_Orr, 0xa, 0x40
	end
@ 3c

@ end_0x3c
