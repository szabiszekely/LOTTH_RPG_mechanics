extends PanelContainer

@export var Initiative: Initiative_class

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Initiative._getting_all_rolls(Initiative.all_rolls,$VBoxContainer)
	
	
	self.position.x = 2000
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(1049,106), 0.8).set_trans(Tween.TRANS_EXPO)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
