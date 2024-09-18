extends Button

var last = 1

func _on_pressed() -> void:
	if !$"../../Inventory".visible:
		$"../../Inventory".visible = true
		return
	$"../../Inventory".visible = false
