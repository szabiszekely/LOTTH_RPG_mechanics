extends CharacterBody2D
class_name Character_Controller

@onready var focus = $Indicator
@onready var damage_indicator = preload("res://scenes/attack_indicator.tscn")

@export var speed:int = 400
@export var Fight_stats: Fighting_Stats
@export var Bar: Indicator_bar



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
	var hit = Fight_stats._Damage_Taken(base_damage,strengh,Fight_stats.Defense,Fight_stats.Attack_Type,attacker_type)
	#var hit = strengh
	print(str(Fight_stats.name)+": "+str(hit))
	#if Fight_stats.HP == 0:
		#death 
	Bar.bar_damage_taken(hit)
	var got_damage = damage_indicator.instantiate()
	self.add_child(got_damage)
	got_damage.taken_damage(hit)

func _use_card(Name):
	var hit = Data.get_card_energy(Name)
	#print(hit)
	Bar.bar_damage_taken(hit)

func _take_true_damage(base_damage,attacker_type):
	var hit = Fight_stats._True_Damage_Taken(base_damage,Fight_stats.Attack_Type,attacker_type)
	print(str(Fight_stats.name)+": "+str(hit))
	Bar.bar_damage_taken(hit)
	var got_damage = damage_indicator.instantiate()
	self.add_child(got_damage)
	got_damage.true_taken_damage(hit)
	
func _damage_healed(amount,which_to_heal):
	Bar.bar_health_restored(amount,which_to_heal)
	
	
