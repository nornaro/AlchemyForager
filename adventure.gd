extends Button

func _on_pressed() -> void:
	if !%"Adventure".visible:
		%"Adventure".visible = true
		$"../../Panel/HBoxContainer/RPanel/Adventure/VBoxContainer/HBoxContainer2/Level".add_levels()
		return
	%"Adventure".visible = false
