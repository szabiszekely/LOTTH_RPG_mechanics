extends Node2D

@export var player: Player_group
@export var enemy: Enemy_group
@export var menu: PanelContainer
@export var initiative: Initiative_class
@export var turn_handler: Node
@export var visible_action_queued: Array
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
	visible_action_queued = initiative.action_queued
	
	if initiative.action_queued.size() == initiative.MaxTurns and not initiative.action_start:
		$PCamTarget.enabled = true
		initiative.action_start = true
		initiative.index_order[initiative.all_rolls.size() - 1][1].your_turn = false
		#PUT THE TURN START CODE HERE LATER !!!!! and delete this!!!!ú
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
