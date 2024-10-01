extends NavigationRegion2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var on_thread: bool = true
	bake_navigation_polygon(on_thread)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var on_thread: bool = true
		bake_navigation_polygon(on_thread)
