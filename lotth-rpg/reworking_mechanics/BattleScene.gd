extends Node2D
class_name BattleMain

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var player = RefrenceNode.PlayerGroup
@onready var enemy = RefrenceNode.EnemyGroup
@onready var initiative = RefrenceNode.InitiativeHandler


func _ready() -> void:
	initiative._getting_groups(player,enemy)
	initiative._get_the_index_with_order()
	initiative._get_player_and_enemy_spearated()
	print(initiative.sorted_player)

	#player._player_start_choosing()
	
func _process(delta: float) -> void:
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
		
func _full_reset():
	initiative._roll_reset()
	initiative._get_the_index_with_order()
	initiative.action_queued.clear()
	for i in initiative.all_rolls.size():
		initiative.index_order[i][1].your_turn = false
	initiative.initiative_index = 0
	initiative.sorted_player.clear()
	initiative.sorted_enemies.clear()
	initiative._get_player_and_enemy_spearated()
	player._player_start_choosing()

	
	
