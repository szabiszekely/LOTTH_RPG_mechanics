extends Resource
class_name  Item_handler

var menu_system
var player_handler
var enemy_handeler
var item_data
var item_uuid

# this will direct any ongoing item usage to their respective actions

func _get_item_and_redirect_it(item_name,menu,player,enemy,item_id):
	menu_system = menu
	player_handler = player
	enemy_handeler = enemy
	item_data = item_name
	item_uuid = item_id
	print(item_id," ",item_uuid)
	#print(item_data)
	call(item_data["Name"])

func enemy_starter():
	menu_system.choose_enemy_container = true
	menu_system.current_state = menu_system.Menu_state.CHOOSING_ENEMIES
	enemy_handeler.item_againts_enemies = item_data["Name"]
	enemy_handeler.item_uuid_againts_enemies = item_uuid
func player_starter():
	menu_system.choose_player_container = true
	menu_system.current_state = menu_system.Menu_state.CHOOSING_PLAYERS
	player_handler.item_againts_players = item_data["Name"]
	player_handler.item_uuid_againts_players = item_uuid


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
	
func Spike():
	enemy_starter()
	
func Brown_Fur():
	enemy_starter()
	
