extends Control
class_name Bar_system

# ALL of the export component
@export var assined_characters: Character_Controller 
@export var emp_bar: EMP_Bar_system 

# ALL of the components!
@onready var ENG_bar = $ENG_Bar
@onready var HP_bar = $HP_Bar
@onready var Null_bar = $Null_BG
@onready var ADR_bar: ColorRect = $ADR_Bar
@onready var name_tag: Label = $Name_tab/Label
@onready var Health_number: Label = $Health/Label
@onready var Energy_number: Label = $Energy/Label
@onready var health_text: Panel = $Health
@onready var energy_text: Panel = $Energy
@onready var action_remaining: HBoxContainer = $Action_remaining
@onready var health_pos: Marker2D = $Health_pos
@onready var energy_pos: Marker2D = $Energy_pos


@onready var action_indicator_scene = preload("res://scenes/action_indicator.tscn")
var all_icon_of_remaining_actions: Array = []
# this is a test for the Adrenalin, but it is alright for the visuals
@onready var textures = [preload("res://assets/sprite/UI/Health_BG.png"),preload("res://assets/sprite/UI/Energy_BG.png"),preload("res://assets/sprite/UI/Health_BG_ADR.png"), preload("res://assets/sprite/UI/Energy_BG_ADR.png")]
var test_ADR: bool = false


func _ready() -> void:
	for i in assined_characters.MaxPlayOutOptions:
		var instance = action_indicator_scene.instantiate()
		all_icon_of_remaining_actions.append(instance)
		action_remaining.add_child(instance)
	energy_changed()
	health_changed()
	ADR_bar.hide()
	ENG_bar.set_max_value(assined_characters.Fight_stats.MAX_ENG)
	HP_bar.set_max_value(assined_characters.Fight_stats.MAX_HP)

# Still ugly, but it works and I do not care about anything else
# beauty lies in the insides... yeah close enough, but still ugly
func _process(_delta: float) -> void:
	health_changed()
	energy_changed()
	
# I can change the HUD to the adrenalin, but it is a 100% visual for now
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Cam_change"):
		var style : StyleBoxTexture = StyleBoxTexture.new()
		var style2 : StyleBoxTexture = StyleBoxTexture.new()
		if test_ADR:
			style.texture = textures[0]
			health_text.add_theme_stylebox_override("panel",style)
			style2.texture = textures[1]
			energy_text.add_theme_stylebox_override("panel",style2)
			ADR_bar.hide()
			test_ADR = false
		else:
			style.texture = textures[2]
			health_text.add_theme_stylebox_override("panel",style)
			style2.texture = textures[3]
			energy_text.add_theme_stylebox_override("panel",style2)
			ADR_bar.show()
			test_ADR = true

# we give a set number of damage and then I remove that amount of bars every for cycle
func bar_damage_taken(damage:int):
	for i in damage:
		# if ENG bigger than 0 than I just take away 1 bar and shake the little snack at the top!
		if not assined_characters.Fight_stats.ENG <= 0 :
			ENG_bar.decrease_bar_value(1)
			var tweens = get_tree().create_tween()
			tweens.tween_property(energy_text,"position",Vector2(energy_text.position.x - 10,energy_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			tweens.tween_property(energy_text,"position",Vector2(energy_text.position.x + 10,energy_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			tweens.tween_property(energy_text,"position",Vector2(energy_pos.position.x,energy_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			assined_characters.Fight_stats.ENG -= 1
			await get_tree().create_timer(0.32).timeout
			if assined_characters.Fight_stats.ENG <= 0:
				assined_characters.Fight_stats.ENG = 0
		# same here, but for the hp
		elif not assined_characters.Fight_stats.HP <= 0:
			HP_bar.decrease_bar_value(1)
			var tweens = get_tree().create_tween()
			tweens.tween_property(health_text,"position",Vector2(health_text.position.x - 10,health_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			tweens.tween_property(health_text,"position",Vector2(health_text.position.x + 10,health_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			tweens.tween_property(health_text,"position",Vector2(health_pos.position.x,health_text.position.y),0.05).set_trans(Tween.TRANS_BOUNCE)
			assined_characters.Fight_stats.HP -= 1
			await get_tree().create_timer(0.32).timeout
		# if the HP is bellow 0 then I just turn on CharacterIsOut
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

# this is for the bar recovery
func bar_health_restored(health_gain:int,heal_eng_or_health: int):
	for i in health_gain:
		# I get the number of how much I will gain and then check if it's energy we puting it into or health
		match heal_eng_or_health:
			1:
				if not assined_characters.Fight_stats.ENG >= assined_characters.Fight_stats.MAX_ENG:
					assined_characters.Fight_stats.ENG += 1
					ENG_bar.increase_bar_value(1)
					await get_tree().create_timer(0.15).timeout
				
			2:
				if not assined_characters.Fight_stats.HP >= assined_characters.Fight_stats.MAX_HP:
					HP_bar.increase_bar_value(1)
					assined_characters.Fight_stats.HP += 1
					await get_tree().create_timer(0.15).timeout

func health_changed():
	Health_number.text = str(assined_characters.Fight_stats.HP) + "|" + str(assined_characters.Fight_stats.MAX_HP)
func energy_changed():
	Energy_number.text = str(assined_characters.Fight_stats.ENG) + "|" + str(assined_characters.Fight_stats.MAX_ENG)

func _reset_action_indicator():
	for i in all_icon_of_remaining_actions:
		i._action_indicator_on()

func _emp_bar(amount):
	if not emp_bar == null:
		self.emp_bar._increase_emp(amount)
