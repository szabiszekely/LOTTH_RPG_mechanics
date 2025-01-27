extends Node2D

@export var player: Player_group
@export var enemy: Enemy_group
@export var menu: PanelContainer
@export var initiative: Initiative_class
@onready var turn_handler: Node = $Turn_Handler

func _ready() -> void:
	initiative._getting_groups(player,enemy)
	#print(player.player[0].Initiative.all_rolls)
	initiative._get_the_index_with_order()
	#print(initiative.index_order)
	
	initiative.index_order[0][1].your_turn = true
	
func _process(_delta: float) -> void:
	if initiative.action_queued.size() == initiative.all_rolls.size() and not initiative.action_start:
		initiative.action_start = true
		initiative.index_order[initiative.all_rolls.size() - 1][1].your_turn = false
		#PUT THE TURN START CODE HERE LATER !!!!! and delete this!!!!ú
		turn_handler._actions(initiative.action_queued)
	pass
	if Input.is_action_just_pressed("debug_button"):
		initiative._roll_reset()
		initiative._get_the_index_with_order()
		initiative.action_queued.clear()
		print("--------------------------------")
		#print("all the rolls: ",initiative.all_rolls)
		print("this is the index order (friend or foe, index): ", initiative.index_order)
		for i in initiative.all_rolls.size():
			initiative.index_order[i][1].your_turn = false
		initiative.index_order[0][1].your_turn = true
		initiative.initiative_index = 0
		#menu.enemy_group.enemies[0]._use_card_and_gain_eng("test",Data.get_card_eng_or_hp("test"))
		pass
		#player._use_card_and_lose_eng("Thunder Song")
		#player._take_damage(enemy.Fight_stats.Base_Phisical_Attack,24,enemy.Fight_stats.Attack_Type)
		#player._take_true_damage(4,enemy.Fight_stats.Attack_Type)
		#enemy._take_damage(player.Fight_stats.Base_Phisical_Attack,randi_range(1,125),player.Fight_stats.Attack_Type)
	if Input.is_action_just_pressed("debug_button_2"):
		#menu.enemy_group.enemies[0]._use_card_and_lose_eng("test")
		pass
		#player._damage_healed(12,1)
		#print(player.Fight_stats.ENG)
		#menu.abi = true
