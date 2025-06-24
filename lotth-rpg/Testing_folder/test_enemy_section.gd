extends Node
class_name Enemy_Selection

@export var test_order: Test_order

var all_enemy_action: Array
var enemy_turn_end = false
var e_index = 0
var p_actions

func _start_enemy_section(player_options):
	all_enemy_action.clear()
	enemy_turn_end = false
	e_index = 0
	test_order.enemy_group[e_index].my_turn = true
	p_actions = player_options
	
	
func _process(delta: float) -> void:
	if len(test_order.enemy_group) == len(all_enemy_action) and !enemy_turn_end:
		enemy_turn_end = true
		
		
		for i in p_actions:
			test_order.actions.append(i)
		for i in all_enemy_action:
			test_order.actions.append(i)
		test_order.play_out._play_out(test_order.actions)
