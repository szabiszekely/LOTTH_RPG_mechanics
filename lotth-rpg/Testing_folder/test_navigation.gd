extends CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
var distance
var speed = 50
@onready var marker_2d: Marker2D = $"../../Marker2D"
@onready var area_2d: Area2D = $"../Area2D"

func _physics_process(_delta: float) -> void:
	print(area_2d.get_overlapping_bodies().size())
	
	if area_2d.overlaps_body(self):
		distance = Vector2(navigation_agent_2d.get_next_path_position() - position)
		if navigation_agent_2d.is_navigation_finished():
			return
		velocity.x = distance.normalized().x * speed
		velocity.y = distance.normalized().y * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO

func _input(_event) -> void:
	if Input.is_action_just_pressed("clicked"):
		area_2d.global_position = self.global_position
		var map = get_world_2d().navigation_map
		var p = NavigationServer2D.map_get_closest_point(map,marker_2d.global_position)
		navigation_agent_2d.target_position = p
