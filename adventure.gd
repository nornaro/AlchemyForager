extends Button

func _on_pressed() -> void:
	if !$"../../Adventure".visible:
		$"../../Adventure".visible = true
		$"../../Adventure".get_node("Level").add_levels()
		return
	$"../../Adventure".visible = false
