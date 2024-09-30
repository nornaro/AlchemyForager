extends Control

var inventorySize = 80
var slotscene = preload("res://Scenes/slot.tscn")
var itemscene = preload("res://Scenes/item.tscn")
var isize

func _ready() -> void:
	print("asd")
	show()
	call_deferred("_initialize_inventory")


func _initialize_inventory() -> void:
	var scaleslot = 1
	if name == "Alchemy":
		inventorySize = 8
	if name == "Items":
		scaleslot = 2
	for i in range(1, inventorySize / scaleslot/scaleslot + 1):
		if name != "Alchemy":
			var slotinstance = slotscene.instantiate()
			slotinstance.name = str(i)
			slotinstance.scale = Vector2(scaleslot,scaleslot)
			add_child(slotinstance)
		if Data.inventory.get(name)[i].has("Type"):
			var iteminstance = itemscene.instantiate()
			iteminstance.name = Data.join(Data.inventory.get(name)[i].Type)
			iteminstance.texture = Data.textures.get(Data.inventory.get(name)[i].Type[0]+name)
			iteminstance.self_modulate = Color(Data.material.get(Data.inventory.get(name)[i].Type[1]).hex)
			get_node(str(i)).add_child(iteminstance)
