extends Node

@onready var RefrenceNode: CrossRoad = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var turn_handler = RefrenceNode.TurnHandler
@onready var Menu = RefrenceNode.Menu
@onready var ability_func = RefrenceNode.AbiHandler
@onready var enemy_group = RefrenceNode.EnemyGroup
@onready var player_group = RefrenceNode.PlayerGroup
@onready var initiative = RefrenceNode.InitiativeHandler

# in the turn handler this helps point to the correct variable, and if it turns out
# that the player does want to heal, then it helps to pick a different player,
# instead the dead guy in the battlefield 
var is_this_heal = [1]
# this is where the ability will get processed up

#player.all_p_actions.push_back(["atk",0,initiative.sorted_player[player.p_index],enemies[sub_e_index],card_againts_enemies])
# atk, which, from, to, card, is it a status?, turn timer
func _Ability_Turn(list:Array):
	# this checks for if the current guy, who we are letting through the turn, is alive
	# or dead/KOd
	turn_handler._Does_opponent_exist(list,is_this_heal)
	match list[1]:
		0: ## player attacks enemy targeted
			list[2]._use_card_and_lose_eng(list[4])
			if Data.get_card_damage_type(list[4]):
				list[3]._take_true_damage(Data.get_card_damage(list[4]))
			else:
				list[3]._take_damage(Data.get_card_damage(list[4]),Data.get_card_attack_type(list[4]),list[2])
			ability_func._get_what_ability_got_used(list[4],Menu,enemy_group,player_group,list[4],list[2])
			
		1: ## it is for team heals/buffs
			list[2]._use_card_and_lose_eng(list[4])
			list[3]._use_card_and_gain_eng(list[4],Data.get_card_eng_or_hp(list[4]))
			ability_func._get_what_ability_got_used(list[4],Menu,enemy_group,player_group,list[2],list[3])
		2: ## it is for skills
			turn_handler.initiative.doTrapForLoop = true
			list[2]._use_card_and_lose_eng(list[4])
			ability_func._get_what_ability_got_used(list[4],Menu,enemy_group,player_group,list[2],list[3])

	if list[5]:
		list[3].Fight_stats.STAT_Resource._Get_Current_Headers(list[3].Fight_stats.Header_Array)
		list[3].Fight_stats._Database_append(list[3].Fight_stats.STAT_Resource._Stat_change("Turn",list[6],Data.get_stats_types(Data.get_card_stats(list[4]))))
		list[3].Fight_stats._Apply_Stats()

	
