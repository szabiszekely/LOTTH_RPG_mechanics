extends Control
class_name EMP_Bar_system

@export var assined_characters: Character_Controller 
@onready var emp_meter: ColorRect = $EMP_Meter
@onready var godess_head: Sprite2D = $godess_head

func _ready() -> void:
	emp_meter.material.set_shader_parameter("segment_count", assined_characters.Fight_stats.MAX_EMP)
	godess_head.frame = 0
	
func _process(_delta: float) -> void:
	emp_meter.set_bar_value(assined_characters.Fight_stats.EMP)
	if emp_meter.is_full():
		godess_head.frame = 1
