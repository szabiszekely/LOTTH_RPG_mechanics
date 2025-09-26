extends Control
class_name Indicator_bar





# THIS ONE IS THE OLD BAR SYSTEM DUMBY!!!
# PLEASE CHECK WHERE YOU ARE BEFORE CODING!!!!
# LEAVE AND DELETE THIS FILE ALREADY !!!!!!!!!!!!!!!!!!!!!!!!!!!!
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!









@export var assined_characters: Character_Controller 
#ALL of the components!
@onready var ENG_bar = $ENG_Segmented_Bar
@onready var HP_bar = $HP_Segmented_Bar
@onready var Null_barr = $NULL
@onready var name_tag: Label = $Name_tab/Label
@onready var Health_number: Label = $Health/Label
@onready var Energy_number: Label = $Energy/Label
@onready var health_text: Panel = $Health
@onready var energy_text: Panel = $Energy
@onready var action_remaining: HBoxContainer = $Action_remaining

@onready var action_indicator_scene = preload("res://scenes/action_indicator.tscn")
# this value gets the difference between 1 unit/max
var offset_value : float
var all_icon_of_remaining_actions: Array = []

#var constant_damage = 0 
#var constant_health = 0
#var current_health: int

func _ready():
	for i in assined_characters.MaxPlayOutOptions:
		var instance = action_indicator_scene.instantiate()
		all_icon_of_remaining_actions.append(instance)
		action_remaining.add_child(instance)
		
	#Setting up the 'count' which is the max number in the shader in both the max hp and max eng
	ENG_bar.material.set_shader_parameter("count",assined_characters.Fight_stats.MAX_ENG)
	HP_bar.material.set_shader_parameter("count",assined_characters.Fight_stats.MAX_HP)
	name_tag.text = assined_characters.Fight_stats.name
	energy_changed()
	health_changed()
	# I dived the number of health by 1 and get a really small number that is 1 portion of the entire bar and this is our 1 incruments!
	offset_value = 1.0/ENG_bar.material.get_shader_parameter("count")
	# I honestly have no idea what does dividing by 2 does 
	# but i know that I must take 1 damage when starting bc the first damage does not count and after that 
	# if not hadled the calculation will be off
	ENG_bar.material.set_shader_parameter("value",ENG_bar.material.get_shader_parameter("value") - offset_value/2)
	HP_bar.material.set_shader_parameter("value",HP_bar.material.get_shader_parameter("value") - offset_value/2)
func _process(_delta: float) -> void:
	#ugly but I can't do shit about it!
	health_changed()
	energy_changed()
	#if assined_characters.Fight_stats.HP <= 0 and assined_characters.Fight_stats.ENG <= 0 and assined_characters.CharacterIsOut:
		#
		#queue_free()
		#assined_characters.queue_free()
func bar_damage_taken(damage:int):
	
	for i in damage:
		# if ENG bigger than 0 than I just take away 1 bar and shake the little snack at the top!
		if not ENG_bar.material.get_shader_parameter("value") < 0:
			ENG_bar.material.set_shader_parameter("value",ENG_bar.material.get_shader_parameter("value") - offset_value)
			var energy_text_pos = 238
			var tweens = get_tree().create_tween()
			tweens.tween_property(energy_text,"position",Vector2(energy_text.position.x - 10,energy_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			tweens.tween_property(energy_text,"position",Vector2(energy_text.position.x + 10,energy_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			tweens.tween_property(energy_text,"position",Vector2(energy_text_pos,energy_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			assined_characters.Fight_stats.ENG -= 1
			await get_tree().create_timer(0.32).timeout
			#simple check if the ENG < 0 then I just make sure that it can't be negative number
			if assined_characters.Fight_stats.ENG <= 0:
				assined_characters.Fight_stats.ENG = 0
		
		# same here but with the heart!
		elif not HP_bar.material.get_shader_parameter("value") < 0:
			HP_bar.material.set_shader_parameter("value",HP_bar.material.get_shader_parameter("value") - offset_value)
			var hp_text_pos = 147
			var tweens = get_tree().create_tween()
			tweens.tween_property(health_text,"position",Vector2(health_text.position.x - 10,health_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			tweens.tween_property(health_text,"position",Vector2(health_text.position.x + 10,health_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			tweens.tween_property(health_text,"position",Vector2(hp_text_pos,health_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			assined_characters.Fight_stats.HP -= 1
			await get_tree().create_timer(0.32).timeout
			
		if assined_characters.Fight_stats.HP <= 0:
			assined_characters.Fight_stats.HP = 0
			assined_characters.CharacterIsOut = true
			if assined_characters.Fight_stats.Friend_or_Foe == 0:
				var knocked_out_counter_player = 0
				for j in assined_characters.Initiative.sorted_player:
					if j.CharacterIsOut == true:
						knocked_out_counter_player += 1
				if knocked_out_counter_player >= len(assined_characters.Initiative.sorted_player):
					# End of the game
					print("Enemy wins")
					get_tree().quit()
			else:
				var knocked_out_counter_enemy = 0
				for j in assined_characters.Initiative.sorted_enemies:
					if j.CharacterIsOut == true:
						knocked_out_counter_enemy += 1
				if knocked_out_counter_enemy >= len(assined_characters.Initiative.sorted_enemies):
					# End of the game
					print("Player wins")
					get_tree().quit()
				
		else:
			assined_characters.CharacterIsOut = false
			
func bar_health_restored(health_gain:int,heal_eng_or_health: int):
	for i in health_gain:
		# I get the number of how much I will gain and then check if it's energy we puting it into or health
		match heal_eng_or_health:
			1:
				# if ENG bigger than 0 than I just take away 1 bar and shake the little snack at the top!
				if not assined_characters.Fight_stats.ENG >= assined_characters.Fight_stats.MAX_ENG:
					#print(assined_characters.Fight_stats.ENG)
					ENG_bar.material.set_shader_parameter("value",ENG_bar.material.get_shader_parameter("value") + offset_value)
					assined_characters.Fight_stats.ENG += 1
					await get_tree().create_timer(0.15).timeout
				
			2:
				if not assined_characters.Fight_stats.HP >= assined_characters.Fight_stats.MAX_HP:
					HP_bar.material.set_shader_parameter("value",HP_bar.material.get_shader_parameter("value") + offset_value)
					assined_characters.Fight_stats.HP += 1
					await get_tree().create_timer(0.15).timeout
			
			

# These are here for the numbers besid the players so you don't have to guess for your own hp and eng
func health_changed():
	Health_number.text = str(assined_characters.Fight_stats.HP) + "|" + str(assined_characters.Fight_stats.MAX_HP)
func energy_changed():
	Energy_number.text = str(assined_characters.Fight_stats.ENG) + "|" + str(assined_characters.Fight_stats.MAX_ENG)

func _reset_action_indicator():
	for i in all_icon_of_remaining_actions:
		i._action_indicator_on()
