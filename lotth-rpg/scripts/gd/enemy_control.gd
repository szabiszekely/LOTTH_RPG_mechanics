extends Character_Controller
class_name Enemy
#This is the enemy Controller!

@onready var Enemy_health_bar = $Bar_system


func _ready() -> void:
	 #hiding the health bar, playing the idle animation, rolling with the speed dice, and a lot more!
	roll_of_the_luck()
	
	#Enemy_health_bar.hide()
	
	$character_animator.play("idle")
	
	
func emp_gained(gained_EMP: int):
	if not Fight_stats.MAX_EMP <= Fight_stats.EMP:
		Fight_stats.EMP += gained_EMP
	else:
		print("EMP gain has reached the maximum or something went wrong in the code!")
	print(str(Fight_stats.EMP) + " / " + str(Fight_stats.MAX_EMP))
