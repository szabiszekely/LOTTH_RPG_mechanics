extends Button
class_name Menu_buttons



func hover(me):
	var tweens = get_tree().create_tween()
	tweens.tween_property(me,"position",Vector2(me.position.x,-10),0.1)
	
func unhover(me):
	var tweens = get_tree().create_tween()
	tweens.tween_property(me,"position",Vector2(me.position.x,0),0.1)
	
func when_button_pressed(me):
	var tweens = get_tree().create_tween()
	tweens.tween_property(me,"position",Vector2(me.position.x,-10),0.1)
	#await get_tree().create_timer(1).timeout
	
	tweens.tween_property(me,"position",Vector2(me.position.x,20),0.1).set_trans(Tween.TRANS_EXPO)
	tweens.tween_property(me,"position",Vector2(me.position.x,0),0.4).set_trans(Tween.TRANS_BOUNCE)
	
	
	

func disable_button(button):
	pass
