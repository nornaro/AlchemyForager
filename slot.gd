extends Panel


func _on_mouse_entered() -> void:
	Data.slot = [get_parent().name, name]
