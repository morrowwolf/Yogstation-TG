#define CHARGE_RANGE 4

/mob/proc/charge(atom/A, var/obj/item/I = null)
	return

/mob/living/carbon/human/charge(atom/A, var/obj/item/I = null)
	if(charge_cooldown == null || charge_cooldown <= world.time && get_dist(src,A) > 0)
		charge_cooldown = world.time + 50
		charging = TRUE
		if(get_dist(src,A) < CHARGE_RANGE)
			var/destination_x = (x - A.x) / (x*x + A.x*x) * CHARGE_RANGE + A.x
			var/destination_y = (y - A.y) / (y*y + A.y*y) * CHARGE_RANGE + A.y		//this shit doesn't work, fucking Altoids
			A = locate(round(destination_x, 1), round(destination_y, 1), z)
		throw_at(A, CHARGE_RANGE, 1, src, FALSE, FALSE, callback = CALLBACK(src, .proc/charge_end))
	
/mob/living/carbon/human/proc/charge_end()
	charging = FALSE
	
/mob/living/carbon/human/throw_impact(atom/A)
	if(!charging)
		return ..()
	else if(A)
		if(istype(A, /turf/closed/) || istype(A, /obj/structure/) || (istype(A, /obj/machinery/) && A.density))
			playsound(get_turf(src), 'sound/effects/woodhit.ogg', 75, 1, -1)
			src.Knockdown(30)
			changeNext_move(CLICK_CD_CHARGE_HIT_WALL)
			
			src.visible_message("<span class='danger'>[src] has charged straight into [A]!</span>", \
							"<span class='userdanger'>[src] has charged straight into [A]!</span>", null, COMBAT_MESSAGE_RANGE)
			
		else if(istype(A, /mob/living/))
			var/mob/living/L = A
			changeNext_move(CLICK_CD_MELEE)
			src.do_attack_animation(L, ATTACK_EFFECT_PUNCH)

			var/damage = 4*rand(src.dna.species.punchdamagelow, src.dna.species.punchdamagehigh)

			var/obj/item/bodypart/affecting = L.get_bodypart(ran_zone(src.zone_selected))

			var/armor_block = L.run_armor_check(affecting, "melee")

			playsound(L.loc, src.dna.species.attack_sound, 25, 1, -1)

			L.visible_message("<span class='danger'>[src] has charged [L]!</span>", \
						"<span class='userdanger'>[src] has charged [L]!</span>", null, COMBAT_MESSAGE_RANGE)

			L.apply_damage(damage, BRUTE, affecting, armor_block)
			log_combat(src, L, "charged")
		else
			changeNext_move(CLICK_CD_CHARGE_MISS)