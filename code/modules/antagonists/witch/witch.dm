/datum/antagonist/witch
	name = "Witch"
	roundend_category = "Witch"
	antagpanel_category = "Witch"
	job_rank = ROLE_WITCH
	var/hud_type = "witch"
	var/datum/team/witch/witch_team

/datum/antagonist/witch/witch_skeleton
	name = "Witch Skeleton"
	job_rank = ROLE_WITCH_SKELETON
	hud_type = "witch skeleton"
	var/datum/mind/master
	
/datum/antagonist/witch/witch_cult
	name = "Witch Cultist"
	job_rank = ROLE_WITCH_CULT
	hud_type = "witch cultist"
	var/datum/mind/master