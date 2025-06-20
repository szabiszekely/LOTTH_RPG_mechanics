extends TextureRect

@export var test_order: Test_order
@onready var label: Label = $Label

func _play_out(all_actions):
	print(all_actions)
	for i in all_actions:
		label.text = i[0]+ ": " + str(i[1])
		print(i)
		await get_tree().create_timer(1).timeout

	test_order.not_started = false
	test_order._reset()
