extends Camera3D
class_name Camera

var mouse_position
@export var player: Player_3D
@onready var sprite_3d: Sprite3D = $"../Sprite3D"

func _process(delta: float) -> void:
	shoot_ray()

func shoot_ray():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 1000
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycast_result = space.intersect_ray(ray_query)
	if raycast_result.size() != 0: 
		#print(mouse_position)
		mouse_position = Vector3(raycast_result["position"][0],raycast_result["position"][1],raycast_result["position"][2]) 
	
		#sprite_3d.position.x = mouse_position.x
		#sprite_3d.position.z = mouse_position.z
		var length = ( Vector3(mouse_position.x,0, mouse_position.z) - Vector3(player.position.x,0, player.position.z)).length()
		length = min(length, 1.5)
		#print(length)
		#length = clamp(length,100,150)
		sprite_3d.global_position = Vector3(player.position.x,0.55, player.position.z) + length *(Vector3(mouse_position.x,0, mouse_position.z) -  Vector3( player.position.x ,0,player.position.z)).normalized()
