extends Node

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var turn_handler = RefrenceNode.TurnHandler
@onready var Menu = RefrenceNode.Menu
@onready var ability_func = RefrenceNode.AbiHandler
@onready var enemy_group = RefrenceNode.EnemyGroup
@onready var player_group = RefrenceNode.PlayerGroup
@onready var initiative = RefrenceNode.InitiativeHandler


func _Ability_Turn(list):
	match list[3]:
		0:
			initiative.sorted_player[list[4]]._use_card_and_lose_eng(list[1])
			
			if Data.get_card_damage_type(list[1]) == true:
				enemy_group.enemies[list[2]]._take_true_damage(Data.get_card_damage(list[1]))
			else:
				enemy_group.enemies[list[2]]._take_damage(initiative.sorted_player[list[4]].Fight_stats.Base_Phisical_Attack,Data.get_card_damage(list[1]),initiative.sorted_player[list[4]].Fight_stats.Attack_Type,Data.get_card_attack_type(list[1]),initiative.sorted_player[list[4]].Fight_stats.Base_Magical_Attack)
			
			ability_func._get_what_ability_got_used(list[1],Menu,enemy_group,player_group,list[4],list[2])
		1:
			
			initiative.sorted_player[list[4]]._use_card_and_lose_eng(list[1])
			initiative.sorted_player[list[2]]._use_card_and_gain_eng(list[1],Data.get_card_eng_or_hp(list[1]))
			ability_func._get_what_ability_got_used(list[1],Menu,enemy_group,player_group,list[4],list[2])
		2:
			turn_handler.initiative.doTrapForLoop = true
			initiative.sorted_player[list[4]]._use_card_and_lose_eng(list[1])
			ability_func._get_what_ability_got_used(list[1],Menu,enemy_group,player_group,list[4],list[2])
		3:
			print("Hoi")
			enemy_group.enemies[list[4]]._use_card_and_lose_eng(list[1])
			
			if Data.get_card_damage_type(list[1]) == true:
				initiative.sorted_player[list[2]]._take_true_damage(Data.get_card_damage(list[1]))
			else:
				initiative.sorted_player[list[2]]._take_damage(initiative.sorted_player[list[4]].Fight_stats.Base_Phisical_Attack,Data.get_card_damage(list[1]),initiative.sorted_player[list[4]].Fight_stats.Attack_Type,Data.get_card_attack_type(list[1]),initiative.sorted_player[list[4]].Fight_stats.Base_Magical_Attack)
				print("got through")
			ability_func._get_what_ability_got_used(list[1],Menu,enemy_group,player_group,list[4],list[2])
