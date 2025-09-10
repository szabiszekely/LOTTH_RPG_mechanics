extends SetupEnemyAI
class_name BallerAI



# IF ON ENG
	# (Running (if possible))
	# Health check if above variable
		# have a chance given by  (chance increases every time it gets lower)
		# Do an items,action or ability that will increase ENG
	# Use Items
		# If has any
		# Use item precentage to decide if needed or not
	# Act if all Players actions result in peace
	# Use buff ability
		# Has it been already used or not
		# Does my team has the max buff
	# Use ability
		# (Can Reach the target)
		# At least one Enemy has 0 Kind and 0 or bigger Agro 
		# The one with the highest DMG and lowest ENG cost (if it fails than remove it from calculation preventing a loop)
		# If the enemey has enough ENG
	# Guard if Player action result in violence and can't use ability (Increases DEF and gives a tiny bit of ENG back )

# IF ON HP
	# (Running (if possible))
	# Health check if possible heal ENG or HP with anything possible
	# Use Guard (Increases DEF and gives a tiny bit of ENG back )
# -------------------------------------
# Agressive Enemy which can get scared easily 
# Baller Roll attack (Melee)
# Baller Spiky Dive attack (Melee)
# Baller Bite attack (Melee)
# Baller has Spiky Defense that restores ENG and increases DEF and could DMG melee attacks for 2 turns
# Baller has a Scream that decreases Targets ATK by 1
# Baller has a Growl that increases the ATK by 1 for himself
# Baller has a Roll act that lets him calm down 
# Baller has no items


func _EnemyAI(deck):
	_data_analysis()
	_deck_sorting(deck)
	before_enemy_turn = []
	before_enemy_turn_player = []
	player_actions = []
	_sort_before_self(enemy_it_self)
	_same_type_enemy(enemy_it_self)
	_get_actions_player(enemy_it_self)
	_attack_card_scoring()
	# ENG restoring area
	if  energy_restore_check <= enemy_current_ENG and enemy_current_ENG <= personality_energy_precent: # roll for hael
		pass
	elif energy_restore_check > enemy_current_ENG: # garandteed heal
		pass
	
	# Ability useage
	var agro_check: bool = false
	if before_enemy_turn_player != [] and player_actions != []:
		var temp_array = PlayerAgro.values()
		for i in temp_array:
			if i != 0:
				agro_check = true
				break
		
		if !agro_check:
			temp_array = PlayerKind.values()
			if temp_array.max() == 0:
				agro_check = true
	
	# Kindness route (aka choose random act)
	if !agro_check:
		pass
		
	# Angy ( than attack >:) )
	else:
		pass
		
		
		#if player_actions[0][0] == "atk":
			#choose_ability = "Bite"
			#choose_random_player = player_actions[0][2]
			#enemy_group.all_e_action.push_back(["atk",0,enemy_it_self,choose_random_player,choose_ability])
		#else:
			#enemy_group.all_e_action.push_back(["act",0,enemy_it_self,enemy_it_self,"Talk",act_panel_choice])
	#else:
		#enemy_group.all_e_action.push_back(["atk",0,enemy_it_self,initiative.sorted_player[choose_random_player],choose_ability])
		
