extends PanelContainer
class_name Order_holder

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")
@onready var Initiative = RefrenceNode.InitiativeHandler
@onready var slide_points: Node2D = $Slide_Points
@onready var spr_turn_pointer: Sprite2D = $SprTurnPointer
var slider_index:int = 1
# this is the UI that is important to add the icons and the turn order to the UIí
func _ready() -> void:
	Initiative._getting_all_rolls(Initiative.all_rolls,$VBoxContainer)
	self.position.x = 578.0
	self.position.y = -20
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(578,100.0), 0.8).set_trans(Tween.TRANS_EXPO)
	spr_turn_pointer.position = Vector2(7,54)
	_hide_pointer()
	
func _slide_down_the_order(max_member:int):
	var tween_reset = false
	if slider_index > max_member-1:
		slider_index = 0
		tween_reset = true
	
	## Add quee and await until the pointer is at the right place
	
	var next_point = slide_points.get_children()[slider_index]
	var tween = get_tree().create_tween()
	if !tween_reset:
		tween.tween_property(spr_turn_pointer,"position:y",next_point.position.y,0.2).set_trans(Tween.TRANS_ELASTIC)
	else:
		tween.tween_property(spr_turn_pointer,"position:y",next_point.position.y,1.2).set_trans(Tween.TRANS_LINEAR)
		await tween.finished
		await get_tree().create_timer(0.3).timeout
		_hide_pointer()
	slider_index += 1

func _hide_pointer():
	spr_turn_pointer.hide()

func _show_pointer():
	spr_turn_pointer.show()


## Pointer Hider
#func _pointer_reset():
	#spr_turn_pointer.position = Vector2(7,54)
