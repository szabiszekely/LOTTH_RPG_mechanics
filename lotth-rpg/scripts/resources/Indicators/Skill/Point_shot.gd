extends Skill
class_name PointShot

func activate(scene_tree):
	shoot(scene_tree)

func shoot(scene_tree):
	if projectile_node == null:
		return
	
	var projectile = projectile_node.instantiate()
	projectile.base_damage = skill_base_damage
	projectile.Attack_Type = skill_attack_type
	projectile.position = indicator.spawn_point
	projectile.dir = Vector2.RIGHT
	projectile.speed = 0
	projectile.player = player_reference
	scene_tree.current_scene.add_child(projectile)
