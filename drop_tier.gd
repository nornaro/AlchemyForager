extends RichTextLabel


func _on_level_item_selected(index: int) -> void:
	var i =int($"../../HBoxContainer2/Level".get_item_text(index))
	text =  "[center]"+"%X" % ceil(sqrt(i))+"[/center]"
