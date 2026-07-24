extends Resource
class_name Ability_Handler

# In this script I handle all the aquired data and apply additional effects to it
# such as could be:
# additional side effects, animations, range capped attacks, special interactions
# this code resurved as a place where you can inject cases like this into the attack directly
# in any case this code should be handled thus correctly and with care in the future!

# place holder variables to make data global in this script
var name_of_abi
var enemyGroup
var playerGroup
var menu_system
var attacker_index
var defender_index

# when this get usually called it means we get the card, our player and enemy group, menu, who attacked who,
# and store it so we can apply bonus effects to the card or call functions as their own special little cases!
func _get_what_ability_got_used(Name_of_Ability_Card,Menu,enemy_group,player_group,index_from,index_to):
	name_of_abi = Name_of_Ability_Card
	enemyGroup = enemy_group
	playerGroup = player_group
	menu_system = Menu
	attacker_index = index_from
	defender_index = index_to
	# this replaces all the abilities " " (spaces) with "_" (underscores) so we can uses them as function 
	# and call them!
	var correct_string = Name_of_Ability_Card.replace(" ","_")
	call(correct_string)


func _player_set_up_for_attack():
	# this function is a basic what kind of actions,functions and variables needed to be set!
	attacker_index.skill.skill_base_damage = Data.get_card_damage(name_of_abi)
	attacker_index.skill.skill_attack_type = Data.get_card_attack_type(name_of_abi)
	attacker_index.skill.player_reference = attacker_index
	attacker_index.skill.indicator.range = Data.get_card_range(name_of_abi)
	attacker_index.skill.indicator.set_reference(attacker_index)

# really basic callable function for testing purposes
func Pass():
	pass

func Agressive_Stomp():
	pass
	
func Mile_Punch():
	pass

func Byecicle():
	attacker_index.skill = preload("res://scripts/resources/Indicators/Skill/FireSwarm.tres")
	_player_set_up_for_attack()
	menu_system.Initiative.timeSpentBetweenTurns = 7
	
func Curved_Slash():
	pass

# most of these functions are gonna be custome but for near future me, I will explain this one!
# when you activate it as a range capped funtion you will load the correct skill in this case FireBall.tres
# and then you set up the player for it, and in the end you will give a rough estimate on how much time
# it will need between turns!
func Dual_Wielding():
	attacker_index.skill = preload("res://scripts/resources/Indicators/Skill/FireBall.tres")
	_player_set_up_for_attack()
	menu_system.Initiative.timeSpentBetweenTurns = 7

func Funny_Magic():
	pass

func Thunder_Song():
	attacker_index.skill = preload("res://scripts/resources/Indicators/Skill/AreaBoom.tres")
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
	defender_index.Fight_stats.PlayerDeck.Deck.append("Throw Away Joke")

func Throw_Away_Joke():
	var find_index = attacker_index.Fight_stats.PlayerDeck.Deck.find("Throw Away Joke")
	attacker_index.Fight_stats.PlayerDeck.Deck.remove_at(find_index)
	print(attacker_index.Fight_stats.PlayerDeck.Deck)

func Spin_Roll():
	pass

func Spike_Dive():
	pass

func Bite():
	pass

func Spike_Fortress():
	pass

func Scream():
	pass

func Growl():
	pass
