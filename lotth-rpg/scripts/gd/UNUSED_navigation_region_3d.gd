extends NavigationRegion3D

func _ready() -> void:

	var on_thread: bool = true
	bake_navigation_mesh(on_thread)
