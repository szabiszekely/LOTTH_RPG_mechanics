extends Skill
class_name SingleShot

func activate(scene_tree):
	shoot(scene_tree)

func shoot(scene_tree):
	if projectile_node == null:
		return
	
	var projectile = projectile_node.instantiate()
	projectile.base_damage = 5
	projectile.Attack_Type = 1
	projectile.position = indicator.spawn_point
	projectile.dir = indicator.direction
	projectile.player = player_reference
	scene_tree.current_scene.add_child(projectile)
	
