extends Resource
class_name Indicator
# I export the textur of the indicator this can be an arrow or an area 
#or maybe a angled area tha I can use to indicate the attacks
@export var texture : Texture2D
var indicator_reference = null
# true when us use it false when not 
var activated : bool = false
 # get the middle of yourself
var spawn_point : Vector2
var direction : Vector2
 
# put this into the _process to use it this is every frame
func update(_source, _mouse_position, _delta,_mouse_in):
	pass
# 
func set_reference(_source):
	pass
# when this runs everything should get earesed!
func reset():
	pass
