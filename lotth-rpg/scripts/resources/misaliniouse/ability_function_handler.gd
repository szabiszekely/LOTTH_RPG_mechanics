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
	player.player[player.index].skill = preload("res://scripts/resources/Indicators/Skill/FireSwarm.tres")
	player.player[player.index].skill.skill_base_damage = Data.get_card_damage(name_of_abi)
	player.player[player.index].skill.skill_attack_type = Data.get_card_attack_type(name_of_abi)
	player.player[player.index].skill.player_reference = player.player[player.index]
	#player.player[player.index].skill.indicator.range = Data.get_card_range(name_of_abi)
	player.player[player.index].skill.indicator.set_reference(player.player[player.index])

func Thunder_Song():
	player.player[player.index].skill = preload("res://scripts/resources/Indicators/Skill/AreaBoom.tres")
	player.player[player.index].skill.skill_base_damage = Data.get_card_damage(name_of_abi)
	player.player[player.index].skill.skill_attack_type = Data.get_card_attack_type(name_of_abi)
	player.player[player.index].skill.player_reference = player.player[player.index]
	player.player[player.index].skill.indicator.range = Data.get_card_range(name_of_abi)
	player.player[player.index].skill.indicator.set_reference(player.player[player.index])
func Healling_care():
	pass
