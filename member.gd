extends Button

@export var stats := {
	"DEAD": false,
	"GENDER": "",
	"NAME": "",
	"CLASS": "",
	"EXP": "",
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


func _on_pressed() -> void:
	get_tree().call_group("Gear","hire",name)
