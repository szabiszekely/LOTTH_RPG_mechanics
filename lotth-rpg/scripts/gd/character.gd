extends CharacterBody2D
class_name Character_Controller

# this is the main node for all enemies and players
@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var focus = $Indicator
@onready var damage_indicator = preload("res://scenes/attack_indicator.tscn")
@onready var hitbox: CollisionShape2D = $Hitbox
@onready var Initiative = RefrenceNode.InitiativeHandler
@onready var menu = RefrenceNode.Menu


@export var speed:int = 400
@export var Fight_stats: Fighting_Stats
@export var Turn_portriat: CompressedTexture2D
@export var Bar: Indicator_bar
@export var cam_target: Node2D

# this will reduce if you choose an action
# and when it is 0 or less than the next on the order will come
var PlayOutOptions: int = 2:
	set(value):
		PlayOutOptions = value
		if value <= 0:
			_on_to_the_next_guy()
		
# this is the maximum of option chocie a character can have
@export var MaxPlayOutOptions: int = 2

# this sets up the character to their turn
var your_turn = false:
	set(value):
		your_turn = value
		if your_turn == true:
			_your_turn_on_set_up()
		else:
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

# focuses the camera on the character
func _camera_on():
	cam_target.enabled = true

func _unfocus_indicator():
	focus.hide()
	_camera_off()
	
func _camera_off():
	cam_target.enabled = false
#take damage function is here to make everything work what is conected to health or energy!

# this is where all the damage gets split apart for all the other functions to be handled
func _take_damage(base_damage_phisical,strengh,attacker_type,card_type,base_damage_magical):
	var hit = Fight_stats._Damage_Taken(base_damage_phisical,strengh,Fight_stats.Defense,Fight_stats.Attack_Type,attacker_type,card_type,base_damage_magical,Fight_stats.Magic_Defense)
	print(str(Fight_stats.name)+": "+str(hit))
	# this is where the death will play out
	#if Fight_stats.HP == 0:
		#death 
	Bar.bar_damage_taken(hit)
	var got_damage = damage_indicator.instantiate()
	self.add_child(got_damage)
	got_damage.taken_damage(hit)
	_camera_on()
	await Engine.get_main_loop().create_timer(Initiative.timeSpentBetweenTurns/2).timeout
	_camera_off()

# this is where you take card damage
func _use_card_and_lose_eng(Name:String):
	var hit = Data.get_card_energy(Name)
	Bar.bar_damage_taken(hit)
# or where you get back some eng or health
func _use_card_and_gain_eng(Name:String,Heart_or_Eng: int):
	#var hit =  Data.get_card_energy(Name)
	#Bar.bar_damage_taken(hit)
	Bar.bar_health_restored(Data.get_card_eng_healed(Name),Heart_or_Eng)

# when you take True Damage
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
	
func roll_of_the_luck():
	var roll = Fight_stats.Speed + Fight_stats._Initiative()
	# this is where the rolls and other stats that needs them to be determend are stored
	# first is that are they enemy or not, than they roll!, than they speed, and finally they portrait and name!
	var initiative_peronality = [Fight_stats.Friend_or_Foe,roll,Fight_stats.Speed,Turn_portriat,self]
	Initiative.all_rolls.append(initiative_peronality)
	print(Initiative.all_rolls)

func _play_out_tick_down():
	PlayOutOptions -= 1
	_play_out_actions_down()

func _play_out_tick_up():
	PlayOutOptions += 1
	_play_out_actions_up()


# place holder function for other scripts to be handled
func _your_turn_on_set_up():
	pass

func _your_turn_off_set_up():
	pass

func _on_to_the_next_guy():
	pass

func _play_out_actions_down():
	pass

func _play_out_actions_up():
	pass
