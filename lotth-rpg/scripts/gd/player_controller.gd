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

var player_active = true

func _ready() -> void:
	
	moving_indicator.Fight_stats = Fight_stats
	#when game start start idle get roll
	$character_animator.play("idle")
	roll_of_the_luck()
	

func _physics_process(delta: float) -> void:
	#player_switch_on()
	if player_active:
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
		#print("done") 
		#goal = self.position
		# when I click then the navigation gets the position ect, ect I don't get it too much
		
func _input(event) -> void:
	if event.is_action_pressed("clicked") and indicator.activated and player_active and skill == null:
		var map = get_world_2d().navigation_map
		var p = NavigationServer2D.map_get_closest_point(map,moving_indicator.cursor_reference.global_position)
		nav_agent.target_position = p
		#player_active = false
		#indicator.reset()
	if skill != null:
		if event.is_action_pressed("ui_cancel"):
			skill.indicator.reset()
			skill = null
		if event.is_action_pressed("ui_accept"):
			skill.indicator.set_reference(self)
		if event.is_action_pressed("clicked") and skill.indicator.activated:
			skill.activate(get_tree())
			#skill.indicator.reset()
			#skill = null
	#
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
		print("Inside and have skill")
		is_inside_the_range_and_skill_is_being_used = true
	elif skill == null:
		print("Inside and does not have skill")
		is_inside_the_range = true

func _on_area_2d_mouse_exited() -> void:
	if skill != null:
		print("Outside and have skill")
		is_inside_the_range_and_skill_is_being_used = false
	elif skill == null:
		print("Outside and does not have skill")
		is_inside_the_range = false

func player_switch_on():
	indicator.set_reference(self)
	collision_radius.shape.radius  = Fight_stats.range_in_cm * 10
	player_active = true
	_camera_on()

func player_switch_off():
	indicator.reset()
	player_active = false
	_camera_off()
