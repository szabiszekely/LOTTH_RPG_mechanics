extends Resource
class_name  Item_handler

var player_handler
var enemy_handeler
var item_data

func _get_item_and_redirect_it(item_name,player,enemy):
	player_handler = player
	enemy_handeler = enemy
	item_data = item_name
	print(item_data)
	
	call(item_data["Name"])


func Meat():
	player_handler.player[0]._damage_healed(item_data["Eng"],1)
	
	print("meat arrived")

func Knife():
	# Enemy index needs to be given adaptive index handaling, and CLEAN THIS DISGUSTING LOOKING ASS LINE! OMG THIS IS SO LONG
	enemy_handeler.enemies[0]._take_damage(item_data["Dmg"],player_handler.player[0].Fight_stats.Base_Phisical_Attack,enemy_handeler.enemies[0].Fight_stats.Attack_Type)
	print("knife arrived")
	
func Heart_Breaker():
	enemy_handeler.enemies[0]._take_true_damage(item_data["Dmg"],enemy_handeler.enemies[0].Fight_stats.Attack_Type)
	print("Heart Breaker arrived")
	
func Apple():
	player_handler.player[0]._damage_healed(item_data["Eng"],1)
	print("apple arrived")
	
	
	
