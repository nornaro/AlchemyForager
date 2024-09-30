extends ItemList

var idx: int
var adventurer_name: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear()
	for hire in Data.db.select_rows("Adventurer","party != 'Dead' AND party != 'Reserve' AND party != 'free'",["name"]):
		add_item(hire.name)


func _on_item_selected(index: int) -> void:
	idx = index
	adventurer_name = get_item_text(index)
	get_tree().call_group("Gear","hire",adventurer_name)


func _on_add_pressed() -> void:
	if !Data.party:
		return
	if Data.db.select_rows("Adventurer","party ='"+Data.party+"'",["id"]).size() >= 5:
		return
	remove_item(idx)
	Data.db.update_rows("Adventurer","name = '"+adventurer_name+"'",{"party": Data.party})
	add_member(adventurer_name)


func _on_terminate_pressed() -> void:
	remove_item(idx)
	Data.db.update_rows("Adventurer","name ='"+adventurer_name+"'",{"party":"free"})

func add_member(hirename) -> void:
	var scene = load("res://Scenes/member.tscn")
	var instance = scene.instantiate()
	instance.name = hirename
	instance.tooltip_text = hirename
	instance.icon = load("res://"+Data.db.select_rows("Adventurer","name ='"+adventurer_name+"'",["class"])[0].class+".png")
	%Members.get_node(str(Data.party)).add_child(instance)
