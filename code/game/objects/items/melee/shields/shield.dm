/obj/item/shield/medieval
	name = "shield"
	desc = "You probably shouldn't be able to see this"
	
	slot_flags = ITEM_SLOT_BACK
	
	force = 10
	throwforce = 15
	
	icon = 'yogstation/icons/obj/medieval.dmi'
	lefthand_file = 'yogstation/icons/mob/inhands/medieval_lefthand.dmi'
	righthand_file = 'yogstation/icons/mob/inhands/medieval_righthand.dmi'
	icon_state = "knight shield"		//when creating a new shield end the "up" icon with "-up" and then "down" icon with "-down"
	var/icon_state_up
	var/icon_state_down
	
/obj/item/shield/medieval/Initialize()
	..()
	icon_state_up = "[icon_state]-up"
	icon_state_down = "[icon_state]-down"
	icon_state = icon_state_down
	
/obj/item/shield/medieval/attack_self(mob/living/carbon/user)
	if(user.blocking)
		user.blocking = FALSE
		icon_state = icon_state_down
		user.block_dir = null
	else
		user.blocking = TRUE
		icon_state = icon_state_up
		user.block_dir = dir
	
/obj/item/shield/medieval/dropped(mob/user)
	if(user.blocking)
		user.blocking = FALSE
		icon_state = icon_state_down
		user.block_dir = null
	..(user)
	
/obj/item/shield/medieval/doMove(atom/destination)
	if(istype(loc, /mob/))
		var/mob/user = loc
		if(user.blocking)
			user.blocking = FALSE
			icon_state = icon_state_down
			user.block_dir = null
	..(destination)
	
/obj/item/shield/medieval/on_swap_hand(mob/living/carbon/user)
	if(user.blocking)
		user.blocking = FALSE
		icon_state = icon_state_down
		user.block_dir = null
	
	return FALSE
	