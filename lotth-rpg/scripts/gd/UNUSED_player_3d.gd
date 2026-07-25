extends CharacterBody3D
class_name Player_3D


@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@export var camera: Camera
var Inside: bool = false
@onready var sprite_3d: Sprite3D = $"../Sprite3D"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("clicked"):
		navigation_agent_3d.set_target_position(sprite_3d.position)

		#camera.shoot_ray()

func _physics_process(delta: float) -> void:
	
	var destination = navigation_agent_3d.get_next_path_position()
	var local_des = destination - global_position
	var direction = local_des.normalized()
	velocity = direction * 5.0
	move_and_slide()


func _on_area_3d_mouse_entered() -> void:
	Inside = true
	
func _on_area_3d_mouse_exited() -> void:
	Inside = false
