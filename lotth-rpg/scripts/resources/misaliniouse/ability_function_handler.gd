extends Resource
class_name Ability_Handler

var name_of_abi
var enemy
var player
var menu_system

func _get_what_ability_got_used(Name_of_Ability_Card,Menu,enemy_group,player_group):
	print(enemy_group.enemies," ",player_group)
	name_of_abi = Name_of_Ability_Card
	enemy = enemy_group
	player = player_group
	menu_system = Menu
	var correct_string = Name_of_Ability_Card.replace(" ","_")
	call(correct_string)
	pass

func Agressive_Stomp():
	pass
	
func Mile_Punch():
	print("YOU HIT THE ENEMY A MILE AWAY")
	

func Byecicle():
	pass
	
func Curved_Slash():
	pass

func Dual_Wielding():
	pass

func Funny_Magic():
	print("Wohohoo I'm a funny wizard")

func Thunder_Song():
	pass
	
func Healling_care():
	pass
