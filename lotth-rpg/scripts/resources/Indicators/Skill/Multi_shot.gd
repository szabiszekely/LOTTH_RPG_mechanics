extends Skill
class_name MultiShot

var modified_dir : Vector2
var angle_of_rotation: float

@export var count : int = 3

func activate(scene_tree):
	radial_shot(scene_tree)

# shoots projectile until [Given number] not reached and every projectile will be spawning in a angle away from the rest
func radial_shot(scene_tree):
	angle_of_rotation = -20
	for i in range(count):
		modified_dir = indicator.direction.rotated(deg_to_rad(angle_of_rotation))
		shoot(scene_tree)
		angle_of_rotation += (45.0/(count-1))

# this sets up the everything from damage to type to dir and velocity
func shoot(scene_tree):
	if projectile_node == null:
		return
	
	var projectile = projectile_node.instantiate()
	projectile.base_damage = skill_base_damage
	projectile.Attack_Type = skill_attack_type
	projectile.position = indicator.spawn_point
	projectile.dir = modified_dir
	projectile.player = player_reference
	scene_tree.current_scene.add_child(projectile)
