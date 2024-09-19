extends Control
class_name Indicator_bar

@export var assined_characters: Fighting_Stats

@onready var ENG_bar = $ENG_Segmented_Bar
@onready var HP_bar = $HP_Segmented_Bar
@onready var Null_barr = $NULL
@onready var name_tag: Label = $Name_tab/Label
@onready var Health_number: Label = $Health/Label
@onready var Energy_number: Label = $Energy/Label


var offset_value : float

var current_health: int

func _ready():
	print(assined_characters.MAX_HP)
	ENG_bar.material.set_shader_parameter("count",assined_characters.MAX_ENG)
	HP_bar.material.set_shader_parameter("count",assined_characters.MAX_HP)
	print(HP_bar.material.get_shader_parameter("count"))
	name_tag.text = assined_characters.name
	energy_changed()
	health_changed()
	
	offset_value = 1.0/ENG_bar.material.get_shader_parameter("count")
	
	ENG_bar.material.set_shader_parameter("value",ENG_bar.material.get_shader_parameter("value") - offset_value/2)
	
	HP_bar.material.set_shader_parameter("value",HP_bar.material.get_shader_parameter("value") - offset_value/2)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if not ENG_bar.material.get_shader_parameter("value") < 0:
			ENG_bar.material.set_shader_parameter("value",ENG_bar.material.get_shader_parameter("value") - offset_value)
			
		else:
			HP_bar.material.set_shader_parameter("value",HP_bar.material.get_shader_parameter("value") - offset_value)
			
			
func health_changed():
	Health_number.text = str(assined_characters.HP) + "|" + str(assined_characters.MAX_HP)
func energy_changed():
	Energy_number.text = str(assined_characters.ENG) + "|" + str(assined_characters.MAX_ENG)
