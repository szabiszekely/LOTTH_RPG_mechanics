extends Control
class_name Ability_control

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")


var card_deck_volume_1 = []
var card_deck_volume_2 = []
var page_turn = false
@onready var grid_1_2: GridContainer = $"PanelContainer/MarginContainer/Grid 1_2"
@onready var grid_2_2: GridContainer = $"PanelContainer/MarginContainer/Grid 2_2"
@onready var card: TextureRect = $Card
# all the possible 18 buttons that can appear in the ability system
#region New Code Region
@onready var button: Button = $"PanelContainer/MarginContainer/Grid 1_2/Button"
@onready var button_2: Button = $"PanelContainer/MarginContainer/Grid 1_2/Button2"
@onready var button_3: Button = $"PanelContainer/MarginContainer/Grid 1_2/Button3"
@onready var button_4: Button = $"PanelContainer/MarginContainer/Grid 1_2/Button4"
@onready var button_5: Button = $"PanelContainer/MarginContainer/Grid 1_2/Button5"
@onready var button_6: Button = $"PanelContainer/MarginContainer/Grid 1_2/Button6"
@onready var button_7: Button = $"PanelContainer/MarginContainer/Grid 1_2/Button7"
@onready var button_8: Button = $"PanelContainer/MarginContainer/Grid 1_2/Button8"
@onready var button_9: Button = $"PanelContainer/MarginContainer/Grid 1_2/Button9"
@onready var button_10: Button = $"PanelContainer/MarginContainer/Grid 2_2/Button"
@onready var button_11: Button = $"PanelContainer/MarginContainer/Grid 2_2/Button2"
@onready var button_12: Button = $"PanelContainer/MarginContainer/Grid 2_2/Button3"
@onready var button_13: Button = $"PanelContainer/MarginContainer/Grid 2_2/Button4"
@onready var button_14: Button = $"PanelContainer/MarginContainer/Grid 2_2/Button5"
@onready var button_15: Button = $"PanelContainer/MarginContainer/Grid 2_2/Button6"
@onready var button_16: Button = $"PanelContainer/MarginContainer/Grid 2_2/Button7"
@onready var button_17: Button = $"PanelContainer/MarginContainer/Grid 2_2/Button8"
@onready var button_18: Button = $"PanelContainer/MarginContainer/Grid 2_2/Button9"
#endregion
# when the focus is on this button it will put you to the second page!
@onready var next_previouse_page: Button = $Next_Previouse_Page
@onready var page_1: Label = $"PanelContainer/MarginContainer/Grid 1_2/Label"
@onready var page_2: Label = $"PanelContainer/MarginContainer/Grid 2_2/Label"

@onready var menu = RefrenceNode.Menu
@onready var ability_func= RefrenceNode.AbiHandler
@onready var player = RefrenceNode.PlayerGroup
@onready var enemy = RefrenceNode.EnemyGroup
@onready var initiative = RefrenceNode.InitiativeHandler



@onready var ability_inventory = [button,button_2,button_3,button_4,button_5,button_6,button_7,button_8,button_9,button_10,button_11,button_12,button_13,button_14,button_15,button_16,button_17,button_18] 
# this will get replaced with the characters actual deck! but as basic you will get a placeholder deck
var deck = preload("res://scripts/resources/Decks/Lil_guy_deck.tres").Deck
func _ready() -> void:
	#when the scene strts I just disable all the buttons that I do not need! 
	for i in ability_inventory:
		i.disabled = true
		i.modulate = Color.TRANSPARENT
		i.focus_mode = Control.FOCUS_NONE
	# here I just get all the buttons of all the first and second pages of the menu
	card_deck_volume_1 = grid_1_2.get_children()
	card_deck_volume_2 = grid_2_2.get_children()
	self.hide()
	
	
	
func abi_appear():
	# when this get called we will first:
	# show only the number of buttons, as much card names we have in our deck (more over info over there) 
	add_abilities(deck)
	#then we show our menu and play the tween to come up from the bottom 
	self.show()
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,-128),0.3).set_trans(Tween.TRANS_QUAD)
	
	
func abi_disappear():
	# when this gets called than we go through all the possible buttons! and then we make sure you cannot
	# interact with them! and then we just pull it down!
	for i in ability_inventory:
		i.disabled = true
		i.modulate = Color.TRANSPARENT
		i.focus_mode = Control.FOCUS_NONE
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,540),0.3).set_trans(Tween.TRANS_QUAD)
	await tweens.finished

