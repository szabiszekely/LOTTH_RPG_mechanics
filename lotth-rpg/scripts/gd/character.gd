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
		
# when the scene starts it will set up some health velues to play animation...
# I might need to take them out later bc I don't really see the point but we will see!
func _ready() -> void:
	health = Fight_stats.HP
	energy = Fight_stats.ENG

#plays either health hit animation or energy drain animation!
func _play_animator_health_hit():
	$animator.play("hit")

func _play_animator_energy_hit():
	$animator.play("eng_hit")

# used to grab focus indicator on characters!
func _focus_indicator():
	focus.show()

func _unfocus_indicator():
	focus.hide()

#take damage function is here to make everything work what is conected to health or energy!
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
				
	
