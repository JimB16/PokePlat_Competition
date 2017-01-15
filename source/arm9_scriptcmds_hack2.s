

/* Input:
r0 = Ptr to allocated PkmnData
r1 = Species
r2 = Level
r4 = Ptr to Data (PersonalityValue, IVs, EVs1, EVs2)
*/
thumb_func_start InitPkmnData2
InitPkmnData2: @ 2073d80 :thumb
	push    {r0-r3}
	push    {r3-r6,lr}
	add     sp, #-0x2c-4
    
    str     r4, [sp, #0x2c]
    @mov     r7, r4
    
	mov     r5, r0
	mov     r4, r1
	mov     r6, r3

	bl      ClearCompletePkmnDataStructure

	ldr     r0, [sp, #0x50+4]
	mov     r1, r4
	str     r0, [sp, #0x0]
	ldr     r0, [sp, #0x54+4]
	mov     r3, r6
	str     r0, [sp, #0x4]
	ldr     r0, [sp, #0x58+4]
	str     r0, [sp, #0x8]
	ldr     r0, [sp, #0x5c+4]
	str     r0, [sp, #0xc]
	ldr     r2, [sp, #0x48+4] @ Level
	mov     r0, r5
    push    {r4}
    ldr     r4, [sp, #0x2c+4]
	bl      InitPkmnDataStructure2
    pop     {r4}

	mov     r0, r5
	add     r0, #PkmnData_Offset2
	mov     r1, #PkmnData_Size2
	mov     r2, #0x0
	bl      Call_DecryptPkmnData2

	mov     r0, r5
	ldr     r2, [r5, #PkmnData_PersonalityValue]
	add     r0, #PkmnData_Offset2
	mov     r1, #PkmnData_Size2
	bl      Call_DecryptPkmnData2

	mov     r0, r5
	mov     r1, #PKMNDATA_LEVEL
	add     r2, sp, #0x48+4
	bl      SetPkmnData

	mov     r0, #0x0
	bl      Function_202818c
	mov     r4, r0

	mov     r0, r5
	mov     r1, #PKMNDATA_aa
	mov     r2, r4
	bl      SetPkmnData

	mov     r0, r4
	bl      free

	mov     r0, #0x0
	str     r0, [sp, #0x10]

	mov     r0, r5
	mov     r1, #PKMNDATA_CAPSULEINDEXSEALS
	add     r2, sp, #0x10
	bl      SetPkmnData

	mov     r0, #0x0
	add     r1, sp, #0x14
	mov     r2, #0x18
	blx     MIi_CpuClearFast

	mov     r0, r5
	mov     r1, #PKMNDATA_SEALCOORDINATES
	add     r2, sp, #0x14
	bl      SetPkmnData

	mov     r0, r5
	bl      Function_207418c

	add     sp, #0x2c+4
	pop     {r3-r6}
	pop     {r3}
	add     sp, #0x10
	bx      r3
thumb_func_end InitPkmnData2


/* Input:
r0 = Ptr to allocated PkmnData
r1 = Species
r3 = Level
r4 = Ptr to Data (PersonalityValue, IVs, EVs1, EVs2)
PersonalityValue, IVs, EVs1, EVs2, AltForm
*/
thumb_func_start InitPkmnDataStructure2
InitPkmnDataStructure2: @ 2073e18 :thumb
	push    {r0-r3}
	push    {r4-r7,lr}
	add     sp, #-0xc-4
	mov     r5, r0
    
	str     r4, [sp, #0xc] @ store Ptr to Data (PersonalityValue, IVs, EVs1, EVs2)
    
	bl      ClearPkmnDataStructure1

	mov     r0, r5
	bl      InitEncryptPkmnData_Part1
	str     r0, [sp, #0x0]

	ldr     r0, [sp, #0x30+4]
	cmp     r0, #0x0
@	bne     branch_2073e42_
@    nop
@    nop

    ldr     r0, [sp, #0xc] @ store Ptr to Data (PersonalityValue, IVs, EVs1, EVs2, AltForm)
    ldr     r0, [r0, #4*0]

@	bl      PRNG
@	mov     r4, r0
@	bl      PRNG
@	lsl     r0, r0, #16
@	orr     r0, r4
@    mov     r0, #0xff
    nop
	str     r0, [sp, #0x34+4]

branch_2073e42_: @ 2073e42 :thumb
/*	mov     r0, r5
	mov     r1, #PKMNDATA_PERSONALITYVALUE
	add     r2, sp, #0x34+4
	bl      SetBoxPkmnData*/

	ldr     r0, [sp, #0x38+4]
	cmp     r0, #0x2
	bne     branch_2073e8a_
	ldr     r7, =0xffff0000
	mov     r6, r7
branch_2073e56_: @ 2073e56 :thumb
	bl      PRNG
	mov     r4, r0
	bl      PRNG
	ldr     r1, [sp, #0x34+4]
	lsl     r0, r0, #16
	mov     r3, r4
	orr     r3, r0
	lsl     r0, r1, #16
	lsr     r2, r0, #16
	mov     r0, r1
	and     r0, r7
	lsr     r1, r0, #16
	mov     r0, r3
	str     r3, [sp, #0x3c+4]

	and     r0, r6
	lsl     r3, r3, #16
	lsr     r0, r0, #16
	lsr     r3, r3, #16
	eor     r0, r3
	eor     r0, r1
	eor     r0, r2
	cmp     r0, #0x8
	blo     branch_2073e56_
	b       branch_2073e92_

branch_2073e8a_: @ 2073e8a :thumb
	cmp     r0, #0x1
	beq     branch_2073e92_
	mov     r0, #0x0
	str     r0, [sp, #0x3c+4]
branch_2073e92_: @ 2073e92 :thumb

	mov     r0, r5
	mov     r1, #PKMNDATA_PERSONALITYVALUE
	add     r2, sp, #0x34+4
	bl      SetBoxPkmnData

	mov     r0, r5
	mov     r1, #PKMNDATA_OTID
	add     r2, sp, #0x3c+4
	bl      SetBoxPkmnData

	ldr     r2, =CountryOfOriginValue
	mov     r0, r5
	mov     r1, #PKMNDATA_COUNTRYOFORIGIN
	bl      SetBoxPkmnData

	mov     r0, r5
	mov     r1, #PKMNDATA_SPECIES
	add     r2, sp, #0x24+4
	bl      SetBoxPkmnData

	mov     r0, r5
	mov     r1, #PKMNDATA_b3
	mov     r2, #0x0
	bl      SetBoxPkmnData

	ldr     r0, [sp, #0x24+4]
	ldr     r1, [sp, #0x28+4]
	bl      GetBaseExpPts
	str     r0, [sp, #0x8]

	mov     r0, r5
	mov     r1, #PKMNDATA_EXPPTS
	add     r2, sp, #0x8
	bl      SetBoxPkmnData

	ldr     r0, [sp, #0x24+4]
	mov     r1, #PKMNBASEDATA_BASEHAPPY
	bl      GetPkmnBaseData1
	str     r0, [sp, #0x8]
	mov     r0, r5
	mov     r1, #PKMNDATA_FRIENDSHIP
	add     r2, sp, #0x8
	bl      SetBoxPkmnData

	mov     r0, r5
	mov     r1, #PKMNDATA_METATLEVEL
	add     r2, sp, #0x28+4
	bl      SetBoxPkmnData

	ldr     r2, =GameIDNr
	mov     r0, r5
	mov     r1, #PKMNDATA_ORIGINGAME
	bl      SetBoxPkmnData

	mov     r0, #0x4
	str     r0, [sp, #0x8]
	mov     r0, r5
	mov     r1, #PKMNDATA_POKEBALL
	add     r2, sp, #0x8
	bl      SetBoxPkmnData

@ Set EVs
    ldr     r0, [sp, #0xc] @ store Ptr to Data (PersonalityValue, IVs, EVs1, EVs2)
    ldr     r0, [r0, #4*2] @ EVs
	str     r0, [sp, #0x8]

	mov     r0, r5
	mov     r1, #PKMNDATA_EVHP
	add     r2, sp, #0x8
	bl      SetBoxPkmnData

	mov     r0, r5
	mov     r1, #PKMNDATA_EVATK
	add     r2, sp, #0x8
	add     r2, #1
	bl      SetBoxPkmnData

	mov     r0, r5
	mov     r1, #PKMNDATA_EVDEF
	add     r2, sp, #0x8
	add     r2, #2
	bl      SetBoxPkmnData

	mov     r0, r5
	mov     r1, #PKMNDATA_EVSPE
	add     r2, sp, #0x8
	add     r2, #3
	bl      SetBoxPkmnData
    
    ldr     r0, [sp, #0xc] @ store Ptr to Data (PersonalityValue, IVs, EVs1, EVs2)
    ldr     r0, [r0, #4*3] @ EVs
	str     r0, [sp, #0x8]

	mov     r0, r5
	mov     r1, #PKMNDATA_EVSPA
	add     r2, sp, #0x8
	bl      SetBoxPkmnData

	mov     r0, r5
	mov     r1, #PKMNDATA_EVSPD
	add     r2, sp, #0x8
	add     r2, #1
	bl      SetBoxPkmnData

@ Set IVs
branch_2073f48_: @ 2073f48 :thumb
    ldr     r0, [sp, #0xc] @ store Ptr to Data (PersonalityValue, IVs, EVs1, EVs2)
    ldr     r0, [r0, #4*1] @ IVs
	mov     r1, #0x1f
	str     r0, [sp, #0x8]
	and     r0, r1
	str     r0, [sp, #0x4]

	mov     r0, r5
	mov     r1, #PKMNDATA_IVHP
	add     r2, sp, #0x4
	bl      SetBoxPkmnData

	mov     r0, #0x1f
	ldr     r1, [sp, #0x8]
	lsr     r1, r1, #5
	and     r0, r1
	str     r0, [sp, #0x4]

	mov     r0, r5
	mov     r1, #PKMNDATA_IVATK
	add     r2, sp, #0x4
	bl      SetBoxPkmnData

	mov     r0, #0x1f
	ldr     r1, [sp, #0x8]
	lsr     r1, r1, #10
	and     r0, r1
	str     r0, [sp, #0x4]

	mov     r0, r5
	mov     r1, #PKMNDATA_IVDEF
	add     r2, sp, #0x4
	bl      SetBoxPkmnData

	mov     r0, #0x1f
	ldr     r1, [sp, #0x8]
	lsr     r1, r1, #15
	and     r0, r1
	str     r0, [sp, #0x4]

	mov     r0, r5
	mov     r1, #PKMNDATA_IVSPE
	add     r2, sp, #0x4
	bl      SetBoxPkmnData

	mov     r0, #0x1f
	ldr     r1, [sp, #0x8]
	lsr     r1, r1, #20
	and     r0, r1
	str     r0, [sp, #0x4]

	mov     r0, r5
	mov     r1, #PKMNDATA_IVSPA
	add     r2, sp, #0x4
	bl      SetBoxPkmnData

	mov     r0, #0x1f
	ldr     r1, [sp, #0x8]
	lsr     r1, r1, #25
	and     r0, r1
	str     r0, [sp, #0x4]

	mov     r0, r5
	mov     r1, #PKMNDATA_IVSPD
	add     r2, sp, #0x4
	bl      SetBoxPkmnData


    ldr     r0, [sp, #0xc] @ store Ptr to Data (PersonalityValue, IVs, EVs1, EVs2, AltForm)
    ldr     r0, [r0, #4*4] @ AltForm
	str     r0, [sp, #0x8]

	mov     r0, r5
	mov     r1, #PKMNDATA_ALTERNATEFORM
	add     r2, sp, #0x8
	bl      SetBoxPkmnData


	ldr     r0, [sp, #0x24+4]
	mov     r1, #PKMNBASEDATA_ABILITY1
	bl      GetPkmnBaseData1
	str     r0, [sp, #0x8]

	ldr     r0, [sp, #0x24+4]
	mov     r1, #PKMNBASEDATA_ABILITY2
	bl      GetPkmnBaseData1
	str     r0, [sp, #0x4]

	cmp     r0, #0x0
	beq     no2ndAbility_
	ldr     r1, [sp, #0x34+4] @ PersonalityValue
	mov     r0, #0x1
	tst     r0, r1
	beq     set2ndAbility_

	mov     r0, r5
	mov     r1, #PKMNDATA_ABILITY
	add     r2, sp, #0x4
	bl      SetBoxPkmnData
	b       skipset2ndAbility_

set2ndAbility_: @ 2073ff8 :thumb
	mov     r0, r5
	mov     r1, #PKMNDATA_ABILITY
	add     r2, sp, #0x8
	bl      SetBoxPkmnData
	b       skipset2ndAbility_

no2ndAbility_: @ 2074004 :thumb
	mov     r0, r5
	mov     r1, #PKMNDATA_ABILITY
	add     r2, sp, #0x8
	bl      SetBoxPkmnData
skipset2ndAbility_: @ 207400e :thumb


	mov     r0, r5
	bl      DecidePkmnGender
	str     r0, [sp, #0x8]

	mov     r0, r5
	mov     r1, #PKMNDATA_GENDER
	add     r2, sp, #0x8
	bl      SetBoxPkmnData

	mov     r0, r5
	bl      InitPkmnMovesFromWotbl

	ldr     r1, [sp, #0x0]
	mov     r0, r5
	bl      InitEncryptPkmnData_Part1Again

	add     sp, #0xc+4
	pop     {r4-r7}
	pop     {r3}
	add     sp, #0x10
	bx      r3
@ 0x2074038

.align 2
.pool
thumb_func_end InitPkmnDataStructure2


@.zero 0x0204f9d4-0x0204f9b2
.org 0x4f9d4

