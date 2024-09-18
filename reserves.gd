extends Button



func _on_pressed() -> void:
	if !$"../../Reserves".visible:
		$"../../Reserves".visible = true
		return
	$"../../Reserves".visible = false
