extends Character_Controller
class_name Enemy

@export var Turn_portriat: CompressedTexture2D
@export var Initiative: Initiative_class

func _ready() -> void:
	$character_animator.play("idle")
	var roll = Fight_stats.Speed + Fight_stats._Initiative()
	print(roll)
	var initiative_peronality = [Fight_stats.Friend_or_Foe,roll,Fight_stats.Speed,Turn_portriat,Fight_stats.name]
	Initiative.all_rolls.append(initiative_peronality)
