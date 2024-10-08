extends Resource
class_name Action_buttons_option_Handler
var enemy_stats
var enemy_seperate
var active_dialogue_box
var source
var act_opt = preload("res://text_folder/action_options.tres")

func _get_button_text_action(Button_text: String, Stats, Dialogue,Source):
	active_dialogue_box = Dialogue
	enemy_seperate = Stats
	source = Source
	enemy_stats = Stats.Fight_stats
	call(Button_text)
	
func Check():
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
	
func Ball():
	print("He Do be balling")
	
func Sleep():
	print("Hank shu")
	
func Twirl():
	print("You span around")
