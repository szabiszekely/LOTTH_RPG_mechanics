extends Resource
class_name Initiative_class

var all_rolls: Array = []
@export var bg_container = Texture2D

func _getting_all_rolls(rolls:Array,source):
	rolls.sort_custom(priority)
	
	for portait in rolls:
		var portrait_texture = portait[3]
		var container = TextureRect.new()
		var portrait_icon = TextureRect.new()
		container.texture = bg_container
		container.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
		if portait[0] == 1:
			container.self_modulate = "f54e4e"
		
		portrait_icon.texture = portrait_texture
		portrait_icon.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
		portrait_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		portrait_icon.position = Vector2(6,8)
		portrait_icon.size = Vector2(40,40)
		
		source.add_child(container)
		container.add_child(portrait_icon)
		

func priority(a,b):
	if a[1] == b[1]:
		if a[0] == b[0]:
			if a[2] > b[2]:
				return true
			return false
		elif a[0] != b[0]:
			if a[0] == 0:
				return true
			elif b[0] == 0:
				return false
	if a[1] > b[1]:
		return true
	return false
