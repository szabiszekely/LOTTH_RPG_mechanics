extends Node
class_name DialogicController

@onready var RefrenceNode:CrossRoad = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")
@onready var dialog_main


func _begining_setup():
	dialog_main = Dialogic.start("player_text_set_up_timeline")
	dialog_main.register_character(RefrenceNode.PlayerGroup.player[0].Fight_stats.character_speaker,RefrenceNode.PlayerGroup.player[0])
	dialog_main.register_character(RefrenceNode.PlayerGroup.player[1].Fight_stats.character_speaker,RefrenceNode.PlayerGroup.player[1])
	dialog_main.register_character(RefrenceNode.PlayerGroup.player[2].Fight_stats.character_speaker,RefrenceNode.PlayerGroup.player[2])
	dialog_main.register_character(RefrenceNode.PlayerGroup.player[3].Fight_stats.character_speaker,RefrenceNode.PlayerGroup.player[3])


#and !RefrenceNode.Initiative.action_start
func _start_dialog(name_of_timeline: String):
	print("dialog")
	dialog_main = Dialogic.start(name_of_timeline)

func _vanish_dialog():
		_tween_dialog(0,0.1,true)

func _appear_dialog():
		_tween_dialog(-233,0.1,false)


#dialog vanish
func _tween_dialog(to_where,how_fast,hide_or_show):
	if dialog_main != null:
		var tween = get_tree().create_tween()
		tween.tween_property(dialog_main.get_child(0).get_child(0).get_child(0),"position:y",to_where,how_fast)
		if hide_or_show:
			await tween.finished
			Dialogic.Text.show_textbox()
		else:
			Dialogic.Text.hide_textbox()
			
