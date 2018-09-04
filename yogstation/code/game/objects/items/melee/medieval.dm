/obj/item/melee/medieval
	icon = 'yogstation/icons/obj/medieval.dmi'
	lefthand_file = 'yogstation/icons/mob/inhands/medieval_lefthand.dmi'
	righthand_file = 'yogstation/icons/mob/inhands/medieval_righthand.dmi'
	
/obj/item/melee/medieval/Initialize()
	. = ..()
	AddComponent(/datum/component/charge)

/obj/item/melee/medieval/blade
	sharpness = IS_SHARP
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/melee/medieval/blade/dagger
	name = "dagger"
	icon_state = "dagger"
	desc = "A medieval dagger for self-defense and utility made in the ages of bandits and highwaymen."
	force = 14
	throwforce = 18
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	
/obj/item/melee/medieval/blade/sword
	name = "sword"
	icon_state = "sword"
	desc = "A medieval sword crafted to fight evil and protect a lord's wards."
	force = 30
	throwforce = 30
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK