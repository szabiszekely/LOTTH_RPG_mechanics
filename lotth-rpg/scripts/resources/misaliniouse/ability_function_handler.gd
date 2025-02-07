extends Resource
class_name Ability_Handler

var name_of_abi
var enemyGroup
var playerGroup
var menu_system

var attacker_index: int = 0
var defender_index: int = 0
func _get_what_ability_got_used(Name_of_Ability_Card,Menu,enemy_group,player_group,index_from,index_to):
	#print(enemy_group.enemies," ",player_group)
	#print(player_group.player[player_group.index].Fight_stats.PlayerDeck.Deck)
	name_of_abi = Name_of_Ability_Card
	enemyGroup = enemy_group
	playerGroup = player_group
	menu_system = Menu
	attacker_index = index_from
	defender_index = index_to
	var correct_string = Name_of_Ability_Card.replace(" ","_")
	call(correct_string)
	pass

func _player_set_up_for_attack():
	playerGroup.player[attacker_index].skill.skill_base_damage = Data.get_card_damage(name_of_abi)
	playerGroup.player[attacker_index].skill.skill_attack_type = Data.get_card_attack_type(name_of_abi)
	playerGroup.player[attacker_index].skill.player_reference = playerGroup.player[attacker_index]
	playerGroup.player[attacker_index].skill.indicator.range = Data.get_card_range(name_of_abi)
	playerGroup.player[attacker_index].skill.indicator.set_reference(playerGroup.player[attacker_index])

func Pass():
	pass

func Agressive_Stomp():
	pass
	
func Mile_Punch():
	#print("YOU HIT THE ENEMY A MILE AWAY")
	pass

func Byecicle():
	playerGroup.player[attacker_index].skill = preload("res://scripts/resources/Indicators/Skill/FireSwarm.tres")
	_player_set_up_for_attack()
	menu_system.Initiative.timeSpentBetweenTurns = 7
	
func Curved_Slash():
	pass

func Dual_Wielding():
	playerGroup.player[attacker_index].skill = preload("res://scripts/resources/Indicators/Skill/FireBall.tres")
	_player_set_up_for_attack()
	menu_system.Initiative.timeSpentBetweenTurns = 7

func Funny_Magic():
	pass

func Thunder_Song():
	playerGroup.player[attacker_index].skill = preload("res://scripts/resources/Indicators/Skill/AreaBoom.tres")
	_player_set_up_for_attack()
func Healling_care():
	pass

func Arcane_Feather():
	pass

func Broken_Shooter():
	pass

func Curse_Of_Mya():
	pass

func Distracting_Beauty():
	playerGroup.player[defender_index].Fight_stats.PlayerDeck.Deck.append("Throw Away Joke")

func Throw_Away_Joke():
	var find_index = playerGroup.player[attacker_index].Fight_stats.PlayerDeck.Deck.find("Throw Away Joke")
	playerGroup.player[attacker_index].Fight_stats.PlayerDeck.Deck.remove_at(find_index)
	print(playerGroup.player[attacker_index].Fight_stats.PlayerDeck.Deck)

func Baller_Attack():
	pass
	
func Ball_Crawl():
	pass
