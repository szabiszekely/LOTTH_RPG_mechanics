extends Node

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var turn_handler = RefrenceNode.TurnHandler
@onready var Menu = RefrenceNode.Menu
@onready var ability_func = RefrenceNode.AbiHandler
@onready var enemy_group = RefrenceNode.EnemyGroup
@onready var player_group = RefrenceNode.PlayerGroup
@onready var initiative = RefrenceNode.InitiativeHandler

func _Does_opponent_exist(list:Array):
	var grab_a_different_character
	var count_me_in = 0
	
	if list[-1].Fight_stats.Friend_or_Foe == 0:
		if list[-2] == null:
			grab_a_different_character = enemy_group.enemies.pick_random()
			for z in enemy_group.enemies:
				if z == grab_a_different_character:
					count_me_in += 1
					break
				else:
					count_me_in += 1
			list.pop_at(2)
			list.insert(2,count_me_in)
			return list
	else:
		if list[-2] == null:
			grab_a_different_character = player_group.player.pick_random()
			for z in player_group.player:
				if z == grab_a_different_character:
					count_me_in += 1
					break
				else:
					count_me_in += 1
			list.pop_at(2)
			list.insert(2,count_me_in)
			return list
func _Ability_Turn(list:Array):
	_Does_opponent_exist(list)
	print(player_group.player)
	match list[3]:
		0: ## player attacks enemy targeted
			
			initiative.sorted_player[list[4]]._use_card_and_lose_eng(list[1])
			
			if Data.get_card_damage_type(list[1]) == true:
				initiative.sorted_enemies[list[2]]._take_true_damage(Data.get_card_damage(list[1]))
			else:
				initiative.sorted_enemies[list[2]]._take_damage(initiative.sorted_player[list[4]].Fight_stats.Base_Phisical_Attack,Data.get_card_damage(list[1]),initiative.sorted_player[list[4]].Fight_stats.Attack_Type,Data.get_card_attack_type(list[1]),initiative.sorted_player[list[4]].Fight_stats.Base_Magical_Attack)
			
			ability_func._get_what_ability_got_used(list[1],Menu,enemy_group,player_group,list[4],list[2])
		1: ## it is for team heals/buffs
			#    what     card						
			#  ["atk"  ,  card_againts_players  ,  sub_index  ,  1  ,  p_index   ,player[sub_index]  ]
			initiative.sorted_player[list[4]]._use_card_and_lose_eng(list[1])
			initiative.sorted_player[list[2]]._use_card_and_gain_eng(list[1],Data.get_card_eng_or_hp(list[1]))
			ability_func._get_what_ability_got_used(list[1],Menu,enemy_group,player_group,list[4],list[2])
		2: ## its is for skills
			turn_handler.initiative.doTrapForLoop = true
			initiative.sorted_player[list[4]]._use_card_and_lose_eng(list[1])
			ability_func._get_what_ability_got_used(list[1],Menu,enemy_group,player_group,list[4],list[2])
		3: ## enemy attacks
			print("Hoi")
			initiative.sorted_enemies[list[4]]._use_card_and_lose_eng(list[1])
			
			if Data.get_card_damage_type(list[1]) == true:
				print(initiative.sorted_player[list[2]])
				initiative.sorted_player[list[2]]._take_true_damage(Data.get_card_damage(list[1]))
			else:
				initiative.sorted_player[list[2]]._take_damage(initiative.sorted_enemies[list[4]].Fight_stats.Base_Phisical_Attack, Data.get_card_damage(list[1]),initiative.sorted_enemies[list[4]].Fight_stats.Attack_Type,Data.get_card_attack_type(list[1]),initiative.sorted_enemies[list[4]].Fight_stats.Base_Magical_Attack)
				print("got through")
			ability_func._get_what_ability_got_used(list[1],Menu,enemy_group,player_group,list[4],list[2])
