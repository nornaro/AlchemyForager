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
var db: SQLite


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	db = SQLite.new()
	db.path = "res://database.db"
	if FileAccess.file_exists("res://database.db"):
		db.open_db()
	if !FileAccess.file_exists("res://database.db"):
		db.open_db()
		create_db()

	var file = FileAccess.open("res://names.json", FileAccess.READ)
	var json_text = file.get_as_text()
	file.close()
	names = JSON.parse_string(json_text)
	for png in DirAccess.open("res://Textures/").get_files():
		if !png.ends_with(".png"):
			continue
		textures[png.get_basename()] = load("res://Textures/" + str(png))
	
	


	return

func join(arr):
	var result = ""
	for i in range(arr.size()):
		result += arr[i]
		if i < arr.size() - 1:
			if arr[i]:
				result += " "  # Add space between elements
	return result
	
func create_db():
	var party = {
		"id" : {"data_type":"int", "primary_key":true, "not_null":true, "auto_increment":true},
		"active": {"data_type":"int", "not_null":true, "default": 0},
		"price": {"data_type":"int"}
	}
	db.create_table("Party",party)
	db.insert_rows("Party",[{"price": 0},{"price": 10},{"price": 100},{"price": 10000},{"price": 100000000},{"price": 10000000000000000}])

	var item_db = {
		"id" : {"data_type":"int", "primary_key":true, "not_null":true, "auto_increment":true},
		"type": {"data_type":"text", "not_null":true},
		"attribute": {"data_type":"text"},
		"name": {"data_type":"text", "not_null":true},
		"quality": {"data_type":"text", "not_null":true},
		"count": {"data_type":"text"}, #owner if type==Item
		"modifiers": {"data_type":"text"},
		"color": {"data_type":"text", "not_null":true},
	}
	var equip = {
		"id" : {"data_type":"int", "primary_key":true, "not_null":true, "auto_increment":true},
		"type": {"data_type":"text", "not_null":true},
		"attribute": {"data_type":"text"},
		"name": {"data_type":"text", "not_null":true},
		"quality": {"data_type":"text", "not_null":true},
		"owner": {"data_type":"int"}, #owner if type==Item
		"modifiers": {"data_type":"text"},
		"color": {"data_type":"text", "not_null":true},
	}
	var inventory = {
		"id" : {"data_type":"int", "primary_key":true, "not_null":true},
		"type": {"data_type":"text", "not_null":true},
		"attribute": {"data_type":"text"},
		"name": {"data_type":"text", "not_null":true},
		"quality": {"data_type":"text", "not_null":true},
		"count": {"data_type":"int"},
		"modifiers": {"data_type":"text"},
		"color": {"data_type":"text", "not_null":true},
	}
	var adventurer = {
		"id" : {"data_type":"int", "primary_key":true, "not_null":true, "auto_increment":true},
		"name": {"data_type":"text", "unique":true, "not_null":true},
		"class": {"data_type":"text", "not_null":true},
		"party": {"data_type":"text", "not_null":true, "default": 'free'},
		"xp": {"data_type":"int", "not_null":true, "default": 0},
		"gender": {"data_type":"int", "not_null":true},
		"lvl": {"data_type":"int", "not_null":true, "default": 1},
		"comp": {"data_type":"int", "not_null":true, "default": 1},
		"patk": {"data_type":"int", "not_null":true, "default": 1},
		"pdef": {"data_type":"int", "not_null":true, "default": 1},
		"matk": {"data_type":"int", "not_null":true, "default": 1},
		"mdef": {"data_type":"int", "not_null":true, "default": 1},
	}
	db.create_table("Material", item_db)
	db.insert_rows("Material",material)
	db.create_table("Alchemy", inventory)
	db.create_table("Item", inventory)
	db.create_table("Gem", inventory)
	db.create_table("Crystal", inventory)
	db.create_table("Stone", inventory)
	db.create_table("Ore", inventory)
	db.create_table("Inventory", item_db)
	db.create_table("Adventurer", adventurer)
	
func write(filename) -> void:
	var file = FileAccess.open("res://"+filename+".json", FileAccess.WRITE)
	var json_string = JSON.stringify(get(filename), "\t", true)
	file.store_string(json_string)
	file.close()
