extends CanvasLayer
class_name Fade

@onready var panel: Panel = $Panel

signal faded_in

func _ready() -> void:
	panel.modulate = Color.TRANSPARENT

func _fade_in(time: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(panel,"modulate",Color.BLACK,time)
	await tween.finished
	_faded_in()
	
func _fade_out(time: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(panel,"modulate",Color.TRANSPARENT,time)
	await tween.finished
	panel.queue_free()
	
func _faded_in():
	faded_in.emit()
