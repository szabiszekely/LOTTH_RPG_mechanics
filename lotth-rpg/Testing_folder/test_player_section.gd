extends Node
class_name Player_Selection

@export var test_order: Test_order
@export var enemy_section: Enemy_Selection

var all_player_action: Array
var player_turn_end = false
var p_index = 0

func _start_player_section():
	all_player_action.clear()
	p_index = 0
	player_turn_end = false
	test_order.player_group[p_index].my_turn = true
	
	
func _process(delta: float) -> void:
	if len(test_order.player_group) == len(all_player_action) and !player_turn_end:
		player_turn_end = true
		enemy_section._start_enemy_section(all_player_action)
