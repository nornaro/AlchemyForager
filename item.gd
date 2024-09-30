extends TextureRect

var cursor
var item: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)

func count(amount):
	if amount:
		$LineEdit.text = str(amount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	cursor.position = get_local_mouse_position()
	if Data.stack == -1:
		return
	cancel_stack()
	
func cancel_stack():
	get_tree().call_group("Stack","hide")
	Data.stack = -1
	if is_instance_valid(cursor):
		cursor.queue_free()
	set_process(false)

func edit_name():
	$LineEdit.editable = true
	print($LineEdit.editable)
	$LineEdit.grab_focus()

func _on_gui_input(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return
	if event.is_action_pressed("RMB"):
		edit_name()
	if event.is_action_pressed("LMB"):
		var slot = get_parent().name
		get_tree().call_group("RPanel","shownode",item.type)
		cursor = duplicate()
		cursor.move_to_front()
		cursor.modulate.a = 0.5
		add_child(cursor)
		Data.item = [get_parent().get_parent().name,slot,item.duplicate()]
		get_tree().call_group("RPanel","shownode",item.type)
		set_process(true)
		return
	if event.is_action_released("LMB"):
		if !Data.slot:
			cancel_stack()
			return
		print(item.type)
		if item.type != "Item":
			get_tree().call_group("Stack","set_phtext",item.Count)
			get_tree().call_group("Stack","show")
			get_tree().call_group("Stack","set_position",get_global_mouse_position())		
			get_tree().call_group("Stack","grab_focus")
		if item.type == "Item":
			get_tree().call_group("Stack","_on_text_submitted","")
		if is_instance_valid(cursor):
			cursor.hide()
		Data.write("inventory")

func _on_line_edit_text_submitted(new_text: String) -> void:
	item.name = new_text
	$LineEdit.editable = false
