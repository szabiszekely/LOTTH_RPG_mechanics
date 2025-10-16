extends Area2D

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")
@onready var Menu = RefrenceNode.Menu
@onready var get_player: Player 

var can_be_confirmed:bool = true
var pull = 145

# removing action after confirm
# only able to use one movement option per turn
# giving back action after cancle and activating movement again
# putting the back the player after canceling

func _process(_delta: float) -> void:
	if get_overlapping_bodies().size() < 1 or not get_player in get_overlapping_bodies():
		get_player.can_moved = false
		get_player.velocity += (self.global_position - get_player.global_position).normalized() * pull
		get_player.move_and_slide()
		await get_tree().create_timer(0.1).timeout
		get_player.can_moved = true
		
	if (self.global_position - get_player.global_position).length() >= 350:
		get_player.global_position = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select") and can_be_confirmed and get_player.can_moved:
		can_be_confirmed = false
		Menu.menu_index = 2
		Menu.vanish()
		Menu.switching_buttons()
		get_player.can_moved = false
		get_player.character_anim.flip_h = false
		Menu.movement.process_mode = Node.PROCESS_MODE_DISABLED
		
		Menu.menu_container = true
		Menu.current_state = Menu.Menu_state.MENU
		get_player.movement_restriction = true
		self.hide()
		get_player._play_out_tick_down()
		get_player.player.all_p_actions.push_back(["movement",0,get_player,get_player])

		await get_tree().create_timer(0.2).timeout
		Menu.movement.process_mode = Node.PROCESS_MODE_INHERIT
		self.queue_free()
