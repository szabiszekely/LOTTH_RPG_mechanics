extends Menu_buttons


func _ready() -> void:
	self.grab_focus()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		self.grab_focus()

	
func _pressed() -> void:
	if self.focus_entered:
		when_button_pressed(self)
		self.release_focus()

func _on_focus_entered() -> void:
	hover(self)

func _on_focus_exited() -> void:
	unhover(self)
