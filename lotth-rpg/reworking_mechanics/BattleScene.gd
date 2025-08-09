extends Node2D
class_name BattleMain

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var player_group = RefrenceNode.PlayerGroup
@onready var enemy_group = RefrenceNode.EnemyGroup
@onready var initiative = RefrenceNode.InitiativeHandler


func _ready() -> void:
	initiative._getting_groups(player_group,enemy_group)
	initiative._get_the_index_with_order()
	initiative._get_player_and_enemy_spearated()

	player_group._player_start_choosing()
	
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("debug_button_2"):
		_full_reset()
	
	if Input.is_action_just_pressed("debug_button"):
		player_group.player[0].Fight_stats.HP = 0
		player_group.player[0].Fight_stats.ENG = 0
		
func _full_reset():
	initiative._roll_reset()

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
	

	
	
