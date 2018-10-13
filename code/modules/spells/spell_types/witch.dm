/obj/effect/proc_holder/spell/aoe_turf/summon_skeleton
	name = "Summon Skeleton"
	desc = "This spell uses the bones nearby to summon servants from the afterlife."

	school = "necromancy"
	charge_max = 100
	clothes_req = 0
	invocation = "Ardaigh seirbhiseach marbh!"
	invocation_type = "whisper"
	range = 2
	cooldown_min = 20 //20 deciseconds reduction per rank

	action_icon_state = "skeleton"
	
/obj/effect/proc_holder/spell/aoe_turf/summon_skeleton/cast(list/targets,mob/user = usr)

	var/bones = 0
	
	for(var/turf/T in targets)
		for(var/obj/item/stack/sheet/bone/b in T.contents)
			bones++
			
	if(bones < 5)
		to_chat(user, "Not enough bones to summon an undead minion!")
		return
	
	var/list/candidates = get_candidates(ROLE_WITCH_SKELETON, null, ROLE_WITCH_SKELETON)
	if(!candidates.len)
		to_chat(user, "No undead to summon!")
		return
		
	while(bones >= 5)
		var/mob/dead/selected_candidate = pick_n_take(candidates)
		var/key = selected_candidate.key

		
		var/datum/mind/Mind = new /datum/mind(key)
		Mind.assigned_role = ROLE_WITCH_SKELETON
		Mind.special_role = ROLE_WITCH_SKELETON
		Mind.active = 1

		var/mob/living/carbon/human/skeleton = new(user.loc)
		var/datum/preferences/A = new()
		A.real_name = "Servant of [user]"
		A.copy_to(skeleton)
		skeleton.dna.update_dna_identity()
		skeleton.makeSkeleton()
		
		Mind.transfer_to(skeleton)
		var/datum/antagonist/witch/witch_skeleton/skeletondatum = new
		Mind.add_antag_datum(skeletondatum)
			
		if(skeleton.mind != Mind)			//something has gone wrong!
			throw EXCEPTION("Skeleton created with incorrect mind")
	
		bones -= 5
		var/bone_removal = 5
		for(var/turf/T in targets)
			for(var/obj/item/stack/sheet/bone/b in T.contents)
				qdel(b)
				bone_removal--
				if(bone_removal == 0)
					goto FinishBoneRemoval
		
		FinishBoneRemoval
			
		log_game("[skeleton.key] was spawned as a skeleton by [user.key]/ ([user])")
	
	
/obj/effect/proc_holder/spell/aoe_turf/summon_skeleton/proc/get_candidates(jobban, gametypecheck, be_special)
	// Returns a list of candidates in priority order, with candidates from
	// `priority_candidates` first, and ghost roles randomly shuffled and
	// appended after
	var/list/mob/dead/observer/regular_candidates
	// don't get their hopes up
	
	regular_candidates = pollGhostCandidates("Do you wish to be considered for the special role of 'Witch's Skeleton'?", jobban, gametypecheck, be_special)

	shuffle_inplace(regular_candidates)

	var/list/candidates = regular_candidates

	return candidates