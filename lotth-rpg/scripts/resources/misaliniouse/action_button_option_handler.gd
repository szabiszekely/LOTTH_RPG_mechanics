extends Resource
class_name Action_buttons_option_Handler
var enemy_stats
var enemy_seperate



func _get_button_text_action(Button_text: String, Stats):
	
	enemy_seperate = Stats
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
	DialogueManager.get_current_scene
	DialogueManager.show_dialogue_balloon(preload("res://text_folder/choosen_action_option.dialogue"),"Talk")
	print("Hello o/")

func Grab():
	#DialogueManager.get_current_scene
	DialogueManager.show_dialogue_balloon(preload("res://text_folder/choosen_action_option.dialogue"),"Grab")
	print("*squek sfx*")
	
func Ball():
	DialogueManager.get_current_scene
	DialogueManager.show_dialogue_balloon(preload("res://text_folder/choosen_action_option.dialogue"),"Ball")
	print("He Do be balling")
	
func Sleep():
	print("Hank shu")
	
func Twirl():
	print("You span around")
