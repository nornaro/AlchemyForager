extends ItemList


func _on_item_selected(index: int) -> void:
	if get_node("%"+get_item_text(index)).visible:
		get_node("%"+get_item_text(index)).hide()
		deselect(index)
		return
	get_tree().call_group(name,"hide")
	get_node("%"+get_item_text(index)).show()
