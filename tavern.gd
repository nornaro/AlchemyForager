extends Button

func _on_pressed() -> void:
	if !$"../../Tavern".visible:
		$"../../Tavern".visible = true
		for i in range(randi_range(4, 6)):
			$"../../Tavern/Hires".pick()
		return
	$"../../Tavern".visible = false
	$"../../Tavern/Hires".clear()
