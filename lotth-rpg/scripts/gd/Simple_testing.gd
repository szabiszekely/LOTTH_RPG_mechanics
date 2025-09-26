extends Node2D
class_name Main




# THIS IS UNUSED FEATURE
# DO NOT EDIT OR USE IT!!!!
# DUMB BELL!!!!










@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var player = RefrenceNode.PlayerGroup
@onready var enemy = RefrenceNode.EnemyGroup
@onready var initiative = RefrenceNode.InitiativeHandler
@onready var turn_handler = RefrenceNode.TurnHandler

func _ready() -> void:
		
	initiative._getting_groups(player,enemy)
	#print(player.player[0].Initiative.all_rolls)
	initiative._get_the_index_with_order()
	#print(initiative.index_order)
	initiative.index_order[0][1].your_turn = true
	print(initiative.MaxTurns)
	$PCamTarget.enabled = true
	await get_tree().create_timer(2).timeout
	$PCamTarget.enabled = false


	
func _process(_delta: float) -> void:
	
	if initiative.action_queued.size() == initiative.MaxTurns and not initiative.action_start:
		$PCamTarget.enabled = true
		initiative.action_start = true
		initiative.index_order[initiative.all_rolls.size() - 1][1].your_turn = false
		#PUT THE TURN START CODE HERE LATER !!!!! and delete this!!!!
		await turn_handler._actions(initiative.action_queued)
		$PCamTarget.enabled = false
	pass
	if Input.is_action_just_pressed("debug_button"):
		initiative._roll_reset()
		initiative._get_the_index_with_order()
		initiative.action_queued.clear()
		print("--------------------------------")
		#print("all the rolls: ",initiative.all_rolls)
		print("this is the index order (friend or foe, index): ", initiative.index_order)
		for i in initiative.all_rolls.size():
			initiative.index_order[i][1].your_turn = false
		initiative.index_order[0][1].your_turn = true
		initiative.initiative_index = 0
	if Input.is_action_just_pressed("Cam_change"):
		print("--------------")
		print("all rolls: ",initiative.all_rolls)
		print("index order: ",initiative.index_order)
		print("initiative index: ",initiative.initiative_index)
		print("action queued: ",initiative.action_queued)
		print("action starts: ",initiative.action_start)
		print("Max Turns: ",initiative.MaxTurns)
		print("--------------")
