extends Character_Controller
class_name Player

# Oh we should probably work on this code cause it is messy 
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var player_cam_target: Node2D = $PCamTarget
@onready var Bar_VContainer: VBoxContainer = $"../../../UI_battle_menu/Bar_container"
const BAR_SYSTEM = preload("res://reworking_mechanics/reworked_Bar_system.tscn")
@onready var player = RefrenceNode.PlayerGroup


#@export var indicator : Indicator
#@export var moving_indicator : MovingIndicator
#@export var skill : Skill:
	#set(value):
		#if skill is Skill:
			#skill.indicator.reset()
 #
		#skill = value

#var distance = Vector2()
#var is_inside_the_range: bool = false
#var is_inside_the_range_and_skill_is_being_used: bool = false
var can_moved = false
var can_dash = true
var dashing = false
var dashDir = Vector2(0,0)
var moved = false


func _ready() -> void:
	$AnimationTree.active = true
	var instance = BAR_SYSTEM.instantiate()
	instance.assined_characters = self
	Bar_VContainer.add_child(instance)
	Bar = instance

	#moving_indicator.Fight_stats = Fight_stats
	$character_animator.play("idle")
	#when game start start idle get roll
	roll_of_the_luck()

#func _physics_process(delta: float) -> void:
	#if Initiative.doTrapForLoop: 
		#update(delta)
	# on its turn if you the last player wanted to go back then it will stop here
	#if your_turn:
		#if Initiative.cancle_enemy_back_up == true:
			#Initiative.cancle_enemy_back_up = false
		#Initiative.group_player.index = Initiative.index_order[Initiative.initiative_index][2]
		# update the indicator
		#if !moved: 
			#update(delta)
	# get the distance for the navigation and a bunch of nav stuff I don't entirely understand! and just move there!
	#distance = Vector2(nav_agent.get_next_path_position() - position)
	#if nav_agent.is_navigation_finished():
		#return
	#velocity.x = distance.normalized().x * speed
	#velocity.y = distance.normalized().y * speed
	#move_and_slide()
#func _input(event) -> void:
	#pass
	# gets the position and then it will move the player to that position when all the action stuff should play out
	#if event.is_action_pressed("clicked") and indicator.activated and your_turn and skill == null:
		#Initiative.action_queued.push_back(["movement",get_world_2d().navigation_map,moving_indicator.cursor_reference.global_position,0,Initiative.index_order[Initiative.initiative_index][2]])
		#PlayOutOptions -= 1
		#indicator.reset()
		#moved = true
	#if skill != null:
		#skill.indicator.set_reference(self)
		#if event.is_action_pressed("clicked") and skill.indicator.activated:
			# WE NEED TO ADD THE CORRECT VALUES LATER DO NOT FORGET!!!
			#skill.skill_attack_type
			#skill.skill_base_damage
			#skill.activate(get_tree())
			#menu.ability_card_choice.ability_func._get_what_ability_got_used(Initiative.group_player.card_againts_players,menu,menu.enemy_group,menu.player_group,Initiative.group_player.index,0)
			#Initiative.stopLoop.emit()
			#Initiative.doTrapForLoop = false
			#skill.indicator.reset()
			#skill = null


func _physics_process(delta: float) -> void:
	if can_moved:
		#print(move_and_slide()," ",get_motion_mode())
		var input= Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		if input.x < 0:
			character_anim.flip_h = true
		elif input.x > 0:
			character_anim.flip_h = false
		if Input.is_action_just_pressed("dash") and can_dash and not dashing:
			dashDir = input
			can_dash = false
			dashing = true
			velocity = dashDir * 450 *delta
			await get_tree().create_timer(0.11).timeout
			velocity = Vector2.ZERO
			can_dash = true
			dashing = false
		elif dashing == false:
			velocity = input * 111 * delta
			
		#print(velocity," ",input)
	
		move_and_collide(velocity)
func _your_turn_on_set_up():
	
	PlayOutOptions = MaxPlayOutOptions
	_camera_on()
	menu.menu_index = 0
	menu.switching_buttons()
	menu.show()
	menu.current_state = menu.Menu_state.MENU
	$character_animator.self_modulate = Color.YELLOW
	#player_switch_on()

func _your_turn_off_set_up():
	_camera_off()
	#player_switch_off()
	menu.vanish()
	$character_animator.self_modulate = Color.WHITE
		
func _on_to_the_next_guy():
	if not len(Initiative.sorted_player) <= player.p_index + 1:
		Initiative.switch_order_p(player.p_index+1,player.p_index)
		player.p_index += 1
	else:
		your_turn = false

func _play_out_actions_down():
	Bar.all_icon_of_remaining_actions[PlayOutOptions]._action_indicator_off()


func _play_out_actions_up():
	Bar.all_icon_of_remaining_actions[PlayOutOptions-1]._action_indicator_on()

func _pass_character():
	for i in MaxPlayOutOptions:
		player.all_p_actions.push_back(["pass_character","nonesense",self,self,"Self"])
	_on_to_the_next_guy()

# indicator set up
#func update(delta):
	#if skill != null:
		#indicator.reset()
		#skill.indicator.update(self, get_global_mouse_position(), delta,is_inside_the_range_and_skill_is_being_used)
	#elif skill == null and !Initiative.doTrapForLoop:
		#indicator.set_reference(self)
		#indicator.update(self,get_global_mouse_position(),delta,is_inside_the_range)
# when the mous is inside the area or not
#func _on_area_2d_mouse_entered() -> void:
	#if skill != null:
		#is_inside_the_range_and_skill_is_being_used = true
	#elif skill == null:
		#is_inside_the_range = true
#
#func _on_area_2d_mouse_exited() -> void:
	#if skill != null:
		#is_inside_the_range_and_skill_is_being_used = false
	#elif skill == null:
		#is_inside_the_range = false
#func player_switch_on():
	#indicator.set_reference(self)
#
#func player_switch_off():
	#indicator.reset()
	
#Bar.HP_bar.material.get_shader_parameter("value") > 0
