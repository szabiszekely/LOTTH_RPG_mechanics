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

	player._player_start_choosing()
	
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("debug_button"):
		print("--------------")
		print(initiative._get_the_index_with_order())
		print("all rolls: ",initiative.all_rolls)
		print("index order: ",initiative.index_order)
		print("initiative index: ",initiative.initiative_index)
		print("action queued: ",initiative.all_actions)
		print("action starts: ",initiative.action_start)
		print("sorted player: ", initiative.sorted_player)
		print("sorted enemies: ", initiative.sorted_enemies)
		print("--------------")

		
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
	player._player_start_choosing()

	
	
