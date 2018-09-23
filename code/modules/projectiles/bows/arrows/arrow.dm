/obj/item/projectile/bullet/arrow
	name = "arrow"
	desc = "An arrow created in another age."
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "arrow"
	damage = 25
	hitsound_wall = ""
	var/ammo_type = /obj/item/ammo_casing/arrow
	
/obj/item/projectile/bullet/arrow/on_hit(atom/target, blocked = FALSE)
	if(istype(target, /mob/living))
		var/mob/living/L = target
		if(L.blocking)
			var/hitFrom = get_dir(starting, L)
			if(L.block_dir == 1)
				if(hitFrom == NORTH || hitFrom == NORTHEAST || hitFrom == NORTHWEST)
					blocked = TRUE
			else if(L.block_dir == 2)
				if(hitFrom == SOUTH || hitFrom == SOUTHEAST || hitFrom == SOUTHWEST)
					blocked = TRUE
			else if(L.block_dir == 4)
				if(hitFrom == EAST || hitFrom == NORTHEAST || hitFrom == SOUTHEAST)
					blocked = TRUE
			else if(L.block_dir == 8)
				if(hitFrom == WEST || hitFrom == NORTHWEST || hitFrom == SOUTHWEST)
					blocked = TRUE
					
			if(blocked)
				playsound(get_turf(L), 'sound/weapons/effects/shield_block_2.ogg', 150, 1, -1)
				L.visible_message("<span class='danger'>[L] has blocked [src]!</span>", \
					"<span class='userdanger'>[L] has blocked [src]!</span>", null, COMBAT_MESSAGE_RANGE)
				handle_drop()
				return
			else
				. = ..()
		else
			. = ..()
					
			
	handle_drop_with_reference(target)
	
/obj/item/projectile/bullet/arrow/on_range()
	handle_drop()
	..()	

/obj/item/projectile/bullet/arrow/proc/handle_drop_with_reference(atom/target)
	if(pick(FALSE, TRUE)) //50/50 drop rate
		return
	if(istype(target, /mob/living/))
		var/mob/living/m = target
		if(m.butcher_results)
			if(m.butcher_results[/obj/item/ammo_casing/arrow])
				m.butcher_results[/obj/item/ammo_casing/arrow] += 1
			else
				m.butcher_results += list(/obj/item/ammo_casing/arrow = 1)
		else
			m.butcher_results = list(/obj/item/ammo_casing/arrow = 1)
		return
	var/turf/T = get_turf(src)
	new ammo_type(T)

/obj/item/projectile/bullet/arrow/proc/handle_drop()
	var/turf/T = get_turf(src)
	new ammo_type(T)