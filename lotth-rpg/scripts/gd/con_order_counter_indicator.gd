extends PanelContainer
class_name Order_holder

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var Initiative = RefrenceNode.InitiativeHandler
# this is the UI that is important to add the icons and the turn order to the UIí
func _ready() -> void:
	Initiative._getting_all_rolls(Initiative.all_rolls,$VBoxContainer)
	self.position.x = 578.0
	self.position.y = -20
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(578,100.0), 0.8).set_trans(Tween.TRANS_EXPO)
