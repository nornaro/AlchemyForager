extends Control

var scene = preload("res://Scenes/member.tscn")
var Priest = preload("res://Priest.png")
var Archer = preload("res://Archer.png")
var Fighter = preload("res://Fighter.png")
var Mage = preload("res://Mage.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for member in Data.db.select_rows("Adventurer","party != 'Dead' AND party != 'Reserve' AND party != 'free'",["party","name","class"]):
		var instance = scene.instantiate()
		instance.name = member.name
		instance.tooltip_text = member.name
		instance.icon = get(member.class)
		get_node(member.party).add_child(instance)

func show_party(party) -> void:
	get_tree().call_group("Members","hide")
	get_node(party).show()
	Data.party = party
