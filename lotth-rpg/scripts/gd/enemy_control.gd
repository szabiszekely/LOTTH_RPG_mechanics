extends Character_Controller
class_name Enemy
#This is the enemy Controller!

@onready var Enemy_health_bar = $Bar_system


func _ready() -> void:
	 #hiding the health bar, playing the idle animation, rolling with the speed dice, and a lot more!
	roll_of_the_luck()
	Enemy_health_bar.hide()
	$character_animator.play("idle")
	Initiative.MaxTurns += MaxPlayOutOptions
	
	
func _process(delta: float) -> void:
	#FOR Now when it's their turn, they choose a random attack, but if a player cancle's then their action get rerolled
	if your_turn:
		if Initiative.cancle_enemy_back_up == true and Initiative.action_queued.size() != 0:
			Initiative.action_queued.remove_at(Initiative.action_queued.size() - 1)
			Initiative._previouse_in_order()
		elif Initiative.cancle_enemy_back_up == true and Initiative.action_queued.size() == 0:
			Initiative.cancle_enemy_back_up = false
		else:
			PlayOutOptions -= 1
			var choose_ability = ["Baller Attack","Ball Crawl"].pick_random()
			var choose_random_player = randi_range(0,Initiative.group_player.player.size() - 1)
			Initiative.action_queued.push_back(["atk",choose_ability,choose_random_player,3,Initiative.group_enemies.index])

func _your_turn_on_set_up():
		PlayOutOptions = MaxPlayOutOptions

	
func emp_gained(gained_EMP: int):
	if not Fight_stats.MAX_EMP <= Fight_stats.EMP:
		Fight_stats.EMP += gained_EMP
	else:
		print("EMP gain has reached the maximum or something went wrong in the code!")
	print(str(Fight_stats.EMP) + " / " + str(Fight_stats.MAX_EMP))
