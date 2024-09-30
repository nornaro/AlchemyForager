extends ItemList

@export var stats := {
	"DEAD": false,
	"GENDER": "",
	"NAME": "",
	"CLASS": "",
	"EXP": 1,
	"LVL": 1,
	"COMP": 1,
	"PATK": 1,
	"PDEF": 1,
	"MATK": 1,
	"MDEF": 1,
	"GEAR": {
		"Head": 0,
		"shoulder": 0,
		"Armor": 0,
		"wrist": 0,
		"Feet": 0,
		"Main": 0,
		"Side": 0,
		"Potion1": 0,
		"Potion2": 0,
		"Potion3": 0,
	}
}

# Called when the node enters the scene tree for the first time.
func pick() -> void:
	var hire
	var hires = get_items()
	if Data.hires.keys().size():
		hire = Data.hires[Data.hires.keys().pick_random()]
	if !Data.hires.keys().size() || randi_range(0,100) == 0:
		hire = new_hire()
	if !hire:
		hire = new_hire()
	if hire["NAME"] in hires:
		return
	if contains_name(hire["NAME"]):
		return
	hires.append(hire["NAME"])
	add_item(hire["NAME"])

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


func new_hire() -> Dictionary:
	var hire = stats.duplicate(true)
	if randi_range(0,5) != 0:
		hire["NAME"] += Data.names.first.pick_random()
	if randi_range(0,5) != 0:
		if hire["NAME"] != "":
			hire["NAME"] += " "
		hire["NAME"] += Data.names.middle.pick_random()
	if randi_range(0,5) != 0:
		if hire["NAME"] != "":
			hire["NAME"] += " "
		hire["NAME"] += Data.names.last.pick_random()
	var genderrand = randi_range(0,100)
	if genderrand > 50:
		hire["GENDER"] = "Female"
	if genderrand < 50:
		hire["GENDER"] = "Male"
	if genderrand == 0:
		hire["GENDER"] = "Apache"
	if genderrand == 50:
		hire["GENDER"] = "Snowflake"
	if genderrand == 100:
		hire["GENDER"] = "Helicopter"
	if Data.hires.has(hire["NAME"]):
		return {}
	hire["CLASS"] = Data.classes.pick_random()
	Data.hires[hire["NAME"]] = hire
	Data.write("hires")
	return hire


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
	Data.write("hired")
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
