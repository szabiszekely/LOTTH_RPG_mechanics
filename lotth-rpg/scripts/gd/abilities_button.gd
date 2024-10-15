extends Menu_buttons

#Extends from Menu and plays a tween!
	
func _pressed() -> void:
	if self.focus_entered:
		when_button_pressed(self)
		self.release_focus()

func _on_focus_entered() -> void:
	hover(self)

func _on_focus_exited() -> void:
	unhover(self)
