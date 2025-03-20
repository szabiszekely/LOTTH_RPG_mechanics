extends Skill
class_name Swarm

var modified_dir : Vector2
var angle_of_rotation: float

@export var count : int = 200

func activate(scene_tree):
	radial_shot(scene_tree)

# summons fire ball projectile until [Given number] not reached!
# they follow the cursor until their timer not reached or they not hit an enemy
func radial_shot(scene_tree):
	angle_of_rotation = 0
	for i in range(count):
		modified_dir = indicator.direction.rotated(deg_to_rad(angle_of_rotation))
		shoot(scene_tree)
		angle_of_rotation += (45.0/(count-1))

# this sets up the everything from damage to type to dir and velocity
func shoot(scene_tree):
	if projectile_node == null:
		return
	
	var projectile = projectile_node.instantiate()
	projectile.base_damage = 1
	projectile.Attack_Type = 2
	projectile.position = indicator.spawn_point
	projectile.dir = modified_dir
	projectile.follow_mouse = true
	projectile.player = player_reference
	scene_tree.current_scene.add_child(projectile)
