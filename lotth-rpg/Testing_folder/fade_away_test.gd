extends Node2D
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	animated_sprite_2d.hide()
	animated_sprite_2d.modulate = Color.TRANSPARENT
	animated_sprite_2d.play("default")
	sprite_2d.play("idle")
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d,"modulate",Color.TRANSPARENT,10).set_trans(Tween.TRANS_ELASTIC)
	await get_tree().create_timer(4).timeout
	sprite_2d.pause()
	var tween2 = get_tree().create_tween()
	animated_sprite_2d.show()
	tween2.tween_property(animated_sprite_2d,"modulate",Color.WHITE,3)
	await tween.finished
	sprite_2d.queue_free()
	
