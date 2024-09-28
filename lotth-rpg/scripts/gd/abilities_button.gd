extends Menu_buttons


	


	
func _pressed() -> void:
	if self.focus_entered:
		when_button_pressed(self)
		self.release_focus()

func _on_focus_entered() -> void:
	hover(self)

func _on_focus_exited() -> void:
	unhover(self)
