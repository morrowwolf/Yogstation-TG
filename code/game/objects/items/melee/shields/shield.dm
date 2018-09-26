/obj/item/shields/medieval
	name = "shield"
	desc = "You probably shouldn't be able to see this"
	armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 0, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 70)
	
	slot_flags = ITEM_SLOT_BACK
	
	force = 10
	throwforce = 15
	
	icon = 'yogstation/icons/obj/medieval.dmi'
	lefthand_file = 'yogstation/icons/mob/inhands/medieval_lefthand.dmi'
	righthand_file = 'yogstation/icons/mob/inhands/medieval_righthand.dmi'
	icon_state = "knight shield"		//when creating a new shield end the "up" icon with "-up" and then "down" icon with "-down"
	var/icon_state_up
	var/icon_state_down
	
/obj/item/shields/medieval/Initialize()
	..()
	icon_state_up = "[icon_state]-up"
	icon_state_down = "[icon_state]-down"
	icon_state = icon_state_down
	
/obj/item/shields/medieval/attack_self(mob/living/carbon/user)
	if(user.blocking)
		user.blocking = FALSE
		icon_state = icon_state_down
		user.block_dir = null
		user.update_icons()
	else
		user.blocking = TRUE
		icon_state = icon_state_up
		user.block_dir = user.dir
		user.update_icons()
	
/obj/item/shields/medieval/dropped(mob/user)
	if(user.blocking)
		user.blocking = FALSE
		icon_state = icon_state_down
		user.block_dir = null
		user.update_icons()
	return ..(user)
	
/obj/item/shields/medieval/doMove(atom/destination)
	if(istype(loc, /mob/))
		var/mob/user = loc
		if(user.blocking)
			user.blocking = FALSE
			icon_state = icon_state_down
			user.block_dir = null
			user.update_icons()
	return ..(destination)
	
/obj/item/shields/medieval/on_swap_hand(mob/living/carbon/user)
	if(user.blocking)
		to_chat(user, "You cannot swap hands while blocking!")
		return TRUE
	
	return FALSE
	