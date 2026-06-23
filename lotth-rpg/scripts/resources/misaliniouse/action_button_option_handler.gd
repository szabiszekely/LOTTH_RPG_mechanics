extends Resource
class_name Action_buttons_option_Handler
#all of these are global vars inside of this script and take over the functions variables!
var enemy_stats
var enemy_seperate
var active_dialogue_box
var source
var timeline
var player_seperate
#When I press an Action Button it will get transfered here and be translate to one of the one that got pressed!
func _get_button_text_action(Button_text: String, enemy, Source, menu,player):
	enemy_seperate = enemy
	player_seperate = player
	source = Source
	enemy_stats = enemy.Fight_stats
	menu.vanish()
	switching_stats_check()
	#I call the name of the button as a function!
	print(Button_text)
	call(Button_text)

# Setting up variables that are inside the Dialogue Node Asset!
func switching_stats_check():
	Dialogic.VAR.name = enemy_stats.name
	Dialogic.VAR.Base_Phisical_Attack = enemy_stats.Base_Phisical_Attack
	Dialogic.VAR.Base_Magical_Attack = enemy_stats.Base_Magical_Attack
	Dialogic.VAR.Defense = enemy_stats.Defense
	Dialogic.VAR.Magic_Defense = enemy_stats.Magic_Defense
	Dialogic.VAR.EMP = enemy_stats.EMP
	Dialogic.VAR.MAX_EMP = enemy_stats.MAX_EMP

func start_dialog():
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start(timeline)
	source.initiative.doTrapForLoop = true
	

func _on_timeline_ended():
	print('WORKS')
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	source.initiative.stopLoop.emit()
	# do something else here

#ALL BELLOW ARE FUNCTIONS THAT ARE USED FOR ACTION OPTIONS!
func Check():
	timeline = "act_Check"
	start_dialog()
	print("----------------")
	print("Stat Block")
	print("Name: " + str(enemy_stats.name))
	print("HP: " + str(enemy_stats.HP) + " ENG: " + str(enemy_stats.ENG))
	print("ATK: " + str(enemy_stats.Base_Phisical_Attack), " M.ATK: " + str(enemy_stats.Base_Magical_Attack))
	print("DEF: " + str(enemy_stats.Defense) + " M.DEF: " + str(enemy_stats.Magic_Defense))
	print("EMP: "+ str(enemy_stats.EMP) + " Speed: " + str(enemy_stats.Speed))
	print("----------------")
	enemy_seperate.Bar.show()
	#enemy_seperate.Bar.name_tag_container.hide()
	enemy_seperate.Bar.action_remaining.hide()
	
	

func Focus():
	print("----------------")
	print("You Closed Your eyes and started to focus on " + str(enemy_stats.name) +"!")
	print("----------------")
	
func Guard():
	#print("----------------")
	#print("DEFENDED")
	#print("----------------")
	player_seperate.Fight_stats.STAT_Resource._Get_Current_Headers(player_seperate.Fight_stats.Header_Array)
	player_seperate.Fight_stats._Database_append(player_seperate.Fight_stats.STAT_Resource._Stat_change("Turn",1,{1:["Def",1,true]}))
	print(player_seperate.Fight_stats.Stat_Boosts)
	player_seperate.Fight_stats._Apply_Stats()
	
func Talk():
	timeline = "act_Talk"
	start_dialog()
	print("Hello o/")
	enemy_seperate.emp_gained(1)
	

func Grab():
	timeline = "act_Grab"
	start_dialog()
	enemy_seperate.emp_gained(1)
	
	
func Ball():
	timeline = "act_Ball"
	start_dialog()
	print("He Do be balling")
	enemy_seperate.emp_gained(2)
	
	
func Sleep():
	timeline = "act_Sleep"
	start_dialog()
	print("Hank shu")
	enemy_seperate.emp_gained(2)
	
	
func Twirl():
	timeline = "act_Twirl"
	start_dialog()
	print("You span around")
	enemy_seperate.emp_gained(-1)
	
