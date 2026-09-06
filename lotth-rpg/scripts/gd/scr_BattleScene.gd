extends Node2D
class_name BattleMain

@onready var RefrenceNode:CrossRoad = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var player_group = RefrenceNode.PlayerGroup
@onready var enemy_group = RefrenceNode.EnemyGroup
@onready var initiative = RefrenceNode.InitiativeHandler

func _reset():
	player_group._get_me_some_of_that_gd_children_player()
	enemy_group._get_me_some_of_that_gd_children_enemy()
	initiative._getting_all_rolls(initiative.all_rolls,initiative.place_holder_source)
	initiative._get_the_index_with_order()
	initiative.all_actions.clear()
	for i in initiative.all_rolls.size():
		initiative.index_order[i][1].your_turn = false
	initiative.initiative_index = 0
	initiative.sorted_player.clear()
	initiative.sorted_enemies.clear()
	initiative._get_player_and_enemy_spearated()
	player_group._player_start_choosing()
	for i in player_group.player:
		i.Bar._reset_action_indicator()
		i.movement_restriction = false
	RefrenceNode.DialogicControl._start_dialog("stat_baller")



func _full_reset():
	initiative._roll_reset()
	player_group._get_me_some_of_that_gd_children_player()
	enemy_group._get_me_some_of_that_gd_children_enemy()
	initiative._get_the_index_with_order()
	initiative.all_actions.clear()
	for i in initiative.all_rolls.size():
		initiative.index_order[i][1].your_turn = false
	initiative.initiative_index = 0
	initiative.sorted_player.clear()
	initiative.sorted_enemies.clear()
	initiative._get_player_and_enemy_spearated()
	player_group._player_start_choosing()
	for i in player_group.player:
		i.Bar._reset_action_indicator()
	
