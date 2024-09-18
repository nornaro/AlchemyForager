extends HBoxContainer

var scene = preload("res://member.tscn")
var Priest = preload("res://Priest.png")
var Archer = preload("res://Archer.png")
var Fighter = preload("res://Fighter.png")
var Mage = preload("res://Mage.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for key in Data.hired.keys():
		if key == "Reserve":
			continue
		if key == "Add":
			continue
		var members = Data.hired.get(key)
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
			get_node(key+"/Members").add_child(instance)
			
			get_node(key+"/Members").move_child(get_child(1),0)
			if get_node(key+"/Members").get_child_count() == 7:
				get_node(key+"/Members/Add").hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
