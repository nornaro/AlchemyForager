extends GridContainer

var inventory := {}
var inventorySizeX := 8
var inventorySizeY := 8
var slotscene = preload("res://slot.tscn")
var isize

func _ready() -> void:
	show()
	call_deferred("_initialize_inventory")


func _initialize_inventory() -> void:
	for x in range(1, inventorySizeX + 1):
		for y in range(1, inventorySizeY + 1):
			var instance = slotscene.instantiate()
			instance.name = str(x,y)
			add_child(instance)
			inventory[str(x) + str(y)] = {
				"slot": instance,
				"item": null, 
				"quantity": 0
			}
