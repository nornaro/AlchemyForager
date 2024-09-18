extends Node

@export var material = []
@export var names = {
	"first":[],
	"middle":[],
	"last":[]
	}
@export var Zeny = 10000000000000
@export var hires = {}
@export var hired = {}
@export var levels = {}
@export var classes = ["Fighter", "Archer", "Mage", "Priest"]
@export var party = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open("res://materials.json", FileAccess.READ)
	var json_text = file.get_as_text()
	file.close()
	material = JSON.parse_string(json_text)
	
	file = FileAccess.open("res://names.json", FileAccess.READ)
	json_text = file.get_as_text()
	file.close()
	names = JSON.parse_string(json_text)
	
	file = FileAccess.open("res://hires.json", FileAccess.READ)
	json_text = file.get_as_text()
	file.close()
	hires = JSON.parse_string(json_text)
	
	file = FileAccess.open("res://hired.json", FileAccess.READ)
	json_text = file.get_as_text()
	file.close()
	hired = JSON.parse_string(json_text)
		
	return

func write(name) -> void:
	var file = FileAccess.open("res://"+name+".json", FileAccess.WRITE)
	var json_string = JSON.stringify(get(name), "\t", true)
	file.store_string(json_string)
	file.close()
