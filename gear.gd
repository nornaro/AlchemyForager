extends Sprite2D

var float_in = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if float_in && position.x < -425:
		position.x += 1
	if !float_in && position.x > -1100:
		position.x -= 1


func _on_fighter_pressed() -> void:
	float_in = !float_in


func _on_mage_pressed() -> void:
	float_in = !float_in


func _on_priest_pressed() -> void:
	float_in = !float_in


func _on_archer_pressed() -> void:
	float_in != float_in
	pass # Replace with function body.

	
