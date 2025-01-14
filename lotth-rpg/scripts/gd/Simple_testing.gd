extends Node2D

@export var player: Player
@export var enemy: Enemy
@export var menu: PanelContainer


func _ready() -> void:
	print(player.Initiative.all_rolls)
func _process(_delta: float) -> void:
	
	pass
	if Input.is_action_just_pressed("debug_button"):
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
