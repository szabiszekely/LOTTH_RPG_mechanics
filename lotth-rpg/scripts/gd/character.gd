extends CharacterBody2D
class_name Character_Controller

@onready var focus = $Indicator


@export var speed:int = 400
@export var Fight_stats: Fighting_Stats
@export var Bar: Indicator_bar


var health: int :
	set(value_hp):
		#print("hey I was startled! I'm HP")
		health = value_hp
var energy: int:
	set(value_eng):
		#print("hey I was startled! I'm ENG")
		energy = value_eng
		

func _ready() -> void:
	health = Fight_stats.HP
	energy = Fight_stats.ENG
	
func _play_animator_health_hit():
	$animator.play("hit")

func _play_animator_energy_hit():
	$animator.play("eng_hit")

func _focus_indicator():
	focus.show()

func _unfocus_indicator():
	focus.hide()

func _take_damage(base_damage,strengh,attacker_type):
	health = Fight_stats.HP
	energy = Fight_stats.ENG
	
	var hit = Fight_stats._Damage_Taken(base_damage,strengh,Fight_stats.Defense,Fight_stats.Attack_Type,attacker_type)
	
	#if Fight_stats.HP == 0:
		#get_child(index).queue_free()
		
	Bar.bar_damage_taken(float(hit))
	
	if Fight_stats.ENG > 0:
		_play_animator_energy_hit() 
		for i in hit:
			Fight_stats.ENG -= 1
			await get_tree().create_timer(0.16).timeout
			if Fight_stats.ENG <= 0:
				Fight_stats.ENG = 0
			
	else:
		_play_animator_health_hit()
		for i in hit:
			Fight_stats.HP -= 1
			await get_tree().create_timer(0.16).timeout
			if Fight_stats.HP <= 0:
				Fight_stats.HP = 0
				
	
