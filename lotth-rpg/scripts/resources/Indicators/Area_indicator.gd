extends Indicator
class_name AreaIndicator
 
@export var cursor_texture : Texture2D
var cursor_reference = null
var area_reference = null
var collision_reference = null
var mouse_reference = false
 # update it everyframe!
func update(source, mouse_position, delta,mouse_in):
	# if refrenced cursor DOES exist than:
	if cursor_reference != null:
		# if the mouse is inside the ellipse than
		if mouse_in:
			#get the directio which is just simply my mouse minus the source position which is the player .normalized()
			var dir = (mouse_position - source.position).normalized()
			# get the length which I clamp between the same dir but this time I get the lenght which is just a flat number and than
			# set it between 0 and 150
			var length = clamp((mouse_position - source.position).length(),0,range * 10)
			# and finally the cursor position must be inside the ellipse which is determend by this formula... DO NOT ASK
			cursor_reference.global_position  = source.position + Vector2(dir.x,dir.y) * length 
		else:
			# if the cursor is outside the ellipse we want it to cap it at the edge of the ellipse so we just change the clamp value
			var dir = (mouse_position - source.position).normalized()
			#															HERE to not go anywhere else!
			var length = clamp((mouse_position - source.position).length(),(range * 10)-2,range * 10)
			# finally we just cap the y value to half bc ellipse is just circle with half of much hight!
			cursor_reference.position  = Vector2(dir.x,dir.y/2)* length
		
		
		
 # this is just only used for the little cursor thingy that always looking at the middle!
func point(object, target, _delta):
	object.look_at(target)
 
# this is where we spawn in the area and the cursor!
func set_reference(source):
	# if the indicators are DOES EXISTS!  
	if indicator_reference != null:
		return
	#we scale it by range cm * 10 and than we just devid it by 30
	var scaleit = range * 10 / 30
	# getting new sprite down and setting texture to it
	var sprite_reference = Sprite2D.new()
	sprite_reference.texture = texture
	# we scale the area's y scale to half
	sprite_reference.scale.y = 0.51
	# and than we just scale it with scaleit creative I know and just let it rip
	sprite_reference.scale = sprite_reference.scale * scaleit
	# puting it behind by -1 bc of layers and stuff issues
	sprite_reference.z_index = -1
	indicator_reference = sprite_reference
	source.add_child(sprite_reference)
 
	var cursor = Sprite2D.new()
	cursor.texture = cursor_texture
	cursor_reference = cursor
	
	source.add_child(cursor)
 	# finally we just activate it which is just so I call it out
	
	
	
	var new_area2d = Area2D.new()
	area_reference = new_area2d
	source.add_child(new_area2d)
	
	var new_collision2d = CollisionShape2D.new()
	new_collision2d.scale = Vector2(3,3)
	collision_reference = new_collision2d
	
	var new_circle2d = CircleShape2D.new()
	new_circle2d.radius = 30.0
	new_collision2d.shape = new_circle2d
	new_collision2d.scale.x = 1
	new_collision2d.scale.y = 0.51      
	new_collision2d.position.y = 6
	new_collision2d.scale = new_collision2d.scale * scaleit
	new_area2d.add_child(new_collision2d)
	
	new_area2d.mouse_entered.connect(source._on_area_2d_mouse_entered)
	new_area2d.mouse_exited.connect(source._on_area_2d_mouse_exited)
	
	activated = true
 
# simple reset function just so if the stuff are Does exists than if we don't need them then just get rid of them later!
func reset():
	if indicator_reference != null:
		indicator_reference.free()
	if cursor_reference != null:
		cursor_reference.free()
	if area_reference != null:
		area_reference.free()
	if collision_reference != null:
		collision_reference.free()
 
	activated = false
