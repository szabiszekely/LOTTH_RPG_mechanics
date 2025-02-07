extends CharacterBody2D
class_name Character_Controller

@onready var focus = $Indicator
@onready var damage_indicator = preload("res://scenes/attack_indicator.tscn")
@onready var hitbox: CollisionShape2D = $Hitbox

@export var speed:int = 400
@export var Fight_stats: Fighting_Stats
@export var Turn_portriat: CompressedTexture2D
@export var Bar: Indicator_bar
@export var cam_target: Node2D
@export var Initiative: Initiative_class #= preload("res://scripts/resources/misaliniouse/Initiative_resource.tres")

var PlayOutOptions: int = 2:
	set(value):
		PlayOutOptions = value
		if value <= 0:
			_on_to_the_next_guy()

@export var MaxPlayOutOptions: int = 2

var your_turn = false:
	set(value):
		your_turn = value
		if your_turn:
			_your_turn_on_set_up()
		elif !your_turn:
			_your_turn_off_set_up()

#plays either health hit animation or energy drain animation!
func _play_animator_health_hit():
	$animator.play("hit")

func _play_animator_energy_hit():
	$animator.play("eng_hit")

# used to grab focus indicator on characters!
func _focus_indicator():
	focus.show()
	_camera_on()
	
func _camera_on():
	cam_target.enabled = true

func _unfocus_indicator():
	focus.hide()
	_camera_off()
	
func _camera_off():
	cam_target.enabled = false
#take damage function is here to make everything work what is conected to health or energy!

func _take_damage(base_damage_phisical,strengh,attacker_type,card_type,base_damage_magical):
	var hit = Fight_stats._Damage_Taken(base_damage_phisical,strengh,Fight_stats.Defense,Fight_stats.Attack_Type,attacker_type,card_type,base_damage_magical,Fight_stats.Magic_Defense)
	#var hit = strengh
	print(str(Fight_stats.name)+": "+str(hit))
	#if Fight_stats.HP == 0:
		#death 
	Bar.bar_damage_taken(hit)
	var got_damage = damage_indicator.instantiate()
	self.add_child(got_damage)
	got_damage.taken_damage(hit)
	_camera_on()
	await Engine.get_main_loop().create_timer(Initiative.timeSpentBetweenTurns/2).timeout
	_camera_off()

func _use_card_and_lose_eng(Name:String):
	var hit = Data.get_card_energy(Name)
	#print(hit)
	Bar.bar_damage_taken(hit)

func _use_card_and_gain_eng(Name:String,Heart_or_Eng: int):
	#var hit =  Data.get_card_energy(Name)
	#print(hit)
	#Bar.bar_damage_taken(hit)
	Bar.bar_health_restored(Data.get_card_eng_healed(Name),Heart_or_Eng)

func _take_true_damage(base_damage):
	var hit = Fight_stats._True_Damage_Taken(base_damage)
	print(str(Fight_stats.name)+": "+str(hit))
	Bar.bar_damage_taken(hit)
	var got_damage = damage_indicator.instantiate()
	self.add_child(got_damage)
	got_damage.true_taken_damage(hit)
	_camera_on()
	await Engine.get_main_loop().create_timer(Initiative.timeSpentBetweenTurns/2).timeout
	_camera_off()

	
func _damage_healed(amount,which_to_heal):
	Bar.bar_health_restored(amount,which_to_heal)
	
func roll_of_the_luck():
	var roll = Fight_stats.Speed + Fight_stats._Initiative()
	#print(Fight_stats.name," ",roll)
	# this is where the rolls and other stats that needs them to be determend are stored
	# first is that are they enemy or not, than they roll!, than they speed, and finally they portrait and name!
	var initiative_peronality = [Fight_stats.Friend_or_Foe,roll,Fight_stats.Speed,Turn_portriat,self]
	Initiative.all_rolls.append(initiative_peronality)

func _your_turn_on_set_up():
	pass

func _your_turn_off_set_up():
	pass

func _on_to_the_next_guy():
	Initiative._next_in_order()
