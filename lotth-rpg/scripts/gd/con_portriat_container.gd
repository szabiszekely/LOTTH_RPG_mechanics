extends TextureRect

 # same as last time with indicator but this is for he portrait it self!... idk
func _ready() -> void:
	await get_tree().create_timer(0.2).timeout
	self.position.x = 100
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(0,self.position.y), 1).set_trans(Tween.TRANS_EXPO)
