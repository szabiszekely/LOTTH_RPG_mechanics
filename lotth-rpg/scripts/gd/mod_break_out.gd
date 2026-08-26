extends Node2D
class_name Break_Out

@export var user_break_out_total: int = 0 ## How much additional help you get per mash. 1 + (UBOT/10) + MB per mash
@export var opponent_break_out_total: int = 0 ## How much does it reduces your percentage when the reducer time cycle happens. 0.1 + (OBOT/10) + (RB/2)
@export var masher_bonus:int = 0 ## gives bonus to the masher formula. +X per mash
@export var reducer_bonus:int = 0 ## gives bonus to the reduction formula. +(X/2) per reduction cycle
@export var reducer_time_delay:float = 2 ## how fast time passes between reductions.

@onready var timer: Timer = $mash_wait
@onready var break_out_reducer: Timer = $break_out_reducer
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var run_timer: Timer = $run_timer
@onready var clock_hand: Sprite2D = $ProgressBar/clock_hand

var mash_waiter: bool = false
var first_input:bool = true
var break_out_timer_end: bool = false

var ReferenceNode: CrossRoad

func _break_out_meter_setup(user_bo_total:int,opponent_bo_total:int,break_out_meter:float,refrence_node,masher_b = 0,reducer_b = 0,reducer_ti_de:float = 2):
	user_break_out_total = user_bo_total
	opponent_break_out_total = opponent_bo_total
	masher_bonus = masher_b
	reducer_bonus = reducer_b
	reducer_time_delay = reducer_ti_de
	progress_bar.value = break_out_meter
	ReferenceNode = refrence_node

func _ready() -> void:
	progress_bar.value = 3
	break_out_timer_end = false
	clock_hand.rotation_degrees = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer.wait_time = delta
	if Input.is_anything_pressed() and !mash_waiter and !break_out_timer_end:
		if first_input:
			first_input = false
			break_out_reducer.wait_time = reducer_time_delay + delta
			break_out_reducer.start()
			run_timer.start()
			_timer_visual()
		mash_waiter = true
		progress_bar.value += 1 + (user_break_out_total/10) + masher_bonus
	if !Input.is_anything_pressed() and mash_waiter and !break_out_timer_end:
		timer.start()
	if progress_bar.value == 100:
		break_out_reducer.stop()
		run_timer.stop()
		get_tree().quit()


func _mash_waiter() -> void:
	mash_waiter = false

func _on_break_out_reducer_timeout() -> void:
	progress_bar.value -= 0.1 + (opponent_break_out_total/10) + (reducer_bonus/2)
	
func _timer_visual():
	var tween = get_tree().create_tween()
	tween.tween_property(clock_hand,"rotation_degrees",360,5)

func _on_run_timer_timeout() -> void:
	break_out_reducer.stop()
	break_out_timer_end = true
	ReferenceNode.InitiativeHandler.doTrapForLoop = false
	ReferenceNode.InitiativeHandler.stopLoop.emit()
	ReferenceNode.break_out_meter = progress_bar.value
	await get_tree().create_timer(0.1).timeout
	self.queue_free()
	
