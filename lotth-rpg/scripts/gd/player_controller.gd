extends Character_Controller
class_name Player

@onready var collision_radius = $Area2D/CollisionShape2D
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var player_cam_target: Node2D = $PCamTarget

@export var indicator : Indicator
@export var moving_indicator : MovingIndicator
@export var skill : Skill:
	set(value):
		if skill is Skill:
			skill.indicator.reset()
 
		skill = value

var distance = Vector2()
var is_inside_the_range: bool = false
var is_inside_the_range_and_skill_is_being_used: bool = false



func _ready() -> void:
	moving_indicator.Fight_stats = Fight_stats
	#when game start start idle get roll
	$character_animator.play("idle")
	roll_of_the_luck()
	

func _physics_process(delta: float) -> void:
	#player_switch_on()
	if your_turn:
		if Initiative.cancle_enemy_back_up == true:
			Initiative.cancle_enemy_back_up = false
		Initiative.group_player.index = Initiative.index_order[Initiative.initiative_index][2]
		# update the indicator
		update(delta)
		# get the distance for the navigation and a bunch of nav stuff I don't entirely understand! and just move there!
		distance = Vector2(nav_agent.get_next_path_position() - position)
		if nav_agent.is_navigation_finished():
			return
		velocity.x = distance.normalized().x * speed
		velocity.y = distance.normalized().y * speed
		move_and_slide()
		
		#await get_tree().create_timer(3).timeout
		#goal = self.position
		# when I click then the navigation gets the position ect, ect I don't get it too much
		
func _input(event) -> void:
	var menu = Initiative.group_player.menu
	
	if event.is_action_pressed("clicked") and indicator.activated and your_turn and skill == null:
		var map = get_world_2d().navigation_map
		var p = NavigationServer2D.map_get_closest_point(map,moving_indicator.cursor_reference.global_position)
		nav_agent.target_position = p
		#your_turn = false
		#indicator.reset()
	if skill != null:
		if event.is_action_pressed("ui_cancel"):
			skill.indicator.reset()
			skill = null
		if event.is_action_pressed("ui_accept"):
			skill.indicator.set_reference(self)
		if event.is_action_pressed("clicked") and skill.indicator.activated:
			skill.activate(get_tree())
			Initiative.group_player.player[Initiative.group_player.index]._use_card_and_lose_eng(Initiative.group_player.card_againts_players)
			menu.ability_card_choice.ability_func._get_what_ability_got_used(Initiative.group_player.card_againts_players,menu,menu.enemy_group,menu.player_group)
	
			#skill.indicator.reset()
			#skill = null
			
func _your_turn_on_set_up():
	var menu = Initiative.group_player.menu
	_camera_on()
	menu.menu_index = 0
	menu.switching_buttons()
	menu.current_state = menu.Menu_state.MENU
	player_switch_on()
	#print(Fight_stats.name," Turn is up and this shit does work lol")

func _your_turn_off_set_up():
	_camera_off()
	player_switch_off()
	print(Fight_stats.name," Picked their choice and this shit does work lol")
		
# indicator set up
func update(delta):
	if skill != null:
		indicator.reset()
		collision_radius.disabled = true
		skill.indicator.update(self, get_global_mouse_position(), delta,is_inside_the_range_and_skill_is_being_used)
	elif skill == null:
		collision_radius.shape.radius  = Fight_stats.range_in_cm * 10
		indicator.set_reference(self)
		collision_radius.disabled = false
		indicator.update(self,get_global_mouse_position(),delta,is_inside_the_range)
		
# when the mous is inside the area or not
func _on_area_2d_mouse_entered() -> void:
	if skill != null:
		#print("Inside and have skill")
		is_inside_the_range_and_skill_is_being_used = true
	elif skill == null:
		#print("Inside and does not have skill")
		is_inside_the_range = true

func _on_area_2d_mouse_exited() -> void:
	if skill != null:
		#print("Outside and have skill")
		is_inside_the_range_and_skill_is_being_used = false
	elif skill == null:
		#print("Outside and does not have skill")
		is_inside_the_range = false

func player_switch_on():
	indicator.set_reference(self)
	collision_radius.shape.radius  = Fight_stats.range_in_cm * 10

func player_switch_off():
	indicator.reset()
