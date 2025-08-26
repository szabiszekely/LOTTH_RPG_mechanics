extends Resource
class_name  Item_handler

var menu_system
var player_handler
var enemy_handeler
var item_data

# this will direct any ongoing item usage to their respective actions

func _get_item_and_redirect_it(item_name,menu,player,enemy):
	menu_system = menu
	player_handler = player
	enemy_handeler = enemy
	item_data = item_name
	#print(item_data)
	player_handler.item_againts_players = item_data["Name"]
	enemy_handeler.item_againts_enemies = item_data["Name"]
	call(item_data["Name"])

func enemy_starter():
	menu_system.choose_enemy_container = true
	menu_system.current_state = menu_system.Menu_state.CHOOSING_ENEMIES

func player_starter():
	menu_system.choose_player_container = true
	menu_system.current_state = menu_system.Menu_state.CHOOSING_PLAYERS

func Meat():
	player_starter()
	#print("meat arrived")

func Knife():
	#print("knife arrived")
	enemy_starter()
	
	
func Heart_Breaker():
	enemy_starter()
	#print("Heart Breaker arrived")
	
func Apple():
	enemy_starter()
	#player_starter()
	#print("apple arrived")

func Medicit():
	player_starter()
	
	
