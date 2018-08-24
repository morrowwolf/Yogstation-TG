/obj/item/projectile/bullet/reusable/arrow
	name = "arrow"
	desc = "An arrow created in another age."
	var/ammo_type = /obj/item/ammo_casing/caseless
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "arrow"
	damage = 25
	
/obj/item/projectile/bullet/reusable/arrow/proc/handle_drop(atom/target as mob|obj|turf)
	if(pick(FALSE, TRUE)) //50/50 drop rate
		return
	if(istype(target, /mob/living/)
		if(butcher_results)
			butcher_results += /obj/item/projectile/bullet/reusable/arrow
		else
			butcher_results = /obj/item/projectile/bullet/reusable/arrow
		dropped = TRUE
		return
	if(!dropped)
		var/turf/T = get_turf(src)
		new ammo_type(T)
		dropped = TRUE
	
/obj/item/projectile/bullet/reusable/on_hit(atom/target, blocked = FALSE)
	. = ..()
	handle_drop(target)