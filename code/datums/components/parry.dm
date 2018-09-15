/datum/component/parry
	var/parry = 0

/datum/component/parry/Initialize()
	if(!istype(parent, /obj/item/))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_ITEM_ATTACK_SELF), .proc/attack_self)
	
/datum/component/parry/proc/attack_self(mob/living/carbon/user)

	if(!user.parry_cooldown || (user.parry_cooldown && user.parry_cooldown < world.time))
		user.parry_cooldown = world.time + 50
	else
		return

	parry = 1
	user.add_overlay(icon('icons/effects/medieval.dmi', "parry1"))
	playsound(get_turf(user), 'sound/effects/parry.ogg', 50)
	addtimer(CALLBACK(src, .proc/parry_end, user), 5)
	
/datum/component/parry/proc/parry_end(mob/living/carbon/user)
	user.cut_overlay(icon('icons/effects/medieval.dmi', "parry1"))

	parry = 0
	