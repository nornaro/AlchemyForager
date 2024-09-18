extends Button

func _on_pressed() -> void:
	$"../BodyF".visible = !button_pressed
	$"../BodyM".visible = button_pressed
