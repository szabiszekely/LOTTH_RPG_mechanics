extends Control
class_name Ability_control

var card_deck_volume_1 = []
var card_deck_volume_2 = []
var page_turn = false
@onready var grid_1_2: GridContainer = $"PanelContainer/MarginContainer/Grid 1_2"
@onready var grid_2_2: GridContainer = $"PanelContainer/MarginContainer/Grid 2_2"
@onready var card: TextureRect = $Card
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
@onready var next_previouse_page: Button = $Next_Previouse_Page
@onready var page_1: Label = $"PanelContainer/MarginContainer/Grid 1_2/Label"
@onready var page_2: Label = $"PanelContainer/MarginContainer/Grid 2_2/Label"
@export var menu: Menu_system 

@onready var ability_inventory = [button,button_2,button_3,button_4,button_5,button_6,button_7,button_8,button_9,button_10,button_11,button_12,button_13,button_14,button_15,button_16,button_17,button_18] 
var deck = ["Mile Punch","Funny Magic","Agressive Stomp","Curved Slash","Byecicle","Dual Wielding","Thunder Song","BAM","SEX","Goober"]

func _ready() -> void:
	for i in ability_inventory:
		i.disabled = true
		i.modulate = Color.TRANSPARENT
		i.focus_mode = Control.FOCUS_NONE
	card_deck_volume_1 = grid_1_2.get_children()
	card_deck_volume_2 = grid_2_2.get_children()
	self.hide()
	
	
	
func abi_appear():
	add_abilities(deck)
	self.show()
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,-128),0.3).set_trans(Tween.TRANS_QUAD)
	
	
func abi_disappear():
	for i in ability_inventory:
		i.disabled = true
		i.modulate = Color.TRANSPARENT
		i.focus_mode = Control.FOCUS_NONE
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,540),0.3).set_trans(Tween.TRANS_QUAD)
	await tweens.finished

func add_abilities(list_of_abilities: Array):
	for i in list_of_abilities:
		var find_abi_position_index = list_of_abilities.find(i)
		var change_text_in_abi_list = ability_inventory[find_abi_position_index]
		change_text_in_abi_list.disabled = false
		change_text_in_abi_list.modulate = Color.WHITE
		change_text_in_abi_list.focus_mode = Control.FOCUS_ALL
		change_text_in_abi_list.text = str(i)
	print(list_of_abilities.size())
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
		


func focused() -> void:
	var get_name_of_button = get_viewport().gui_get_focus_owner().text
	var get_the_card = "res://assets/sprite/Ability Cards/" + str(get_name_of_button) + ".png"
	card.texture = load(get_the_card)
	


func pressed() -> void:
	#print(get_viewport().gui_get_focus_owner().text)
	var used_card_name = get_viewport().gui_get_focus_owner().text
	menu.player_group.player[0]._use_card(used_card_name)
