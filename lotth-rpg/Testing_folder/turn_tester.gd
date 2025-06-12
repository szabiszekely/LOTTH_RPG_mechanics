extends Control
class_name test_main

signal next_player
@onready var node_branch: test_Node_Branch = $Node_Branch


@onready var currentPlayer = $CurrentPlayer
@onready var options: HBoxContainer = $Options
@onready var options_played_out: HBoxContainer = $OptionsPlayedOut
@onready var turnHandler = node_branch.turnHandler
@onready var enemyHandler = node_branch.enemyHandler

var order = ["Player1","Player2","Enemy1","Enemy2"]
var current_player
var player_index
var can_interact = false

func _ready():
	_turn()

# [1,"Player1",0,1-6,"ATTACK"]
# [3,"Enemy2",3,"HEAL","BAG"]
# [1,"Enemy1",2,1-6,"ATTACK"]
# [2,"Player2",1,"TALK","ACT"]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Cam_change"):
		next_player.emit()
		next_player.emit()
		turnHandler.currentTurnDatabase.clear()
		_shuffle()
		_turn()
	if event.is_action_pressed("debug_button_2"):
		pass

func _shuffle():
	randomize()
	order.shuffle()

func _turn():
	print("----------------\n")
	print(order)
	for i in options_played_out.get_children():
		i.queue_free()
	turnHandler.currentTurnDatabase.clear()
	
	for i in order:
		if i == "Player1" or i == "Player2":
			currentPlayer.text = i
			current_player = i
			can_interact = true
			player_index = order.find(i)
			await next_player
		else:
			turnHandler.currentTurnDatabase.append(enemyHandler._test_choice(i,order.find(i)))
	can_interact = false
	turnHandler._turn_play_out_start()


func _on_button_pressed() -> void:
	if can_interact:
		turnHandler.currentTurnDatabase.append([1,current_player,player_index,randi_range(1,6),"ATTACK"])
		next_player.emit()


func _on_button_2_pressed() -> void:
	randomize()
	if can_interact:
		turnHandler.currentTurnDatabase.append([2,current_player,player_index,["TALK","FLIRT","PLAY AROUND","GROWL"].pick_random(),"ACT"])
		next_player.emit()


func _on_button_3_pressed() -> void:
	if can_interact:
		turnHandler.currentTurnDatabase.append([3,current_player,player_index,["HEAL","HURT"].pick_random(),"BAG"])
		next_player.emit()


func _on_button_4_pressed() -> void:
	if can_interact:
		turnHandler.currentTurnDatabase.append([4,current_player,player_index,"YOU RAN","RUN"])
		next_player.emit()
