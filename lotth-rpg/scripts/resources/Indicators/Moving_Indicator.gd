extends Indicator
class_name MovingIndicator
 
@export var cursor_texture : Texture2D
@export var Fight_stats: Fighting_Stats
var cursor_reference = null

 
func update(source, mouse_position, delta,mouse_in):
	if cursor_reference != null:
		spawn_point = cursor_reference.global_position
		point(cursor_reference, source.global_position, delta)
 
	if cursor_reference != null:
		
		if mouse_in:
			var dir = (mouse_position - source.position).normalized()
			var length = clamp((mouse_position - source.position).length(),0,150)
			cursor_reference.global_position  = source.position + Vector2(dir.x,dir.y) * length 
		else:
			var dir = (mouse_position - source.position).normalized()
			var length = clamp((mouse_position - source.position).length(),140,150)
			cursor_reference.position  = Vector2(dir.x,dir.y/2)* length
		
		
		
 
func point(object, target, _delta):
	object.look_at(target)
 
 
func set_reference(source):
	if indicator_reference != null:
		return
	
	var scaleit = Fight_stats.range_in_cm * 10 / 30
	var sprite_reference = Sprite2D.new()
	sprite_reference.texture = texture
	sprite_reference.scale.y = 0.51
	sprite_reference.scale = sprite_reference.scale * scaleit
	sprite_reference.z_index = -1
	indicator_reference = sprite_reference
	source.add_child(sprite_reference)
 
	var cursor = Sprite2D.new()
	cursor.texture = cursor_texture
	cursor_reference = cursor
	source.add_child(cursor)
 
	activated = true
 
func reset():
	if indicator_reference != null:
		indicator_reference.free()
	if cursor_reference != null:
		cursor_reference.free()
 
	activated = false
