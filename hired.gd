extends ItemList

var idx: int
var txt: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear()
	for hire in Data.hired.Reserve:
		add_item(hire)


func _on_item_selected(index: int) -> void:
	idx = index
	txt = get_item_text(index)


func _on_add_pressed() -> void:
	if !Data.party:
		return
	remove_item(idx)
	Data.hired.Reserve.erase(txt)
	Data.hired[Data.party].append(txt)
	add_member(txt)
	Data.write("hired")


func _on_terminate_pressed() -> void:
	remove_item(idx)
	Data.hired.Reserve.erase(txt)
	Data.write("hired")

func add_member(hirename) -> void:
	var scene = load("res://member.tscn")
	var instance = scene.instantiate()
	instance.name = hirename
	instance.tooltip_text = hirename
	instance.icon = load("res://"+Data.hires[hirename]["CLASS"]+".png")
	%Parties.get_node(Data.party+"/Members").add_child(instance)
