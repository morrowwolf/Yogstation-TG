/obj/effect/mob_spawn/human/medieval
	name = "covered medieval bed"
	desc = "An old bed that looks out of place.  Something... seems to be under there?"
	icon = 'icons/obj/lavaland/spawners.dmi'
	icon_state = "terrarium"
	density = TRUE
	roundstart = FALSE
	death = FALSE
	outfit = /datum/outfit/medieval
	
/obj/effect/mob_spawn/human/medieval/special(mob/living/new_spawn)
	if(ishuman(new_spawn))
		var/mob/living/carbon/human/H = new_spawn
		H.underwear = "Nude"
		H.update_body()
		return H
	
/obj/effect/mob_spawn/human/medieval/Destroy()
	new/obj/structure/fluff/empty_terrarium(get_turf(src))
	return ..()
	
/datum/outfit/medieval
	uniform = /obj/item/clothing/under/yogs/peasant
	
/obj/effect/mob_spawn/human/medieval/knight
	mob_name = "a knight"
	flavour_text = "<span class='big bold'>You are a knight,</span><b> an example of the mastery over life that your creators possessed. Your masters, benevolent as they were, created uncounted \
	seed vaults and spread them across the universe to every planet they could chart. You are in one such seed vault. Your goal is to cultivate and spread life wherever it will go while waiting \
	for contact from your creators. Estimated time of last contact: Deployment, 5x10^3 millennia ago.</b>"
	assignedrole = "Knight"
	outfit = /datum/outfit/medieval/knight
	
/obj/effect/mob_spawn/human/medieval/knight/special(mob/living/new_spawn)
	. = ..()
	if(istype(., /mob/living/carbon/human))
		var/mob/living/carbon/human/H = .
		H.job = "knight"
		
/datum/outfit/medieval/knight
	shoes = /obj/item/clothing/shoes/yogs/boots
	suit = /obj/item/clothing/suit/armor/knight
	back = /obj/item/melee/medieval/blade/sword

/obj/effect/mob_spawn/human/medieval/peasant
	mob_name = "a peasant"
	flavour_text = "<span class='big bold'>You are a peasant,</span><b> an example of the mastery over life that your creators possessed. Your masters, benevolent as they were, created uncounted \
	seed vaults and spread them across the universe to every planet they could chart. You are in one such seed vault. Your goal is to cultivate and spread life wherever it will go while waiting \
	for contact from your creators. Estimated time of last contact: Deployment, 5x10^3 millennia ago.</b>"
	assignedrole = "Peasant"
	outfit = /datum/outfit/medieval/peasant
	
/datum/outfit/medieval/peasant
	head = /obj/item/clothing/head/yogs/peasant
	belt = /obj/item/melee/medieval/blade/dagger
