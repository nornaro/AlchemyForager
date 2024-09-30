extends ItemList


# Called when the node enters the scene tree for the first time.
func pick() -> void:
	var hire
	var hires = get_items()
	var adventurers = Data.db.select_rows("Adventurer", "party = 'free'", ["name"])
	if adventurers.size() == 0:
		new_hire()
		return
	hire = adventurers.pick_random().name
	if !hire:
		return
	if hire in hires:
		return
	add_item(hire)

func get_items() -> Array:
	var items = []
	for i in range(get_item_count()):
		items.append(get_item_text(i))
	return items

func contains_name(nodeName: String) -> bool:
	for sublist in Data.hired.values():
		if nodeName in sublist:
			return true
	return false


func new_hire() -> void:
	var hire = {}
	hire["name"] = ""
	if randi_range(0,5) != 0:
		hire["name"] += Data.names.first.pick_random()
	if randi_range(0,5) != 0:
		if hire["name"] != "":
			hire["name"] += " "
		hire["name"] += Data.names.middle.pick_random()
	if randi_range(0,5) != 0:
		if hire["name"] != "":
			hire["name"] += " "
		hire["name"] += Data.names.last.pick_random()
	var genderrand = randi_range(0,100)
	if genderrand > 50:
		hire["gender"] = "Female"
	if genderrand < 50:
		hire["gender"] = "Male"
	if genderrand == 0:
		hire["gender"] = "Apache"
	if genderrand == 50:
		hire["gender"] = "Snowflake"
	if genderrand == 100:
		hire["gender"] = "Helicopter"
	hire["class"] = Data.classes.pick_random()
	Data.db.insert_row("Adventurer",hire)


func _on_pressed() -> void:
	clear()
	for i in range(randi_range(4, 6)):
		pick()


func _on_add_hire_gui_input(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return
	if !get_selected_items():
		return
	var hirename = get_item_text(get_selected_items()[0])
	if event.button_index == MOUSE_BUTTON_RIGHT:
		if !Data.party:
			return
		if Data.hired[Data.party].size() >= 5:
			return
		Data.hired[Data.party].append(hirename)
		add_member(hirename)
	if event.button_index == MOUSE_BUTTON_LEFT:
		Data.hired.Reserve.append(hirename)
	remove_item(get_selected_items()[0])
	$"../../Reserves/Hired"._ready()

func add_member(hirename) -> void:
	var scene = load("res://member.tscn")
	var instance = scene.instantiate()
	instance.name = hirename
	instance.tooltip_text = hirename
	instance.icon = load("res://"+Data.hires[hirename]["CLASS"]+".png")
	%Members.get_node(str(Data.party)).add_child(instance)


func _on_item_selected(index: int) -> void:
	get_tree().call_group("Gear","hire",get_item_text(index))


func _on_timer_timeout() -> void:
	pick()
