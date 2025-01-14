extends CharacterBody2D

var dir: Vector2 = Vector2.RIGHT
var speed: float = 300
var follow_mouse: bool = false
var radnom_speed: float = randi_range(250,600)
var random_acc = randf_range(1.1,4)
@export_enum("Melee","Range","Magic") var Attack_Type: int
@export var base_damage: int = 1
var player: Player

func _physics_process(delta: float) -> void:
	if follow_mouse == true:
		
		var target_pos = (get_global_mouse_position()- position).normalized()
		velocity = lerp(velocity, target_pos * radnom_speed, delta * random_acc)
		rotation = get_global_mouse_position().angle()
		move_and_slide()
	else:
		velocity =  lerp(velocity, dir * speed, delta * 2.5)
		rotation = dir.angle()
		move_and_slide()
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("_take_damage"):
		body._take_damage(base_damage,player.Fight_stats.Base_Phisical_Attack,Attack_Type)
		queue_free()
