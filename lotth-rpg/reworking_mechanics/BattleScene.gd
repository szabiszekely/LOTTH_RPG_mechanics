extends Node2D
class_name BattleMain

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var player_group = RefrenceNode.PlayerGroup
@onready var enemy_group = RefrenceNode.EnemyGroup
@onready var initiative = RefrenceNode.InitiativeHandler

@export var kb_force = 5.0

func _ready() -> void:
	initiative._getting_groups(player_group,enemy_group)
	initiative._get_the_index_with_order()
	initiative._get_player_and_enemy_spearated()

	player_group._player_start_choosing()
	
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("debug_button_2"):
		_full_reset()
	
	if Input.is_action_just_pressed("debug_button"):
		
		#player_group.all_p_actions.push_back(["TEST",1,self,self,1,1])
		#player_group.player[0]._take_damage(7,6,1,1,7)
		#player_group.player[1].global_position.y -= 7.5521784562331/2
		#player_group.player[1].global_position.x -= 7.5521784562331
		var p_kb_dir = (player_group.player[1].global_position - get_global_mouse_position()).normalized()
		var e_kb_dir = (enemy_group.enemies[0].global_position - get_global_mouse_position()).normalized()

		player_group.player[1]._apply_kb(p_kb_dir,kb_force,0.12)
		enemy_group.enemies[0]._apply_kb(e_kb_dir,kb_force,0.12)
	if Input.is_action_just_pressed("debug_button_3"):
		player_group.player[1].global_position.y += 7.5521784562331/2
		player_group.player[1].global_position.x += 7.5521784562331

		#player_group.player[1].Bar.queue_free()
		#player_group.player[1].queue_free()
		pass

func _reset():
	player_group._get_me_some_of_that_gd_children_player()
	enemy_group._get_me_some_of_that_gd_children_enemy()
	#initiative._roll_reset()
	initiative._getting_all_rolls(initiative.all_rolls,initiative.place_holder_source)
	initiative._get_the_index_with_order()
	initiative.all_actions.clear()
	for i in initiative.all_rolls.size():
		initiative.index_order[i][1].your_turn = false
	initiative.initiative_index = 0
	initiative.sorted_player.clear()
	initiative.sorted_enemies.clear()
	initiative._get_player_and_enemy_spearated()
	player_group._player_start_choosing()
	for i in player_group.player:
		i.Bar._reset_action_indicator()
		i.movement_restriction = false



func _full_reset():
	player_group._get_me_some_of_that_gd_children_player()
	enemy_group._get_me_some_of_that_gd_children_enemy()
	initiative._roll_reset()
	initiative._get_the_index_with_order()
	initiative.all_actions.clear()
	for i in initiative.all_rolls.size():
		initiative.index_order[i][1].your_turn = false
	initiative.initiative_index = 0
	initiative.sorted_player.clear()
	initiative.sorted_enemies.clear()
	initiative._get_player_and_enemy_spearated()
	player_group._player_start_choosing()
	for i in player_group.player:
		i.Bar._reset_action_indicator()
	

	
	
