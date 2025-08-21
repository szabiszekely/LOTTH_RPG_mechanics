extends Node

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var turn_handler = RefrenceNode.TurnHandler
@onready var Menu = RefrenceNode.Menu
@onready var ability_func = RefrenceNode.AbiHandler
@onready var enemy_group = RefrenceNode.EnemyGroup
@onready var player_group = RefrenceNode.PlayerGroup
@onready var initiative = RefrenceNode.InitiativeHandler

var is_this_heal = [1]

		

func _Ability_Turn(list:Array):
	turn_handler._Does_opponent_exist(list,is_this_heal)
	#print(player_group.player)
	match list[1]:
		0: ## player attacks enemy targeted
			list[2]._use_card_and_lose_eng(list[4])
			if Data.get_card_damage_type(list[4]):
				list[3]._take_true_damage(Data.get_card_damage(list[4]))
			else:
				list[3]._take_damage(list[2].Fight_stats.Base_Phisical_Attack,Data.get_card_damage(list[4]),list[2].Fight_stats.Attack_Type,Data.get_card_attack_type(list[4]),list[2].Fight_stats.Base_Magical_Attack)
			ability_func._get_what_ability_got_used(list[4],Menu,enemy_group,player_group,list[4],list[2])
			
		1: ## it is for team heals/buffs
			# (["atk",1,initiative.sorted_player[p_index],player[sub_index],card_againts_players])
			list[2]._use_card_and_lose_eng(list[4])
			list[3]._use_card_and_gain_eng(list[4],Data.get_card_eng_or_hp(list[4]))
			ability_func._get_what_ability_got_used(list[4],Menu,enemy_group,player_group,list[2],list[3])
		2: ## its is for skills
			turn_handler.initiative.doTrapForLoop = true
			list[2]._use_card_and_lose_eng(list[4])
			ability_func._get_what_ability_got_used(list[4],Menu,enemy_group,player_group,list[2],list[3])
		#3: ## enemy attacks
			#list[2]._use_card_and_lose_eng(list[4])
			#
			#if Data.get_card_damage_type(list[4]):
				#list[3]._take_true_damage(Data.get_card_damage(list[4]))
			#else:
				#list[3]._take_damage(list[2].Fight_stats.Base_Phisical_Attack, Data.get_card_damage(list[4]),list[2].Fight_stats.Attack_Type,Data.get_card_attack_type(list[4]),list[4].Fight_stats.Base_Magical_Attack)
			#ability_func._get_what_ability_got_used(list[1],Menu,enemy_group,player_group,list[4],list[2])
