/obj/item/bow
	name = "bow"
	desc = "It's a bow.  Effective in the right hands."
	lefthand_file = 'yogstation/icons/mob/inhands/medieval_lefthand.dmi'
	righthand_file = 'yogstation/icons/mob/inhands/medieval_righthand.dmi'
	icon = 'yogstation/icons/obj/medieval.dmi'
	icon_state = "bow"
	item_state = "bow"
	slot_flags = ITEM_SLOT_BACK
	materials = list()
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	force = 5
	attack_verb = list("struck", "hit", "bashed")
	var/obj/item/ammo_casing/chambered = null
	
	
/obj/item/bow/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
	if(!target)
		return
	if(flag) //It's adjacent, is the user, or is on the user's person
		if(target in user.contents) //can't shoot stuff inside us.
			return
		if(!ismob(target) || user.a_intent == INTENT_HARM) //melee attack
			return
		if(target == user) //so we can't shoot ourselves
			return

	if(istype(user))//Check if the user can use the gun, if the user isn't alive(turrets) assume it can.
		var/mob/living/L = user
		if(!can_trigger_gun(L))
			return

	process_fire(target, user, TRUE, params)
	
/obj/item/bow/proc/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "")
	add_fingerprint(user)

	if(semicd)
		return
	
	if(!chambered.fire_casing(target, user, params, , suppressed, zone_override, sprd))
		shoot_with_empty_chamber(user)
		return
	else
		if(get_dist(user, target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
			shoot_live_shot(user, 1, target, message)
		else
			shoot_live_shot(user, 0, target, message)
	semicd = TRUE
	addtimer(CALLBACK(src, .proc/reset_semicd), fire_delay)

	if(user)
		user.update_inv_hands()
	return TRUE
	
/obj/item/gun/proc/reset_semicd()
	semicd = FALSE