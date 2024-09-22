extends ItemList

@export var stats := {
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
	var hires = []
	if randi_range(0,100) == 0:
		hire = new_hire()
	if Data.hires.keys().size():
		hire = Data.hires[Data.hires.keys().pick_random()]
	if hires.has(hire["NAME"]):
		return
	if !hire:
		hire = new_hire()
	hires.append(hire["NAME"])
	add_item(hire["NAME"])


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
	if Data.hires.has(hire["NAME"]):
		return {}
	hire["CLASS"] = Data.classes.pick_random()
	Data.hires[hire["NAME"]] = hire
	Data.write("hires")
	return hire


func _on_hire_pressed(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return
	if event.button_index == MOUSE_BUTTON_LEFT:
		if !Data.party:
			return
		Data.hired[Data.party].append(get_item_text(get_selected_items()[0]))
	if event.button_index == MOUSE_BUTTON_RIGHT:
		Data.hired.Reserve.append(get_item_text(get_selected_items()[0]))
	Data.write("hired")
	remove_item(get_selected_items()[0])
	%"Reserves/Hired"._ready()


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
