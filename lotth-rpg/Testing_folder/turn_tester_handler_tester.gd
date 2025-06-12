extends Node
class_name test_turn_handler_tester

signal waiting_for_input
@onready var testNodeBranch: test_Node_Branch = $"../Node_Branch"

@onready var main_node = testNodeBranch.turnMain
@onready var test_attack = testNodeBranch.optionAbi
@onready var test_act = testNodeBranch.optionAct
@onready var test_bag = testNodeBranch.optionBag
@onready var test_run = testNodeBranch.optionRun
@onready var characterIcon = preload("res://Testing_folder/test_icon.tscn")
@onready var options_played_out: HBoxContainer = $"../OptionsPlayedOut"

var currentTurnDatabase : Array = []


func _turn_play_out_start() -> void:
	if currentTurnDatabase.size() == main_node.order.size():
		for i in currentTurnDatabase:
			print(i)
			var func_list
			match i[0]:
				1:
					func_list = test_attack._get_attack(i)
				2:
					func_list = test_act._get_act(i)
				3:
					func_list = test_bag._get_bag(i)
				4:
					func_list = test_run._get_run(i)
					
			var ch_name = func_list[0]
			var ch_action = func_list[2]
			var ch_outcome = func_list[1]
			
			var instance= characterIcon.instantiate()
			instance.CharacterName = ch_name 
			instance.Action = ch_action
			instance.Outcome = ch_outcome
			options_played_out.add_child(instance)
			await get_tree().create_timer(1).timeout
		await waiting_for_input
		currentTurnDatabase.clear()
		main_node._turn()
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_button") and currentTurnDatabase.size() == main_node.order.size():
		print("pressed")
		waiting_for_input.emit()
	
