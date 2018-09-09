/datum/component/parry
	var/parry = 0
	var/previousIconName = ""

/datum/component/parry/Initialize()
	if(!istype(parent, /obj/item/))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_ITEM_ATTACK_SELF), .proc/attack_self)
	
/datum/component/parry/proc/attack_self(mob/living/carbon/user)
	parry = 1
	previousIconName = "parry[user.dir]"
	user.add_overlay(icon('icons/effects/medieval.dmi', previousIconName))
	playsound(get_turf(user), 'sound/effects/parry.ogg')
	addtimer(CALLBACK(src, .proc/parry_1, user), 2)
	
/datum/component/parry/proc/parry_1(mob/living/carbon/user)
	user.cut_overlay(icon('icons/effects/medieval.dmi', previousIconName))
	//if(!user.get_active_held_item().datum_components.Find(/datum/component/parry))
		//parry = 0
		//return
	previousIconName = "parry[user.dir]"
	user.add_overlay(icon('icons/effects/medieval.dmi', previousIconName).ChangeOpacity(0.9))
	addtimer(CALLBACK(src, .proc/parry_2, user), 2)

/datum/component/parry/proc/parry_2(mob/living/carbon/user)
	user.cut_overlay(icon('icons/effects/medieval.dmi', previousIconName))
	//if(!user.get_active_held_item().datum_components.Find(/datum/component/parry))
		//parry = 0
		//return
	previousIconName = "parry[user.dir]"
	user.add_overlay(icon('icons/effects/medieval.dmi', previousIconName).ChangeOpacity(0.8))
	addtimer(CALLBACK(src, .proc/parry_3, user), 2)

/datum/component/parry/proc/parry_3(mob/living/carbon/user)
	user.cut_overlay(icon('icons/effects/medieval.dmi', previousIconName))
	//if(!user.get_active_held_item().datum_components.Find(/datum/component/parry))
		//parry = 0
		//return
	previousIconName = "parry[user.dir]"
	user.add_overlay(icon('icons/effects/medieval.dmi', previousIconName).ChangeOpacity(0.7))
	addtimer(CALLBACK(src, .proc/parry_4, user), 2)

/datum/component/parry/proc/parry_4(mob/living/carbon/user)
	user.cut_overlay(icon('icons/effects/medieval.dmi', previousIconName))
	//if(!user.get_active_held_item().datum_components.Find(/datum/component/parry))
		//parry = 0
		//return
	previousIconName = "parry[user.dir]"
	user.add_overlay(icon('icons/effects/medieval.dmi', previousIconName).ChangeOpacity(0.6))
	addtimer(CALLBACK(src, .proc/parry_end, user), 2)
	
	
/datum/component/parry/proc/parry_end(mob/living/carbon/user)
	user.cut_overlay(icon('icons/effects/medieval.dmi', previousIconName))

	parry = 0
	