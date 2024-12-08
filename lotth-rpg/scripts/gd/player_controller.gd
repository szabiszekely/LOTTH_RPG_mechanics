extends Character_Controller
class_name Player

@onready var collision_radius = $Area2D/CollisionShape2D
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var player_cam_target: Node2D = $PCamTarget

@export var indicator : Indicator
@export var moving_indicator : MovingIndicator
@export var Turn_portriat: CompressedTexture2D
@export var Initiative: Initiative_class

#var load_lil_guy_control = preload("res://scripts/resources/CH/Lil_Guy_Fighting_Stats.tres")
var distance = Vector2()
var is_inside_the_range: bool = false


func _ready() -> void:
	
	#when game start start idle get roll
	$character_animator.play("idle")
	var roll = Fight_stats.Speed + Fight_stats._Initiative()
	print(Fight_stats.name," ",roll)
	var initiative_peronality = [Fight_stats.Friend_or_Foe,roll,Fight_stats.Speed,Turn_portriat,Fight_stats.name]
	Initiative.all_rolls.append(initiative_peronality)
	
	# also set the collision shape up and the area
	collision_radius.shape.radius  = Fight_stats.range_in_cm * 10
	indicator.set_reference(self)

func _physics_process(delta: float) -> void:
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
	if event.is_action_pressed("clicked") and indicator.activated:
		var map = get_world_2d().navigation_map
		var p = NavigationServer2D.map_get_closest_point(map,moving_indicator.cursor_reference.global_position)
		nav_agent.target_position = p
		
	
# indicator set up
func update(delta):
	indicator.update(self,get_global_mouse_position(),delta,is_inside_the_range)
# when the mous is inside the area or not
func _on_area_2d_mouse_entered() -> void:
	is_inside_the_range = true
func _on_area_2d_mouse_exited() -> void:
	is_inside_the_range = false
