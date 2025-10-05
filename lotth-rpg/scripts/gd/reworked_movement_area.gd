extends Area2D

@onready var get_player: Player 



func _player_left_the_circle(body: Node2D) -> void:
	if body == get_player:
		print("out")
