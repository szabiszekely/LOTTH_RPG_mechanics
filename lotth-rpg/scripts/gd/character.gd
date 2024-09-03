extends CharacterBody2D

@onready var focus = $Indicator
@export var Fight_stats: Fighting_Stats

#var health: int = Fight_stats.HP:
	#set(value):
		#_play_animator_health_hit()
#
#var energy: int =  Fight_stats.ENG:
	#set(value):
		#_play_animator_energy_hit()

func _ready() -> void:
	print("----------------")
	print("Stat Blog")
	print(Fight_stats.name)
	print("HP:",Fight_stats.HP," ","ENG:",Fight_stats.ENG)
	print("PHIS_ATK:",Fight_stats.Base_Phisical_Attack, " ","MAG_ATK:", Fight_stats.Base_Magical_Attack)
	print("ATK_Type:",Fight_stats.Attack_Type)
	print("EMP:", Fight_stats.EMP)
	print("----------------")
	$character_animator.play("idle")

func _play_animator_health_hit():
	$animator.play("hit")

func _play_animator_energy_hit():
	$animator.play("eng_hit")

func _focus_indicator():
	focus.show()

func _unfocus_indicator():
	focus.hide()
