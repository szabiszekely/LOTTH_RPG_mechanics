extends Node
class_name DialogicController

@onready var RefrenceNode:CrossRoad = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")
@onready var dialog_main


func _begining_setup():
	dialog_main = Dialogic.start("player_text_set_up_timeline")
	for i in RefrenceNode.Players:
		dialog_main.register_character(i.Fight_stats.character_speaker,i)


#and !RefrenceNode.Initiative.action_start
func _start_dialog(name_of_timeline: String):
	#print("dialog")
	dialog_main = Dialogic.start(name_of_timeline)

func _vanish_dialog():
		_tween_dialog(0,0.2,true,380,-350)

func _appear_dialog():
		_tween_dialog(-180.0,0.2,false,407,-420)


#dialog vanish
func _tween_dialog(to_where,how_fast,_hide_or_show,to_where_right,to_where_left):
	if dialog_main != null:
		#print(dialog_main.get_child(0).get_child(0).get_child(0)," ", to_where," ", how_fast," ", hide_or_show)
		var tween = get_tree().create_tween().set_parallel(true)
		if _hide_or_show:
			tween.tween_property(dialog_main.get_child(0).get_child(0).get_child(0),"position:y",to_where,how_fast)
			tween.tween_property(dialog_main.get_child(0).get_child(0).get_child(0),"offset_right",to_where_right,how_fast)
			tween.tween_property(dialog_main.get_child(0).get_child(0).get_child(0),"offset_left",to_where_left,how_fast)
		else:
			tween.tween_property(dialog_main.get_child(0).get_child(0).get_child(0),"offset_right",to_where_right,how_fast)
			tween.tween_property(dialog_main.get_child(0).get_child(0).get_child(0),"offset_left",to_where_left,how_fast)
			tween.tween_property(dialog_main.get_child(0).get_child(0).get_child(0),"position:y",to_where,how_fast).set_delay(0.2)
			
		#if hide_or_show:
			#Dialogic.Text.show_textbox()
		#else:
			#await tween.finished
			#Dialogic.Text.hide_textbox()
			#
