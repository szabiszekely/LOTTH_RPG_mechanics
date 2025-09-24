extends Control

#assig it to a character!
@export var assined_enemy: Fighting_Stats
#ALL of the components!
@onready var emp_meter: Panel = $EMP_meter

@onready var Null_barr = $NULL
# this value is the one that will have a float number to decrease it or increase the health!
var offset_value : float
var current_health: int

func _ready():
	#Setting the 'count' which is the max number in the shader to the max hp and max eng
	emp_meter.material.set_shader_parameter("count",assined_enemy.MAX_EMP)
	# I dived the number of health by 1 and get a really small number that is 1 portion of the entire bar and this is our 1 incruments!
	offset_value = 1.0/emp_meter.material.get_shader_parameter("count")
	# I honestly have no idea what does dividing by 2 does 
	#but i know that I must take 1 damage when starting bc the first damage does not count
	emp_meter.material.set_shader_parameter("value",emp_meter.material.get_shader_parameter("value") - offset_value/2)
	
		
func bar_damage_taken(damage:int):
	#every damage I took I do this so... animation!
	for i in damage:
		# if ENG bigger than 0 than I just take away 1 bar and shake the little snack at the top!
		if not emp_meter.material.get_shader_parameter("value") < 0:
			emp_meter.material.set_shader_parameter("value",emp_meter.material.get_shader_parameter("value") - offset_value)
		
		
	
