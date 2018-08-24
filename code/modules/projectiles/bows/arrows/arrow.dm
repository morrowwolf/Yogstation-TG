/obj/item/projectile/bullet/reusable/arrow
	name = "arrow"
	desc = "An arrow created in another age."
	ammo_type = /obj/item/ammo_casing/arrow
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "arrow"
	damage = 25
	
/obj/item/projectile/bullet/reusable/arrow/proc/handle_drop_with_reference(atom/target)
	if(pick(FALSE, TRUE)) //50/50 drop rate
		return
	if(istype(target, /mob/living/))
		var/mob/living/m = target
		if(m.butcher_results)
			m.butcher_results += /obj/item/projectile/bullet/reusable/arrow
		else
			m.butcher_results = /obj/item/projectile/bullet/reusable/arrow
		dropped = TRUE
		return
	if(!dropped)
		var/turf/T = get_turf(src)
		new ammo_type(T)
		dropped = TRUE
	
/obj/item/projectile/bullet/reusable/arrow/on_hit(atom/target, blocked = FALSE)
	. = ..()
	handle_drop_with_reference(target)