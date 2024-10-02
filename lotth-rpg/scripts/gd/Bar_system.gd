extends Control
class_name Indicator_bar

@export var assined_characters: Fighting_Stats

@onready var ENG_bar = $ENG_Segmented_Bar
@onready var HP_bar = $HP_Segmented_Bar
@onready var Null_barr = $NULL
@onready var name_tag: Label = $Name_tab/Label
@onready var Health_number: Label = $Health/Label
@onready var Energy_number: Label = $Energy/Label
@onready var health_text: Panel = $Health
@onready var energy_text: Panel = $Energy

var offset_value : float

var current_health: int

func _ready():
	ENG_bar.material.set_shader_parameter("count",assined_characters.MAX_ENG)
	HP_bar.material.set_shader_parameter("count",assined_characters.MAX_HP)
	name_tag.text = assined_characters.name
	energy_changed()
	health_changed()
	
	offset_value = 1.0/ENG_bar.material.get_shader_parameter("count")
	
	ENG_bar.material.set_shader_parameter("value",ENG_bar.material.get_shader_parameter("value") - offset_value/2)
	
	HP_bar.material.set_shader_parameter("value",HP_bar.material.get_shader_parameter("value") - offset_value/2)
	
	
	
func _process(_delta: float) -> void:
	health_changed()
	energy_changed()
		
func bar_damage_taken(damage:int):
	
	for i in damage:
		
		if not ENG_bar.material.get_shader_parameter("value") < 0:
			ENG_bar.material.set_shader_parameter("value",ENG_bar.material.get_shader_parameter("value") - offset_value)
			var tweens = get_tree().create_tween()
			tweens.tween_property(energy_text,"position",Vector2(energy_text.position.x - 10,energy_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			tweens.tween_property(energy_text,"position",Vector2(energy_text.position.x + 10,energy_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			tweens.tween_property(energy_text,"position",Vector2(energy_text.position.x + 0,energy_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			await get_tree().create_timer(0.16).timeout
		else:
			HP_bar.material.set_shader_parameter("value",HP_bar.material.get_shader_parameter("value") - offset_value)
			var tweens = get_tree().create_tween()
			tweens.tween_property(health_text,"position",Vector2(health_text.position.x - 10,health_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			tweens.tween_property(health_text,"position",Vector2(health_text.position.x + 10,health_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			tweens.tween_property(health_text,"position",Vector2(health_text.position.x + 0,health_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			await get_tree().create_timer(0.16).timeout

func health_changed():
	Health_number.text = str(assined_characters.HP) + "|" + str(assined_characters.MAX_HP)
func energy_changed():
	Energy_number.text = str(assined_characters.ENG) + "|" + str(assined_characters.MAX_ENG)
