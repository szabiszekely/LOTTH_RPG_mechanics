extends Control
@onready var Left_siluette: Panel = $ColorRect
@onready var Right_siluette: Panel = $ColorRect2
@onready var Soul: AnimatedSprite2D = $AnimatedSprite2D
@onready var lotth_tittle_screen: TextureRect = $LotthTittleScreen
@onready var Beta: RichTextLabel = $RichTextLabel
@onready var Press_start: RichTextLabel = $RichTextLabel2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_Press_start_animation(1.25)
	lotth_tittle_screen.material.set_shader_parameter("work", true);



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_Press_start_animation(0.1)
		await get_tree().create_timer(0.5).timeout
		Press_start.queue_free()
		var tween = get_tree().create_tween().set_parallel(true)
		tween.tween_property(Left_siluette,"position",Vector2(-300,0),3)
		tween.tween_property(Right_siluette,"position",Vector2(1640,0),3)
		tween.tween_method(set_strength_value, 0.009, 0.15, 1.5); # args are: (method to call / start value / end value / duration of animation)
		tween.tween_method(set_noise_scale_value, 5.0, 40.0, 1.5); # args are: (method to call / start value / end value / duration of animation)
		tween.tween_method(set_work_value, true,false, 6); # args are: (method to call / start value / end value / duration of animation)
		tween.tween_method(set_color_alpha_value, 1.0, 0.0, 3); # args are: (method to call / start value / end value / duration of animation)
		tween.tween_property(Beta,"modulate",Color.TRANSPARENT,2)		
		await tween.finished
		

func _Press_start_animation(time:float):
	var tween = get_tree().create_tween().set_loops(-1)
	tween.tween_property(Press_start,"modulate",Color.TRANSPARENT,time)
	tween.tween_property(Press_start,"modulate",Color.WHITE,time)




func set_strength_value(value: float):
	lotth_tittle_screen.material.set_shader_parameter("sway_strength", value);
func set_noise_scale_value(value: float):
	lotth_tittle_screen.material.set_shader_parameter("noise_scale", value);
func set_work_value(value: bool):
	lotth_tittle_screen.material.set_shader_parameter("work", value);
func set_color_alpha_value(value: float):
	lotth_tittle_screen.material.set_shader_parameter("color_alpha", value);
