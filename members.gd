extends Control

var scene = preload("res://member.tscn")
var Priest = preload("res://Priest.png")
var Archer = preload("res://Archer.png")
var Fighter = preload("res://Fighter.png")
var Mage = preload("res://Mage.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for party in Data.hired.keys():
		if party == "Reserve":
			continue
		if party == "Add":
			continue
		var members = Data.hired.get(party)
		if members.size() == 0:
			continue
		for member in members:
			var instance = scene.instantiate()
			instance.name = member
			instance.tooltip_text = member
			match Data.hires[member]["CLASS"]:
				"Priest":
					instance.icon = Priest
				"Archer":
					instance.icon = Archer
				"Fighter":
					instance.icon = Fighter
				"Mage":
					instance.icon = Mage
			get_node(party).add_child(instance)
