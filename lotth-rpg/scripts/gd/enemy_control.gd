extends Character_Controller
class_name Enemy
#This is the enemy Controller!
@export var Turn_portriat: CompressedTexture2D
@export var Initiative: Initiative_class
@onready var Enemy_health_bar = $Bar_system



func _ready() -> void:
	 #hiding the health bar, playing the idle animation, rolling with the speed dice, and a lot more!
	
	Enemy_health_bar.hide()
	
	$character_animator.play("idle")
	var roll = Fight_stats.Speed + Fight_stats._Initiative()
	print(Fight_stats.name," ",roll)
	# this is where the rolls and other stats that needs them to be determend are stored
	# first is that are they enemy or not, than they roll!, than they speed, and finally they portrait and name!
	var initiative_peronality = [Fight_stats.Friend_or_Foe,roll,Fight_stats.Speed,Turn_portriat,Fight_stats.name]
	Initiative.all_rolls.append(initiative_peronality)
	
func emp_gained(gained_EMP: int):
	if not Fight_stats.MAX_EMP <= Fight_stats.EMP:
		Fight_stats.EMP += gained_EMP
	else:
		print("EMP gain has reached the maximum or something went wrong in the code!")
	print(str(Fight_stats.EMP) + " / " + str(Fight_stats.MAX_EMP))
