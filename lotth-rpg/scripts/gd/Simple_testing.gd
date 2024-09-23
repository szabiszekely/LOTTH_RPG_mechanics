extends Node2D

@export var player: Player
@export var enemy: Enemy

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		pass


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		player._take_damage(enemy.Fight_stats.Base_Phisical_Attack,4,0,enemy.Fight_stats.Attack_Type)
	
	if Input.is_action_just_pressed("ui_down"):
		enemy._take_damage(player.Fight_stats.Base_Phisical_Attack,4,0,player.Fight_stats.Attack_Type)
	pass
