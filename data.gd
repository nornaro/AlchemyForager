extends Node

@export var material = []
@export var names = {
	"first":[],
	"middle":[],
	"last":[]
	}
@export var Zeny = 10000000000000
var party = ""
var hires = {}
var hired = {}
var levels = {}
var classes = ["Fighter", "Archer", "Mage", "Priest"]
var inventory = {}
var textures = {}
var item = []
var slot = []
var stack = -1
var cursor = preload("res://cursor.png")

func join(arr):
	var result = ""
	for i in range(arr.size()):
		result += arr[i]
		if i < arr.size() - 1:
			if arr[i]:
				result += " "  # Add space between elements
	return result

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

	file = FileAccess.open("res://inventory.json", FileAccess.READ)
	json_text = file.get_as_text()
	file.close()
	inventory = JSON.parse_string(json_text)
		
	for png in DirAccess.open("res://Textures/").get_files():
		if !png.ends_with(".png"):
			continue
		textures[png.get_basename()] = load("res://Textures/" + str(png))

	return

func write(filename) -> void:
	var file = FileAccess.open("res://"+filename+".json", FileAccess.WRITE)
	var json_string = JSON.stringify(get(filename), "\t", true)
	file.store_string(json_string)
	file.close()
