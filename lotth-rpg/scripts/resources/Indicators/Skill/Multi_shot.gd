extends Skill
class_name MultiShot

var modified_dir : Vector2
var angle_of_rotation: float

@export var count : int = 3

func activate(scene_tree):
	radial_shot(scene_tree)

func radial_shot(scene_tree):
	angle_of_rotation = -20
	for i in range(count):
		modified_dir = indicator.direction.rotated(deg_to_rad(angle_of_rotation))
		shoot(scene_tree)
		angle_of_rotation += (45.0/(count-1))


func shoot(scene_tree):
	if projectile_node == null:
		return
	
	var projectile = projectile_node.instantiate()
	projectile.base_damage = 2
	projectile.Attack_Type = 0
	projectile.position = indicator.spawn_point
	projectile.dir = modified_dir
	projectile.player = player_reference
	scene_tree.current_scene.add_child(projectile)
