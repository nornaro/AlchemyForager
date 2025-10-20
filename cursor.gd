extends Panel

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	%Cursor.texture = Data.cursor
	#Data.db.query("SELECT name FROM sqlite_master WHERE type='table'")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		%Cursor.position = get_local_mouse_position()
