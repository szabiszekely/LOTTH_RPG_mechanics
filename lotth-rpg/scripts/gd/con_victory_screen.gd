extends Control
class_name Victory_Screen

@onready var panel: Panel = $Panel
@onready var particle_1: CPUParticles2D = $GPUParticles2D
@onready var particle_2: CPUParticles2D = $GPUParticles2D2
@onready var gain: RichTextLabel = $Panel/Gain
@onready var soul: RichTextLabel = $Panel/Soul
@onready var left: RichTextLabel = $Panel/Left
@onready var press_anything: RichTextLabel = $Panel/Press_anything

@export var gold_gained: int = 0
@export var items_gained: Dictionary = {}
@export var soul_gained: int = 0

signal press_anything_right_now

var can_continue: bool = false

func _ready() -> void:
	press_anything.hide()
	_victory_screen_fade_in()
	

func _victory_screen_fade_in():
	panel.scale = Vector2(2.1,2.1)
	var tween = get_tree().create_tween()
	tween.tween_property(panel,"scale",Vector2(1,1),1.2).set_trans(Tween.TRANS_BACK)
	await tween.finished
	particle_1.restart()
	particle_2.restart()
	await get_tree().create_timer(2).timeout
	press_anything.show()
	can_continue = true
	await press_anything_right_now
	can_continue = false
	_victory_screen_fade_out()


func _victory_screen_fade_out():
	var tween = get_tree().create_tween()
	tween.tween_property(panel,"modulate",Color.TRANSPARENT,4)
	await tween.finished
	var instance = preload("res://scenes/con_fade.tscn").instantiate()
	self.add_child(instance)
	instance._fade_in(4)
	await instance.faded_in
	get_tree().quit()
	
func _write():
	var results = "> "
	if gold_gained > 0:
		results += str(gold_gained) + " Gold"
	if items_gained != {}:
		pass
	if soul_gained != 0:
		pass
	if results == "> ":
		gain.text = "But you gained nothing"
	else:
		gain.text = results
	
func _process(_delta: float) -> void:
	if Input.is_anything_pressed() and can_continue:
		press_anything_right_now.emit()
