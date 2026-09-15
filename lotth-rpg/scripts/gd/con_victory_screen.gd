extends Control

@onready var panel: Panel = $Panel
@onready var particle_1: CPUParticles2D = $GPUParticles2D
@onready var particle_2: CPUParticles2D = $GPUParticles2D2

func _ready() -> void:
	pass
	
func _victory_screen_fade_in():
	panel.scale = Vector2(2.1,2.1)
	var tween = get_tree().create_tween()
	tween.tween_property(panel,"scale",Vector2(1,1),1.2).set_trans(Tween.TRANS_BACK)
	await tween.finished
	particle_1.restart()
	particle_2.restart()

func _victory_screen_fade_out():
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_button"):
		_victory_screen_fade_in()
