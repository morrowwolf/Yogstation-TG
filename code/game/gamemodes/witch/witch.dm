/datum/game_mode
	var/list/datum/mind/witch = list()
	var/list/datum/mind/witchcult = list()
	
/datum/game_mode/witch
	name = "witch"
	config_tag = "witch"
	antag_flag = ROLE_WITCH
	restricted_jobs = list("Baron", "Knight", "Priest")
	required_players = 5
	required_enemies = 1
	enemy_minimum_age = 14
	round_ends_with_antag_death = 1
	
/datum/game_mode/witch/announce()
	return