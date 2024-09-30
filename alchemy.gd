extends Button

func _on_pressed() -> void:
	get_tree().call_group("RPanel","hide")
	%"Alchemy".visible = true
	%"Inventory".visible = true
