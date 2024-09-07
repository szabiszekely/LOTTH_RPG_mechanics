extends NavigationRegion2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var on_thread: bool = true
	bake_navigation_polygon(on_thread)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var on_thread: bool = true
		bake_navigation_polygon(on_thread)
