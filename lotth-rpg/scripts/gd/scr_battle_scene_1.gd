extends BattleMain

@export var kb_force = 5.0

func _ready() -> void:
	initiative._getting_groups(player_group,enemy_group)
	initiative._get_the_index_with_order()
	initiative._get_player_and_enemy_spearated()
	player_group._player_start_choosing()
	RefrenceNode.DialogicControl._begining_setup()


func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("debug_button_2"):
		_full_reset()

	if Input.is_action_just_pressed("debug_button"):
		#_reset()
		#RefrenceNode.DialogicControl._start_dialog("act_Talk")
		RefrenceNode.PlayerGroup.all_p_actions.push_back(["act",0,RefrenceNode.InitiativeHandler.sorted_player[0],RefrenceNode.EnemyGroup.enemies[0],"Talk",self])

		#print(RefrenceNode.DialogicControl.dialog_main)
		#player_group.all_p_actions.push_back(["TEST",1,self,self,1,1])
		#player_group.player[0]._take_damage(1,1,enemy_group.enemies[0])
		#player_group.player[1]._take_damage(1,1,enemy_group.enemies[0])
		#player_group.player[2]._take_damage(1,1,enemy_group.enemies[0])
		#player_group.player[3]._take_damage(1,1,enemy_group.enemies[0])
		##player_group.player[1].global_position.y -= 7.5521784562331/2
		#player_group.player[1].global_position.x -= 7.5521784562331
		#var p_kb_dir = (player_group.player[1].global_position - get_global_mouse_position()).normalized()
		#var e_kb_dir = (enemy_group.enemies[0].global_position - get_global_mouse_position()).normalized()
		#player_group.player[1]._apply_kb(p_kb_dir,kb_force,0.12)
		#enemy_group.enemies[0]._apply_kb(e_kb_dir,kb_force,0.12)
	if Input.is_action_just_pressed("debug_button_3"):
		player_group.player[1].global_position.y += 7.5521784562331/2
		player_group.player[1].global_position.x += 7.5521784562331

		#player_group.player[1].Bar.queue_free()
		#player_group.player[1].queue_free()
		pass
