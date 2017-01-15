

/* GivePokemon	pkmn=0, lvl=0, item=0, move1, move2, move3, move4, res=0
Input:
r0: Ptr to ScriptHandler-Struct
Stack: Move1, Move2, Move3, Move4, PersonalityValue, IVs, EVs1, EVs2, AltForm
*/
thumb_func_start ScriptCmd_GivePokemon2
ScriptCmd_GivePokemon2:
	push    {r4-r7,lr}
	add     sp, #-0x14-4*9

	mov     r4, r0
	add     r0, #ScriptHandler_80
	ldr     r0, [r0]
	ldr     r0, [r0, #OverWorldData_1c]
	ldr     r0, [r0, #0x0]
	bl      GetMapName
	mov     r6, r0

	@ Load 1. Parameter (Pokemon Species)
	mov     r0, r4
	add     r0, #ScriptHandler_80
	ldr     r5, [r0]
	mov     r0, r4
	bl      ScriptHandler_LoadHWord
	mov     r1, r0
	mov     r0, r4
	add     r0, #ScriptHandler_80
	ldr     r0, [r0]
	bl      ScriptHandler_CheckSaveParameter
    lsr     r1, r0, #10
	str     r1, [sp, #0x34]
    ldr     r1, =0x3ff
    and     r0, r1
	str     r0, [sp, #0xc]

	@ Load 2. Parameter (Level)
	mov     r0, r4
	bl      ScriptHandler_LoadHWord
	mov     r1, r0
	mov     r0, r4
	add     r0, #ScriptHandler_80
	ldr     r0, [r0]
	bl      ScriptHandler_CheckSaveParameter
	mov     r7, r0

	@ Load 3. Parameter (Item)
	mov     r0, r4
	bl      ScriptHandler_LoadHWord
	mov     r1, r0
	mov     r0, r4
	add     r0, #ScriptHandler_80
	ldr     r0, [r0]
	bl      ScriptHandler_CheckSaveParameter
	str     r0, [sp, #0x10]

	@ Load 4. Parameter (Move1)
	mov     r0, r4
	bl      ScriptHandler_LoadHWord
	mov     r1, r0
	mov     r0, r4
	add     r0, #ScriptHandler_80
	ldr     r0, [r0]
	bl      ScriptHandler_CheckSaveParameter
	str     r0, [sp, #0x14]

	@ Load 5. Parameter (Move2)
	mov     r0, r4
	bl      ScriptHandler_LoadHWord
	mov     r1, r0
	mov     r0, r4
	add     r0, #ScriptHandler_80
	ldr     r0, [r0]
	bl      ScriptHandler_CheckSaveParameter
	str     r0, [sp, #0x18]

	@ Load 6. Parameter (Move3)
	mov     r0, r4
	bl      ScriptHandler_LoadHWord
	mov     r1, r0
	mov     r0, r4
	add     r0, #ScriptHandler_80
	ldr     r0, [r0]
	bl      ScriptHandler_CheckSaveParameter
	str     r0, [sp, #0x1c]

	@ Load 7. Parameter (Move4)
	mov     r0, r4
	bl      ScriptHandler_LoadHWord
	mov     r1, r0
	mov     r0, r4
	add     r0, #ScriptHandler_80
	ldr     r0, [r0]
	bl      ScriptHandler_CheckSaveParameter
	str     r0, [sp, #0x20]

	@ Load 8. Parameter (PersonalityValue)
	mov     r0, r4
	bl      ScriptHandler_LoadWord
	mov     r1, r0
	mov     r0, r4
	add     r0, #ScriptHandler_80
	ldr     r0, [r0]
	bl      ScriptHandler_CheckSaveParameter
	str     r0, [sp, #0x24]

	@ Load 9. Parameter (IVs)
	mov     r0, r4
	bl      ScriptHandler_LoadWord
	mov     r1, r0
	mov     r0, r4
	add     r0, #ScriptHandler_80
	ldr     r0, [r0]
	bl      ScriptHandler_CheckSaveParameter
	str     r0, [sp, #0x28]

	@ Load 10. Parameter (EVs1)
	mov     r0, r4
	bl      ScriptHandler_LoadWord
	mov     r1, r0
	mov     r0, r4
	add     r0, #ScriptHandler_80
	ldr     r0, [r0]
	bl      ScriptHandler_CheckSaveParameter
	str     r0, [sp, #0x2c]

	@ Load 11. Parameter (EVs2)
	mov     r0, r4
	bl      ScriptHandler_LoadHWord
	mov     r1, r0
	mov     r0, r4
	add     r0, #ScriptHandler_80
	ldr     r0, [r0]
	bl      ScriptHandler_CheckSaveParameter
	str     r0, [sp, #0x30]

	@ Load 12. Parameter (ResultVariable)
	mov     r0, r4
	bl      ScriptHandler_LoadHWord
	add     r4, #ScriptHandler_80
	mov     r1, r0
	ldr     r0, [r4]
	bl      ScriptHandler_CheckLoadParameter
	mov     r4, r0

	ldr     r0, [r5, #OverWorldData_c]
	bl      LoadPokePartyAdress

	ldr     r0, [sp, #0x10]
	lsl     r3, r7, #24
	str     r0, [sp, #0x0]
	str     r6, [sp, #0x4]

	mov     r0, #0x18
	str     r0, [sp, #0x8]

	ldr     r1, [r5, #OverWorldData_c]
	ldr     r2, [sp, #0xc]
	mov     r0, #0xb
	lsr     r3, r3, #24
    add     r4, sp, #0x14
	bl      GivePokemon2
	strh    r0, [r4, #0x0]          @ Return the result of the ScriptFunction
    
	mov     r0, #0x0
	add     sp, #0x14+4*9
	pop     {r4-r7,pc}

.align 2
.pool
thumb_func_end ScriptCmd_GivePokemon2


.zero 0x020507e4-0x02050738
@.org 0x507e4

