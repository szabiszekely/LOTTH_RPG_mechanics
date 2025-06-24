extends Node
var my_turn = false
@export var test_order: Test_order
@export var ch_name: String
@export var player_section: Player_Selection

@onready var current_player_indicator = find_child("CurrentPlayerIndicator")
@onready var next_button: Button = $"../NextButton"
@onready var prev_button: Button = $"../PrevButton"


func _process(delta: float) -> void:
	if my_turn == true:
		turn_red()
		current_player_indicator.show()
			
	else:
		turn_normal()
		current_player_indicator.hide()

func turn_red():
	self.self_modulate = Color.RED

func turn_normal():
	self.self_modulate = Color.WHITE

func _on_next_button_pressed() -> void:
	if my_turn:
		player_section.all_player_action.append([ch_name,randi_range(1,4),self])
		if not len(test_order.player_group) <= player_section.p_index + 1:
			test_order._switch_p(player_section.p_index+1,player_section.p_index)
			player_section.p_index += 1
		else:
			my_turn = false

func _on_prev_button_pressed() -> void:
	if my_turn:
		if len(player_section.all_player_action) != 0:
			player_section.all_player_action.pop_back()
			test_order._switch_p(player_section.p_index-1,player_section.p_index)
			player_section.p_index -= 1
			
 
