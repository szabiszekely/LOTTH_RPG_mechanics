extends Node
class_name Break_Out

@export var user_break_out_total: int = 0
@export var opponent_break_out_total: int = 0
@export var masher_bonus:int = 0
@export var reducer_bonus:int = 0
@export var reducer_time_delay:float = 0.1

@onready var timer: Timer = $mash_wait
@onready var break_out_reducer: Timer = $break_out_reducer
@onready var progress_bar: ProgressBar = $ProgressBar

var mash_waiter: bool = false
var first_input:bool = true

func _break_out_meter_setup(user_bo_total,opponent_bo_total,masher_b = 0,reducer_b = 0,reducer_ti_de = 0.1):
	user_break_out_total = user_bo_total
	opponent_break_out_total = opponent_bo_total
	masher_bonus = masher_b
	reducer_bonus = reducer_b
	reducer_time_delay = reducer_b

func _ready() -> void:
	progress_bar.value = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer.wait_time = delta
	if Input.is_anything_pressed() and !mash_waiter:
		if first_input:
			first_input = false
			break_out_reducer.wait_time = reducer_time_delay + delta
			break_out_reducer.start()
		mash_waiter = true
		progress_bar.value += 1 + (user_break_out_total/10) + masher_bonus
	if !Input.is_anything_pressed() and mash_waiter:
		timer.start()
	if progress_bar.value == 100:
		break_out_reducer.stop()


func _mash_waiter() -> void:
	mash_waiter = false

func _on_break_out_reducer_timeout() -> void:
	progress_bar.value -= 0.1 + (opponent_break_out_total/10) + (reducer_bonus/2)
	
