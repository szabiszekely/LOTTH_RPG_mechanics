extends Character_Controller
class_name Enemy
#This is the enemy Controller!

@onready var Enemy_health_bar = $Bar_system
@onready var enemy = RefrenceNode.EnemyGroup
@export var EnemyAI: SetupEnemyAI
@onready var enemy_group = RefrenceNode.EnemyGroup


func _ready() -> void:
	 #hiding the health bar, playing the idle animation, rolling with the speed dice, and a lot more!
	roll_of_the_luck()
	Enemy_health_bar.hide()
	$character_animator.play("idle")
	EnemyAI._setup(enemy,RefrenceNode.PlayerGroup,Initiative,RefrenceNode.MainNode,RefrenceNode.ActButtonHandler,self)
	
	
	
func _process(delta: float) -> void:
	#FOR Now when it's their turn, they choose a random attack, but if a player cancle's then their action get rerolled
	if your_turn:
		PlayOutOptions -= 1
		EnemyAI._EnemyAI(Fight_stats.PlayerDeck.Deck)
	if your_turn and CharacterIsOut:
		PlayOutOptions -= 1

func _your_turn_on_set_up():
		PlayOutOptions = MaxPlayOutOptions
		EnemyAI._EnemyCurrentBarStatus()
		EnemyAI._player_actions()
		EnemyAI._deck_sorting(Fight_stats.PlayerDeck.Deck)

		#EnemyAI.call(Fight_stats.Enemy_AI_type)

	
func emp_gained(gained_EMP: int):
	if not Fight_stats.MAX_EMP <= Fight_stats.EMP:
		Fight_stats.EMP += gained_EMP
	else:
		print("EMP gain has reached the maximum or something went wrong in the code!")
	print(str(Fight_stats.EMP) + " / " + str(Fight_stats.MAX_EMP))


func _on_to_the_next_guy():
	if not len(Initiative.sorted_enemies) <= enemy.e_index + 1:
		Initiative.switch_order_e(enemy.e_index+1,enemy.e_index)
		enemy.e_index += 1
	else:
		your_turn = false

func _pass_character():
	for i in MaxPlayOutOptions:
		enemy_group.all_e_action.push_back(["pass_character","nonesense",self])
	_on_to_the_next_guy()
