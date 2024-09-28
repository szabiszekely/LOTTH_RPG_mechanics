extends PanelContainer

@export var enemy_group: Enemy_group
@export var player_group: Player_group



func abilities_pressed() -> void:
	pass # Replace with function body.


func action_pressed() -> void:
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,753),0.2).set_trans(Tween.TRANS_QUAD)
	await tweens.finished
	
	self.hide()
	enemy_group._start_choosing()
	enemy_group.act = true

func bagpack_pressed() -> void:
	pass # Replace with function body.


func run_pressed() -> void:
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if enemy_group.act == true:
			enemy_group._reset_focus()
			self.show()
			var tweens = get_tree().create_tween()
			tweens.tween_property(self,"position",Vector2(self.position.x,533),0.2).set_trans(Tween.TRANS_QUAD)
			await tweens.finished
			self.find_child("Action").grab_focus()
		if enemy_group.act == false and enemy_group.options_are_on == true:
			enemy_group._start_choosing()
			enemy_group.act_options.act_disappear()
			var tweens = get_tree().create_tween()
			tweens.tween_property(self,"position",Vector2(self.position.x,753),0.2).set_trans(Tween.TRANS_QUAD)
			await tweens.finished
			self.hide()
			enemy_group.options_are_on = false
			enemy_group.act = true
			
