extends NavigationRegion2D

# when game started get the polygon of the map navigation area down... AKA WHEN GAME STARTS GET ALL WALKABLE AREA!
func _ready() -> void:
	
	var on_thread: bool = true
	bake_navigation_polygon(on_thread)

# same here just for testing purpuse!
func _input(_event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept"):
		#var on_thread: bool = true
		#bake_navigation_polygon(on_thread)
	pass
