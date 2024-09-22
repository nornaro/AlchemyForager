extends Button

func _on_pressed() -> void:
	if !%"Alchemic".visible:
		%"Alchemic".visible = true
		%"Inventory".visible = true
		return
	%"Alchemic".visible = false
	%"Inventory".visible = false
