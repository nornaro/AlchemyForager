extends MenuButton


func _on_menu_pressed() -> void:
	#self.
	if visible:
		hide()
		return
	show()
