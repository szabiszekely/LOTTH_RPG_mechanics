extends Resource
class_name Action_buttons_option_Handler
#all of these are global vars inside of this script and take over the functions variables!
var enemy_stats
var enemy_seperate
var active_dialogue_box
var source
var act_opt = preload("res://text_folder/action_options.tres")

#When I press an Action Button it will get transfered here and be translate to one of the one that got pressed!
func _get_button_text_action(Button_text: String, Stats, Dialogue,Source):
	active_dialogue_box = Dialogue
	enemy_seperate = Stats
	source = Source
	enemy_stats = Stats.Fight_stats
	#I call the name of the button as a function!
	call(Button_text)

# Setting up variables that are inside the Dialogue Node Asset!
func switching_stats_check():
	active_dialogue_box.variables["name"] = enemy_stats.name
	active_dialogue_box.variables["Base_Phisical_Attack"] = enemy_stats.Base_Phisical_Attack
	active_dialogue_box.variables["Base_Magical_Attack"] = enemy_stats.Base_Magical_Attack
	active_dialogue_box.variables["Defense"] = enemy_stats.Defense
	active_dialogue_box.variables["Magic_Defense"] = enemy_stats.Magic_Defense
	active_dialogue_box.variables["EMP"] = enemy_stats.EMP
	active_dialogue_box.variables["MAX_EMP"] = enemy_stats.MAX_EMP

#ALL BELLOW ARE FUNCTIONS THAT ARE USED FOR ACTION OPTIONS!
func Check():
	switching_stats_check()
	active_dialogue_box.start("Check")
	print("----------------")
	print("Stat Block")
	print("Name: " + str(enemy_stats.name))
	print("HP: " + str(enemy_stats.HP) + " ENG: " + str(enemy_stats.ENG))
	print("ATK: " + str(enemy_stats.Base_Phisical_Attack), " M.ATK: " + str(enemy_stats.Base_Magical_Attack))
	print("DEF: " + str(enemy_stats.Defense) + " M.DEF: " + str(enemy_stats.Magic_Defense))
	print("EMP: "+ str(enemy_stats.EMP) + " Speed: " + str(enemy_stats.Speed))
	print("----------------")
	enemy_seperate.Enemy_health_bar.show()

func Focus():
	print("----------------")
	print("You Closed Your eyes and started to focus on " + str(enemy_stats.name) +"!")
	print("----------------")
	
func Guard():
	print("----------------")
	print("DEFENDED")
	print("----------------")
	
func Talk():
	active_dialogue_box.start("Talk")
	print("Hello o/")
	enemy_seperate.emp_gained(1)

func Grab():
	active_dialogue_box.start("Grab")
	await source.get_tree().create_timer(0.8).timeout
	var audio = AudioStreamPlayer2D.new()
	var SQUEAK = preload("res://assets/audio/squeak.mp3")
	audio.set_stream(SQUEAK) 
	audio.set_volume_db(5)
	source.add_child(audio)
	audio.play()
	await source.get_tree().create_timer(1).timeout
	audio.queue_free()
	print("*squek sfx*")
	enemy_seperate.emp_gained(1)
	
func Ball():
	active_dialogue_box.start("Ball")
	print("He Do be balling")
	enemy_seperate.emp_gained(2)
	
func Sleep():
	active_dialogue_box.start("Sleep")
	print("Hank shu")
	enemy_seperate.emp_gained(2)
	
func Twirl():
	active_dialogue_box.start("Twirl")
	print("You span around")
	enemy_seperate.emp_gained(-1)
