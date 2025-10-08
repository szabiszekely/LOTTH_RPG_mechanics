extends Area2D

@onready var get_player: Player 
func _process(_delta: float) -> void:
	if get_overlapping_bodies().size() < 1:
		get_player.velocity += (self.global_position - get_player.global_position).normalized() * 145
		get_player.move_and_slide()
