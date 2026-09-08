extends RichTextLabel

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position:x",position.x+210,1).set_trans(Tween.TRANS_ELASTIC)	
	tween.tween_property(self,"modulate",Color.TRANSPARENT,1)
	await tween.finished
	self.queue_free()
