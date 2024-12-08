extends Control
class_name Indicator_bar

#assig it to a character!
@export var assined_characters: Character_Controller
#ALL of the components!
@onready var ENG_bar = $ENG_Segmented_Bar
@onready var HP_bar = $HP_Segmented_Bar
@onready var Null_barr = $NULL
@onready var name_tag: Label = $Name_tab/Label
@onready var Health_number: Label = $Health/Label
@onready var Energy_number: Label = $Energy/Label
@onready var health_text: Panel = $Health
@onready var energy_text: Panel = $Energy
# this value is the one that will have a float number to decrease it or increase the health!
var offset_value : float

var current_health: int

func _ready():
	
	#Setting the 'count' which is the max number in the shader to the max hp and max eng
	ENG_bar.material.set_shader_parameter("count",assined_characters.Fight_stats.MAX_ENG)
	HP_bar.material.set_shader_parameter("count",assined_characters.Fight_stats.MAX_HP)
	name_tag.text = assined_characters.Fight_stats.name
	energy_changed()
	health_changed()
	# I dived the number of health by 1 and get a really small number that is 1 portion of the entire bar and this is our 1 incruments!
	offset_value = 1.0/ENG_bar.material.get_shader_parameter("count")
	# I honestly have no idea what does dividing by 2 does 
	#but i know that I must take 1 damage when starting bc the first damage does not count
	ENG_bar.material.set_shader_parameter("value",ENG_bar.material.get_shader_parameter("value") - offset_value/2)
	
	HP_bar.material.set_shader_parameter("value",HP_bar.material.get_shader_parameter("value") - offset_value/2)
	
	
	
func _process(_delta: float) -> void:
	#ugly but I can't do shit about it!
	health_changed()
	energy_changed()
		
func bar_damage_taken(damage:int):
	#every damage I took I do this so... animation!
	for i in damage:
		# if ENG bigger than 0 than I just take away 1 bar and shake the little snack at the top!
		if not ENG_bar.material.get_shader_parameter("value") < 0:
			ENG_bar.material.set_shader_parameter("value",ENG_bar.material.get_shader_parameter("value") - offset_value)
			var tweens = get_tree().create_tween()
			tweens.tween_property(energy_text,"position",Vector2(energy_text.position.x - 10,energy_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			tweens.tween_property(energy_text,"position",Vector2(energy_text.position.x + 10,energy_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			tweens.tween_property(energy_text,"position",Vector2(energy_text.position.x + 0,energy_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			assined_characters.Fight_stats.ENG -= 1
			await get_tree().create_timer(0.32).timeout
			if assined_characters.Fight_stats.ENG <= 0:
				assined_characters.Fight_stats.ENG = 0
			#print("INSIDE: ",assined_characters.Fight_stats.ENG)
		# same here but with the heart!
		elif not HP_bar.material.get_shader_parameter("value") < 0:
			HP_bar.material.set_shader_parameter("value",HP_bar.material.get_shader_parameter("value") - offset_value)
			var tweens = get_tree().create_tween()
			tweens.tween_property(health_text,"position",Vector2(health_text.position.x - 10,health_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			tweens.tween_property(health_text,"position",Vector2(health_text.position.x + 10,health_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			tweens.tween_property(health_text,"position",Vector2(health_text.position.x + 0,health_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			assined_characters.Fight_stats.HP -= 1
			await get_tree().create_timer(0.32).timeout
			
			if assined_characters.Fight_stats.HP <= 0:
				assined_characters.Fight_stats.HP = 0

func bar_health_restored(health_gain:int,heal_eng_or_health: int):
	#print("Hi I'm: ", health_gain)
	for i in health_gain:
		# same here but with the heart!
		match heal_eng_or_health:
			1:
				# if ENG bigger than 0 than I just take away 1 bar and shake the little snack at the top!
				if not assined_characters.Fight_stats.ENG >= assined_characters.Fight_stats.MAX_ENG:
					#print(assined_characters.Fight_stats.ENG)
					ENG_bar.material.set_shader_parameter("value",ENG_bar.material.get_shader_parameter("value") + offset_value)
					assined_characters.Fight_stats.ENG += 1
					await get_tree().create_timer(0.15).timeout
				
			2:
				if not assined_characters.Fight_stats.HP >= assined_characters.Fight_stats.MAX_HP:
					HP_bar.material.set_shader_parameter("value",HP_bar.material.get_shader_parameter("value") + offset_value)
					assined_characters.Fight_stats.HP += 1
					await get_tree().create_timer(0.15).timeout
			
			
			

# These are here for the numbers besid the players so you don't have to guess for your own hp and eng
func health_changed():
	Health_number.text = str(assined_characters.Fight_stats.HP) + "|" + str(assined_characters.Fight_stats.MAX_HP)
func energy_changed():
	Energy_number.text = str(assined_characters.Fight_stats.ENG) + "|" + str(assined_characters.Fight_stats.MAX_ENG)
