extends Control
class_name EMP_Bar_system

@export var assined_characters: Character_Controller 
@onready var emp_meter: ColorRect = $EMP_Meter
@onready var godess_head: Sprite2D = $godess_head

func _ready() -> void:
	emp_meter.material.set_shader_parameter("segment_count", assined_characters.Fight_stats.MAX_EMP)
	emp_meter.set_max_value(assined_characters.Fight_stats.MAX_EMP,false)
	print(emp_meter.material.get_shader_parameter("segment_count"))
	print(emp_meter.material.get_shader_parameter("discrete_fill_amount"))
	emp_meter.set_bar_value(0,false)
	godess_head.frame = 0

func _increase_emp(amount):
	emp_meter.increase_bar_value(amount)
	print(emp_meter.material.get_shader_parameter("segment_count"))
	print(emp_meter.material.get_shader_parameter("discrete_fill_amount"))
	print(emp_meter.get_current_value())
	if emp_meter.is_full():
		godess_head.frame = 1
