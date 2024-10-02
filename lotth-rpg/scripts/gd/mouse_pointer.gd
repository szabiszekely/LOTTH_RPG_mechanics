extends CharacterBody2D
@onready var pointer_cam_target: Node2D = $PCamTarget
@onready var pro_cam: Node2D = %ProCam

@export var active: bool
@export var do_i_need_it: bool
var camera_toggle = false

func _ready() -> void:
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _process(_delta: float) -> void:
	
	if !active:
		self.hide()
	else:
		self.show()
		move_and_collide(get_global_mouse_position() - global_position)

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Cam_change") and do_i_need_it == true:
		camera_toggle = !camera_toggle
		active = !active
		if camera_toggle == true :
			pointer_cam_target.enabled = true
			pro_cam.left_margin = 0.35
			pro_cam.right_margin = 0.35
			pro_cam.top_margin = 0.15
			pro_cam.bottom_margin = 0.15
			pro_cam.smooth_drag_speed = Vector2(3,3)
			
		elif camera_toggle == false:
			pointer_cam_target.enabled = false
			pro_cam.left_margin = 0.08
			pro_cam.right_margin = 0.08
			pro_cam.top_margin = 0.04
			pro_cam.bottom_margin = 0.04
			pro_cam.smooth_drag_speed = Vector2(10,10)
	if event.is_action_released("Mouse_Scroll_Up") and do_i_need_it == true:
		pro_cam.zoom = clamp(pro_cam.zoom,0.9,2) +  0.1
		
	if event.is_action_released("Mouse_scroll_down") and do_i_need_it == true:
		pro_cam.zoom =  clamp(pro_cam.zoom,0.9,2) - 0.1