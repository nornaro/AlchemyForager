extends LineEdit

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#set_position()
	#position = get_global_mouse_position()
	#grab_focus()
	
var slot
var regex = RegEx.new()
var oldtext = ""

func _ready():
	regex.compile("^[0-9]*$")

func get_value():
	if !text:
		return (int(placeholder_text))
	return(int(text))

func set_phtext(phtext):
	placeholder_text = str(phtext)
	
func _on_text_changed(new_text: String) -> void:
	if !regex.search(new_text):
		text = oldtext
		return
	oldtext = new_text


func _on_text_submitted(_new_text: String) -> void:
	if Data.item[2].type != "Item":
		Data.item[2].Count = get_value()
	var source = %Inventory
	var destination = %Inventory
	if str(Data.item[0]) == "Alchemy":
		source = %Alchemy
	if str(Data.slot[0]) == "Alchemy":
		destination = %Alchemy
	if ((Data.slot[0] == "Alchemy" && 
		Data.slot[1] == str(9) && 
		Data.item[2].type != "Item")||
		(Data.slot[0] == "Alchemy" && 
		Data.slot[1] != str(9) && 
		Data.item[2].type == "Item")):
		_on_focus_exited()
		return
	var remove = source.get_node(str(Data.item[0])).remove(Data.item[1].to_int(),Data.item[2])
	print(remove)
	var add = destination.get_node(str(Data.slot[0])).add(Data.slot[1].to_int(),Data.item[2])
	print(add)
	if !add:
		source.get_node(str(Data.slot[0])).add(Data.slot[1].to_int(),Data.item[2])
	_on_focus_exited()

func _on_focus_entered() -> void:
	text = ""


func _on_focus_exited() -> void:
	text = ""
	hide()

func _unhandled_input(event: InputEvent) -> void:
	event.is_pressed()
