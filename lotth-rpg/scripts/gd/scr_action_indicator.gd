extends Control

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	_action_indicator_on()

func _action_indicator_on():
	animated_sprite_2d.play("On")

func _action_indicator_off():
	animated_sprite_2d.play("Off")
