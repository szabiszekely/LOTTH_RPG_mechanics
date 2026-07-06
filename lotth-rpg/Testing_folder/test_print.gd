extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	Dialogic.start("stat_baller")
	Dialogic.timeline_ended.connect(_on_timeline_ended)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_button"):
		Dialogic.end_timeline()
		await Engine.get_main_loop().create_timer(0.1).timeout
		var timeline = "act_focus"
		var layout = Dialogic.start(timeline)
		Dialogic.timeline_ended.connect(_on_timeline_ended)
		print(layout)
		layout.register_character(preload("uid://bv1ssilnspy62"),sprite_2d)

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	# do something else here
	#print(Data.get_item_stats_types(Data.get_item_stats("Meat")))
	#print(Data.get_item_stats_types(Data.get_item_stats("Spike")))
	#print(Data.get_item_stats_types(Data.get_item_stats("Medicit")))

#var dict = {
	#"key":0,
	#"key2":1
#}

#var simple_var: String = "Hello"
#var var_int: int = 15
#var boolean: bool = false
#@onready var im_print_able: Node2D = $"Im print able"

#func _ready() -> void:
	#var array = dict.values()
	#for i in array:
		#if i != 0:
			#break
			#
	#print_tree()
	#print_tree_pretty()
	#printerr("1 ",simple_var)
	#printraw("2 ",simple_var,var_int,boolean)
	#prints("3 ",simple_var,var_int,boolean)
	#printt("4 ",simple_var,var_int,boolean)
	#print_debug("5 ",simple_var,var_int,boolean)
	#print_rich("6 ",simple_var,var_int,boolean)
	#print_stack()
	#OS.is_stdout_verbose()
	#print_verbose("7 ",simple_var,var_int,boolean)
	#OS.alert("HI","Is this a popup???")


#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept"):
		##OS.crash("Crashed")
		#print(OS.get_name())
