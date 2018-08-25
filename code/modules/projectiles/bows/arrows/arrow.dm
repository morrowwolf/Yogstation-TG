/obj/item/projectile/bullet/arrow
	name = "arrow"
	desc = "An arrow created in another age."
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "arrow"
	damage = 25
	var/dropped = FALSE
	var/ammo_type = /obj/item/ammo_casing/arrow
	
/obj/item/projectile/bullet/arrow/on_hit(atom/target, blocked = FALSE)
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
			m.butcher_results += list(/obj/item/ammo_casing/arrow = 1)
		else
			m.butcher_results = list(/obj/item/ammo_casing/arrow = 1)
		dropped = TRUE
		return
	if(!dropped)
		var/turf/T = get_turf(src)
		new ammo_type(T)
		dropped = TRUE

/obj/item/projectile/bullet/arrow/proc/handle_drop()
	if(!dropped)
		var/turf/T = get_turf(src)
		new ammo_type(T)
		dropped = TRUE