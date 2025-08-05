extends Resource
class_name Initiative_class




# THIS IS THE OLD ONE DUMBASS!!!
# USE THE NEW ONE PLS
# BE CAREFUL WHICH ONE YOU UPDATE









var all_rolls: Array = []
@export var bg_container = Texture2D
var index_order: Array = []
var initiative_index: int = 0
var action_queued: Array = []
var group_enemies
var group_player
var place_holder_source
var action_start: bool = false
var cancle_enemy_back_up: bool = false
var cancle_player_back_up: bool = false
var MaxTurns: int = 0
var timeSpentBetweenTurns: int = 1
var doTrapForLoop: bool = false

signal stopLoopInPlace

# this gets the neccesery nodes as references
func _getting_groups(players,enemies):
	group_player = players
	group_enemies =  enemies

# rerolls all the groups initiative
func _roll_reset():
	all_rolls.clear()
	for player in group_player.player:
		player.roll_of_the_luck()
	for enemy in group_enemies.enemies:
		enemy.roll_of_the_luck()
	_getting_all_rolls(all_rolls,place_holder_source)

# when the rolls got determend all of them will get passed to this which will sort them all by a simple
# algorhytm
func _getting_all_rolls(rolls:Array,source):
	for i in source.get_children():
		if source.get_children() != []:
			i.free()
	rolls.sort_custom(priority)
	
	# when done we will go through the rolls and add them to the indicatior
	for portait in rolls:
		var portrait_texture = portait[3]
		var container = TextureRect.new()
		var portrait_icon = TextureRect.new()
		container.texture = bg_container
		container.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
		if portait[0] == 1:
			container.self_modulate = "f54e4e"
		
		portrait_icon.texture = portrait_texture
		portrait_icon.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
		portrait_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		portrait_icon.position = Vector2(6,8)
		portrait_icon.size = Vector2(40,40)
		
		source.add_child(container)
		container.add_child(portrait_icon)

# this 2 either go forward in the order or back
func _next_in_order():
	if initiative_index < all_rolls.size() - 1:
		initiative_index += 1
		switch_order(initiative_index, initiative_index-1)

func _previouse_in_order():
	if initiative_index > 0:
		initiative_index -= 1
		switch_order(initiative_index, initiative_index+1)

func switch_order(x,y):
	index_order[y][1].your_turn = false
	await Engine.get_main_loop().create_timer(0.15).timeout
	index_order[x][1].your_turn = true
	#print(index_order[y][1]," ",index_order[x][1])

# get the placement of everyone in their recpected group in the order Array
func _get_the_index_with_order():
	index_order.clear()
	for check in all_rolls:
		var group_index:int = 0
		var p_index_list = []
		var e_index_list = []
		for p in group_player.player:
			if p == check[4]:
				p_index_list = [check[0],p,group_index]
				index_order.append(p_index_list)
				group_index = 0
			else:
				group_index += 1
				
		group_index = 0
		
		for e in group_enemies.enemies:
			if e == check[4]:
				e_index_list = [check[0],e,group_index]
				index_order.append(e_index_list)
				group_index = 0
			else:
				group_index += 1
# this how the priority works:
func priority(a,b):
	# if the rolls are the same than check-
	if a[1] == b[1]:
		# if they are the same one than the faster one wins and gets ahead!
		if a[0] == b[0]:
			if a[2] > b[2]:
				return true
			return false
		# if not then-
		elif a[0] != b[0]:
			# the one "friend" is come before!
			if a[0] == 0:
				return true
			elif b[0] == 0:
				return false
	# other than that the faster gets ahead!
	if a[1] > b[1]:
		return true
	return false