func add_abilities(list_of_abilities: Array):
	# first we go through all our buttons and apply this to all of them!
	for i in list_of_abilities:
		# first we find the ability in the list of our given deck
		var find_abi_position_index = list_of_abilities.find(i)
		# then we set it to find that button and than we just turn on that button!
		var change_text_in_abi_list = ability_inventory[find_abi_position_index]
		change_text_in_abi_list.disabled = false
		change_text_in_abi_list.modulate = Color.WHITE
		change_text_in_abi_list.focus_mode = Control.FOCUS_ALL
		change_text_in_abi_list.text = str(i)
	# and than if our button list is larger than 10 than we activate the side buttons that will switch
	# between the 2 pages!

	# our code is in reverse so if it is smaller than turn it off and else make it active!
	if list_of_abilities.size() < 10:
		next_previouse_page.focus_mode = Control.FOCUS_NONE
		next_previouse_page.disabled = true
		button.grab_focus()
		page_1.hide()
		page_2.hide()
		button_3.focus_neighbor_right = "../Button"
		button_6.focus_neighbor_right = "../Button4"
		button_9.focus_neighbor_right = "../Button7"
		
	else:
		next_previouse_page.focus_mode = Control.FOCUS_ALL
		next_previouse_page.disabled = false
		button.grab_focus()
		page_1.show()
		page_2.show()
		button_3.focus_neighbor_right = "../../../../Next_Previouse_Page"
		button_6.focus_neighbor_right = "../../../../Next_Previouse_Page"
		button_9.focus_neighbor_right = "../../../../Next_Previouse_Page"
		
		
# if you focus on this button and you are on one of the pages
# disable the current one and switch to the other
func next_previouse_page_focus() -> void:
	if page_turn == false:
		button_10.grab_focus()
		page_turn = !page_turn
		grid_1_2.hide()
		grid_2_2.show()
		
	else:
		button.grab_focus()
		page_turn = !page_turn
		grid_1_2.show()
		grid_2_2.hide()
		

# when you have a card selected than a little side view pops up and you can see the card that way
# so our code just looks for the card through out its name and tries to grab the image of the same name
func focused() -> void:
	var get_name_of_button = get_viewport().gui_get_focus_owner().text
	var get_the_card = "res://assets/sprite/Ability Cards/" + str(get_name_of_button) + ".png"
	card.texture = load(get_the_card)
	

# when you press it you will get the:
func pressed() -> void:
	# the name of the choosen buttons name
	var used_card_name = get_viewport().gui_get_focus_owner().text
	# the energy cost of that card
	var hit = Data.get_card_energy(used_card_name)
	# and the target range
	var target = Data.get_card_range(used_card_name)
	
	#hide the menu and than see which of the 3 (4 perhaps later) chategory is it inside!
	menu.vanish()
	if str(target) == "Self":
		# if its self it is likely that you want to select the players so you can select which of the party
		# members do you want to select
		menu.choose_player_container = true
		player.card_againts_players = used_card_name
		menu.current_state = menu.Menu_state.CHOOSING_PLAYERS
	
	elif str(target) == "Target":
		# if its target than you will choose one of the enemies regaurdless of distance
		menu.choose_enemy_container = true
		enemy.card_againts_enemies = used_card_name
		menu.current_state = menu.Menu_state.CHOOSING_ENEMIES
# in both case is we set it up for the menu to handle our choice! Where we change our state to be either of
# the 2!

	else:
		#in this case we put it on hold and we use a simple function handler that will spawn down everything
		# we need to handle a range capped move!
		player.card_againts_players = used_card_name
		player.all_p_actions.push_back(["atk",2,initiative.sorted_player[player.p_index],0,used_card_name])
		
		# WARNING THIS MIGHT BE A PLACE WHERE A BUG COULD APPEAR! PLEASE IN THE NEAR FUTURE YOU ACT ON THIS
		# AND FIND A BETTER SOLUTION (IF THE SUSOECTED BUG IS SQUISHED PLS DELETE THIS MASSAGE)
		# THANK YOU!
		initiative.sorted_player[player.sub_index]._play_out_tick_down()
		if initiative.sorted_player[player.p_index].PlayOutOptions != 0:
			player.call_menu_appear()
