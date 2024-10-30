extends Character_Controller
class_name Enemy
#This is the enemy Controller!
@export var Turn_portriat: CompressedTexture2D
@export var Initiative: Initiative_class
@onready var Enemy_health_bar = $Bar_system
@onready var cam_target: Node2D = $PCamTarget


func _ready() -> void:
	 #hiding the health bar, playing the idle animation, rolling with the speed dice, and a lot more!
	Enemy_health_bar.hide()
	$character_animator.play("idle")
	var roll = Fight_stats.Speed + Fight_stats._Initiative()
	print(roll)
	# this is where the rolls and other stats that needs them to be determend are stored
	# first is that are they enemy or not, than they roll!, than they speed, and finally they portrait and name!
	var initiative_peronality = [Fight_stats.Friend_or_Foe,roll,Fight_stats.Speed,Turn_portriat,Fight_stats.name]
	Initiative.all_rolls.append(initiative_peronality)
	
