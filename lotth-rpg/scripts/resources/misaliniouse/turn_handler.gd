extends Node

# Have to get the position where the characters will move
# It needs to access the other handlers and scripts that are important
# It is need to play it out in order one after another
@export_group("Handler's")
@export var ability_func: Ability_Handler
@export var Action_button_handler: Action_buttons_option_Handler
@export var item_handler: Item_handler

@export_group("Menu")
@export var Menu: Menu_system

@export_group("Groups")
@export var enemy_group: Enemy_group
@export var player_group: Player_group
@export var initiative: Initiative_class 


#  Key ,Who? ,Index ,Data1 ,Data2 ,Data3 ,Data4

#   ["atk", card_againts_enemies, index,     0, menu.player_group.index] FROM THE PLAYER!
#   ["bag", item_againts_enemies, index ,    1]							 FROM THE PLAYER

#   ["atk", card_againts_players, sub_index, 1, index]					 TO A PLAYER
#   ["bag", item_againts_players, sub_index ,0]							 TO A PLAYER
func _actions(stack):
	print(stack)
	for i in stack:
		# ECT, ECT
		
		if i[0] == "atk":
			
			match i[3]:
				0:
					player_group.player[i[4]]._use_card_and_lose_eng(i[1])
					
					if Data.get_card_damage_type(i[1]) == true:
						enemy_group.enemies[i[2]]._take_true_damage(Data.get_card_damage(i[1]))
					else:
						enemy_group.enemies[i[2]]._take_damage(player_group.player[i[4]].Fight_stats.Base_Phisical_Attack,Data.get_card_damage(i[1]),player_group.player[i[4]].Fight_stats.Attack_Type)
					
					Menu.ability_card_choice.ability_func._get_what_ability_got_used(i[1],Menu,enemy_group,player_group,i[4],i[2])
				1:
					
					player_group.player[i[4]]._use_card_and_lose_eng(i[1])
					player_group.player[i[2]]._use_card_and_gain_eng(i[1],Data.get_card_eng_or_hp(i[1]))
					Menu.ability_card_choice.ability_func._get_what_ability_got_used(i[1],Menu,enemy_group,player_group,i[4],i[2])

		if i[0] == "bag":
			
			match i[3]:
				0:
					if Data.get_item_health_type(i[1]) == true:
						player_group.player[i[2]].Bar.bar_health_restored(Data.get_item_hp(i[1]),2)
					else:
						player_group.player[i[2]].Bar.bar_health_restored(Data.get_item_eng(i[1]),1)
				1:
					if Data.get_item_damage_type(i[1]) == true:
						enemy_group.enemies[i[2]]._take_true_damage(Data.get_item_t_dmg(i[1]))
					else:
						enemy_group.enemies[i[2]]._take_damage(player_group.player[i[4]].Fight_stats.Base_Phisical_Attack,Data.get_item_dmg(i[1]),player_group.player[i[4]].Fight_stats.Attack_Type)
		
					
		
		await Engine.get_main_loop().create_timer(1).timeout
		
	
	stack.clear()
	initiative.initiative_index = 0
	initiative.action_start = false
	initiative.index_order[0][1].your_turn = true
