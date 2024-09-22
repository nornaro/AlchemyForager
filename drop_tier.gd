extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_item_selected(index: int) -> void:
	var i =int($"../../HBoxContainer2/Level".get_item_text(index))
	text =  "[center]"+"%X" % ceil(sqrt(i))+"[/center]"
