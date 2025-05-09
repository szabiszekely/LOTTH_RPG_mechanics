extends Indicator
class_name PointingIndicator
 
 # every frame it turns to rotate to angle to the mouse position
func update(source, mouse_position, delta,_mouse_in):
	spawn_point = source.global_position
	direction = (mouse_position - spawn_point).normalized()
 
	if indicator_reference != null:
		point(mouse_position, delta)
 
 
func point(target, _delta):
	indicator_reference.look_at(target)
 
 
func set_reference(source):
	if indicator_reference != null:
		return
 
	var sprite_reference = Sprite2D.new()
	sprite_reference.texture = texture
	indicator_reference = sprite_reference
	#sprite_reference.z_index = -1
	source.add_child(sprite_reference)
 
	activated = true
 
func reset():
	if indicator_reference != null:
		indicator_reference.free()
 
	activated = false
