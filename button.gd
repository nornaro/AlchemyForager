extends Button

func _on_pressed() -> void:
	%BodyFemale.visible = !button_pressed
	%BodyMale.visible = button_pressed
