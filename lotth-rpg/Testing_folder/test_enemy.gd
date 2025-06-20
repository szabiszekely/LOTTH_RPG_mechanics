extends Node

var my_turn = false
@onready var current_player_indicator = find_child("CurrentPlayerIndicator")


@export var test_order: Test_order
@export var ch_name: String



func _process(delta: float) -> void:
	if my_turn == true:
		turn_red()
		enemy_turn()
		current_player_indicator.show()
			
	else:
		turn_normal()
		current_player_indicator.hide()
		
func enemy_turn():
	test_order.actions.append([ch_name,randi_range(1,4)])
	if not len(test_order.all_people) <= test_order.index + 1:
		test_order._switch(test_order.index+1,test_order.index)
		test_order.index += 1
	else:
		my_turn = false

	
func turn_red():
	self.self_modulate = Color.RED

func turn_normal():
	self.self_modulate = Color.WHITE
