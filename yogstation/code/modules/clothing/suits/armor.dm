/obj/item/clothing/suit/armor/knight
	name = "knight's armor"
	desc = "A solid steel armor crafted in the darkness of a medieval era."
	alternate_worn_icon = 'yogstation/icons/mob/suit.dmi'
	icon = 'yogstation/icons/obj/clothing/suits.dmi'
	icon_state = "knight"
	allowed = list(/obj/item/kitchen/knife)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	clothing_flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor = list("melee" = 60, "bullet" = 60, "laser" = 30, "energy" = 30, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)
	
/obj/item/clothing/suit/armor/knight/equipped(mob/user, slot)
	..()
	if(!slot == SLOT_HANDS)
		if(!cmptext(user.job, "knight"))
			slowdown = 1
			to_chat(user, "You feel awkward without training in a suit of armor.")
		else
			slowdown = 0
			to_chat(user, "The armor feels like a second skin.")