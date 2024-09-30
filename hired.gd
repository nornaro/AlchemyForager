extends ItemList

var idx: int
var txt: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear()
	for hire in Data.db.select_rows("Adventurer","party != 'Dead' AND party != 'Reserve' AND party != 'free'",["name"]):
		add_item(hire.name)


func _on_item_selected(index: int) -> void:
	idx = index
	txt = get_item_text(index)
	get_tree().call_group("Gear","hire",txt)


func _on_add_pressed() -> void:
	if !Data.party:
		return
	if Data.hired[Data.party].size() >= 5:
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
	%Members.get_node(str(Data.party)).add_child(instance)
