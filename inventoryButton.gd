extends Button

var last = 1

func _on_pressed() -> void:
	get_tree().call_group("RPanel","hide")
	%"Inventory".visible = true
