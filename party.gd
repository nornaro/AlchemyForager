extends VBoxContainer


func _on_pressed() -> void:
	get_tree().call_group("Members","hide")
	show()
	Data.party = name


func _on_button_pressed() -> void:
	pass # Replace with function body.
