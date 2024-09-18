extends ItemList


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_menu_pressed() -> void:
	if visible:
		hide()
		return
	show()


func _on_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	match get_item_text(index):
		"Exit":
			get_tree().quit()
