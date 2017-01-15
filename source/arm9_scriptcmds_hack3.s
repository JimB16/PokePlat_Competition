

/* Input:
r0 = 0xb
r1 = OverWorldData_c (VariableAreaAdresses)
r2 = PkmnSpecies
r3 = Level
r4 = Ptr to Move1, Move2, Move3, Move4
*/
thumb_func_start GivePokemon2
GivePokemon2:
	push    {r3-r7,lr}
	add     sp, #-0x20-4
	mov     r6, r1
	mov     r5, r0
    
	str     r4, [sp, #0x20] @ store Ptr to MoveData

	mov     r0, r6
	mov     r7, r2
	str     r3, [sp, #0x10]
	bl      LoadTrainerDataAdress
	str     r0, [sp, #0x14] @ TrainerDataAdress

	mov     r0, r6
	bl      LoadPokePartyAdress
	str     r0, [sp, #0x18] @ PokePartyAdress

	mov     r0, r5
	bl      AllocPkmnData
	mov     r4, r0

	bl      ClearCompletePkmnDataStructure

	mov     r0, #0x0
	str     r0, [sp, #0x0]
	str     r0, [sp, #0x4]
	str     r0, [sp, #0x8]
	str     r0, [sp, #0xc]

    
@ Search for a fitting Personality Value
    ldr     r1, [sp, #0x20]
    add     r1, #0x4*4              @ Ptr to Data (PersonalityValue, IVs, EVs1, EVs2)
    ldr     r2, [r1]                @ Get PersonalityValue
    
    mov     r1, #0x1f
    and     r1, r2                  @ GetNature
    mov     r0, #1
    lsr     r3, r2, #5
    and     r3, r0                  @ GetAbility
    lsr     r2, r2, #6
    and     r2, r0                  @ GetGender
    
    ldr     r0, [sp, #0x14] @ TrainerDataAdress
    bl      GetTrainerID
    push    {r4-r7}
    mov     r7, r0      @ TrainerID
    
    @mov     r4, #1      @ Nature
    mov     r4, r1
    @mov     r5, #0      @ Ability
    mov     r5, r3
    @mov     r6, #0      @ Gender
    mov     r6, r2
    
    mov     r3, r4      @ Personality Value
    
searchPVLoop:
/*    mov     r0, r3
    mov     r1, r4
    bl      CheckNature
    cmp     r0, #0
    beq     increasePV*/
    
    mov     r0, r3
    mov     r1, r6
    bl      CheckGender
    cmp     r0, #0
    beq     increasePV
    
    mov     r0, r3
    mov     r1, r5
    bl      CheckAbility
    cmp     r0, #0
    beq     increasePV
    
    mov     r0, r3
    mov     r1, r7
    bl      CheckShiny
    cmp     r0, #0
    beq     increasePV
    
    b       foundPV
    
increasePV:
    add     r3, #25
    b       searchPVLoop

foundPV:
    pop     {r4-r7}
    
    @ save found PV
    ldr     r1, [sp, #0x20]
    add     r1, #0x4*4              @ Ptr to Data (PersonalityValue, IVs, EVs1, EVs2)
    str     r3, [r1]

@ Recalculate the Personality Value to get a Shiny
/*	ldr     r0, [sp, #0x14] @ TrainerDataAdress
    bl      GetTrainerID
    lsr     r2, r0, #16
    lsl     r0, r0, #16
    lsr     r0, r0, #16
    eor     r2, r0

    ldr     r0, [sp, #0x20]
    add     r0, #0x4*4              @ Ptr to Data (PersonalityValue, IVs, EVs1, EVs2)
    ldr     r0, [r0]
    mov     r3, #0x3f
    and     r3, r0

    lsl     r0, r0, #16
    lsr     r0, r0, #16@+4
    @lsl     r0, r0, #4
    mov     r1, r0
    eor     r1, r2
    @lsr     r1, r1, #4
    lsl     r1, r1, #16@+4
    orr     r0, r1
    
	@mov     r0, r5
	@bl      PkmnData_DivBy25
	@mov     r1, #25
	@blx     _u32_div_f
	@lsl     r0, r1, #24
	@lsr     r0, r0, #24
    
    ldr     r1, [sp, #0x20]
    add     r1, #0x4*4              @ Ptr to Data (PersonalityValue, IVs, EVs1, EVs2)
    str     r0, [r1]
    @nop
*/

	ldr     r2, [sp, #0x10]         @ Level
	mov     r0, r4
	mov     r1, r7                  @ PkmnSpecies
	mov     r3, #0x20
    push    {r4}
    ldr     r4, [sp, #0x20+4]
    add     r4, #0x4*4              @ Ptr to Data (PersonalityValue, IVs, EVs1, EVs2)
	bl      InitPkmnData2
    pop     {r4}

	ldr     r0, [sp, #0x40+4]
	ldr     r1, [sp, #0x14] @ TrainerDataAdress
	str     r0, [sp, #0x0]
	ldr     r3, [sp, #0x3c+4]
	mov     r0, r4
	mov     r2, #0x4
	str     r5, [sp, #0x4]
	bl      InitMetDataOTIDHPStatus

	add     r0, sp, #0x28+4
	ldrh    r0, [r0, #0x10]
	mov     r1, #PKMNDATA_ITEM
	add     r2, sp, #0x1c
	str     r0, [sp, #0x1c]
	mov     r0, r4
	bl      SetPkmnData

	mov     r0, #3
	str     r0, [sp, #0x1c]
	mov     r1, #PKMNDATA_MOVEPPUPS1
	add     r2, sp, #0x1c
	mov     r0, r4
	bl      SetPkmnData
    
	mov     r1, #PKMNDATA_MOVEPPUPS2
	add     r2, sp, #0x1c
	mov     r0, r4
	bl      SetPkmnData
    
	mov     r1, #PKMNDATA_MOVEPPUPS3
	add     r2, sp, #0x1c
	mov     r0, r4
	bl      SetPkmnData
    
	mov     r1, #PKMNDATA_MOVEPPUPS4
	add     r2, sp, #0x1c
	mov     r0, r4
	bl      SetPkmnData

	mov     r0, r4
    ldr     r1, [sp, #0x20]
    ldr     r1, [r1, #0x0]
    mov     r2, #0
    bl      SetPkmnDataMove

	mov     r0, r4
    ldr     r1, [sp, #0x20]
    ldr     r1, [r1, #0x4]
    mov     r2, #1
    bl      SetPkmnDataMove

	mov     r0, r4
    ldr     r1, [sp, #0x20]
    ldr     r1, [r1, #0x8]
    mov     r2, #2
    bl      SetPkmnDataMove

	mov     r0, r4
    ldr     r1, [sp, #0x20]
    ldr     r1, [r1, #0xc]
    mov     r2, #3
    bl      SetPkmnDataMove
/*
	mov     r1, #PKMNDATA_MOVE1
    ldr     r2, [sp, #0x20]
	mov     r0, r4
	bl      SetPkmnData

	mov     r1, #PKMNDATA_MOVE2
    ldr     r2, [sp, #0x20]
    add     r2, #0x4
	mov     r0, r4
	bl      SetPkmnData

	mov     r1, #PKMNDATA_MOVE3
    ldr     r2, [sp, #0x20]
    add     r2, #0x8
	mov     r0, r4
	bl      SetPkmnData

	mov     r1, #PKMNDATA_MOVE4
    ldr     r2, [sp, #0x20]
    add     r2, #0xc
	mov     r0, r4
	bl      SetPkmnData
*/

/*	ldr     r0, [sp, #0x14] @ TrainerDataAdress
    bl      GetTrainerID
    lsr     r2, r0, #16
    lsl     r3, r3, #16
    lsr     r3, r3, #16
    
	mov     r0, r4
	mov     r1, #PKMNDATA_PERSONALITYVALUE
	bl      GetPkmnData
    lsl     r0, r0, #16
    lsr     r0, r0, #16
    mov     r1, r0
    eor     r1, r2
    eor     r1, r3
    lsl     r1, r1, #16
    orr     r0, r1
    str     r0, [sp, #0x20]

	mov     r0, r4
	mov     r1, #PKMNDATA_PERSONALITYVALUE
    add     r2, sp, #0x20
@	bl      SetPkmnData
    nop
    nop*/


	ldr     r0, [sp, #0x18] @ PokePartyAdress
	mov     r1, r4
	bl      CopyPkmnDataToParty

	mov     r5, r0
	beq     branch_2054924_
	mov     r0, r6
	mov     r1, r4
	bl      Function_202f180
branch_2054924_: @ 2054924 :thumb

	mov     r0, r4
	bl      free

	mov     r0, r5
	add     sp, #0x20+4
	pop     {r3-r7,pc}
thumb_func_end GivePokemon2


/* Input:
r0: PersonalityValue
r1: Nature
*/
thumb_func_start CheckNature
CheckNature:
    push    {r3, lr}
	mov     r3, r1
	bl      PkmnData_DivBy25
    cmp     r0, r3
    beq     rightNature
    mov     r0, #0
    pop     {r3, pc}
    
rightNature:
    mov     r0, #1
    pop     {r3, pc}
thumb_func_end CheckNature


/* Input:
r0: PersonalityValue
r1: 0 Male, 1 Female
*/
thumb_func_start CheckGender
CheckGender:
    push    {r2, lr}
    mov     r2, #0xff
    and     r0, r2
    cmp     r1, #1
    beq     checkFemale
    
    cmp     r0, #192
    bge     rightMale
    mov     r0, #0
    pop     {r2, pc}
    
rightMale:
    mov     r0, #1
    pop     {r2, pc}

checkFemale:
    cmp     r0, #31
    blt     rightFemale
    mov     r0, #0
    pop     {r2, pc}
    
rightFemale:
    mov     r0, #1
    pop     {r2, pc}
thumb_func_end CheckGender


/* Input:
r0: PersonalityValue
r1: Ability
*/
thumb_func_start CheckAbility
CheckAbility:
    push    {r2, lr}
    mov     r2, #0x1
    and     r0, r2
    cmp     r0, r1
    beq     rightAbility
    mov     r0, #0
    pop     {r2, pc}
    
rightAbility:
    mov     r0, #1
    pop     {r2, pc}
thumb_func_end CheckAbility


/* Input:
r0: PersonalityValue
r1: TrainerID
*/
thumb_func_start CheckShiny
CheckShiny:
    push    {r2, lr}
    lsl     r2, r0, #16
    lsr     r2, r2, #16
    lsr     r0, r0, #16
    eor     r0, r2
    lsl     r2, r1, #16
    lsr     r2, r2, #16
    lsr     r1, r1, #16
    eor     r0, r1
    eor     r0, r2
    lsl     r0, r0, #16
    lsr     r0, r0, #16
    
    cmp     r0, #8
    blo     rightShiny
    mov     r0, #0
    pop     {r2, pc}
    
rightShiny:
    mov     r0, #1
    pop     {r2, pc}
thumb_func_end CheckShiny


@.zero 0x20480a8-0x02047f34 @ 0x02047f04 @ 0x02047ed8
.org 0x480a8

