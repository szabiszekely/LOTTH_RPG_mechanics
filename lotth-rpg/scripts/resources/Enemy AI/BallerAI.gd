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

# This is the ballers AI logic
func _EnemyAI(deck):
	randomize()
	# I gather data on a varity stuff (like lowest player, strongest player, weakest enemy, closest player, ect)
	_data_analysis()
	# I set up everything else to default position 
	before_enemy_turn = []
	before_enemy_turn_player = []
	player_actions = []
	# this 3 is for to sort out the player and the enemeies from eachother
	_sort_before_self(enemy_it_self)
	_same_type_enemy(enemy_it_self)
	_get_actions_player(enemy_it_self)
	# I give every card a score which help the AI decide which card to use
	_attack_card_scoring()
	# ENG restoring area
	# if the AI is low on ENG then it starts to roll for heals
	# the lower it is, the higher the chance of heal
	if  energy_restore_bottomline <= enemy_current_ENG and enemy_current_ENG <= energy_restore_upperline: # roll for hael
		var random_chance = randf_range(0,1)
		if energy_healing_percentage <= random_chance:
			enemy_group.all_e_action.push_back(["atk",1,enemy_it_self,enemy_it_self,Defense_deck[0]])
			increase_failed_heal_percentage = 0
			break_gambit = true
		else:
			increase_failed_heal_percentage += failiure_increase_number
			pass
	# how ever if the enemy is on the bottomline then it will heal reguardless of any optimal chances
	elif energy_restore_bottomline > enemy_current_ENG: # garandteed heal
		enemy_group.all_e_action.push_back(["atk",1,enemy_it_self,enemy_it_self,Defense_deck[0]])
		break_gambit = true
	
	# there is this gambit if the enemy already choosen lets say... heal then don't override it with attack
	# cause that is stupid
	if !break_gambit:
		# AI determending if it wants to atk or act
		# Ability usage
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
					agro_check = [true,false].pick_random()
		
		
		#later add to they are close to us or not
		highest_value = _find_the_highest_value(PlayerAgro)
		for i in PlayerAgro:
			var value = PlayerAgro[i]
			if value == highest_value:
				target = i
				break
				
		
		# Kindness route (aka choose random act)
		if !agro_check:
			enemy_group.all_e_action.push_back(["act",0,enemy_it_self,enemy_it_self,"Talk",act_panel_choice])
			
		# Angy ( then attack >:) )
		else:
			highest_value = _find_the_highest_value(AbilityScore)
			for i in AbilityScore:
				var value = AbilityScore[i]
				if value == highest_value:
					enemy_group.all_e_action.push_back(["atk",0,enemy_it_self,target,i])
					break
			
		
