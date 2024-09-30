extends Control

var inventorySize = 80
var slotscene = preload("res://slot.tscn")
var itemscene = preload("res://item.tscn")
var isize

func _ready() -> void:
	show()
	call_deferred("_initialize_inventory")

func auto_add(item: Dictionary):
	if Data.db.select_rows(name,"name = "+item.name+"and attribute = "+item.attribute,["id"])[0]:
		pass
	add(Data.db.select_rows(name,"name != null",["id"])[0], item)
	
func add(slot: int, item: Dictionary) -> bool:
	if !Data.inventory.get(name)[slot].has("Type"):
		Data.inventory.get(name)[slot] = item
		add_item_node(slot,item)
		return true

	if Data.inventory.get(name)[slot].Type != item.Type:
		return false
		
	Data.inventory.get(name)[slot].Count += item.Count
	get_node(str(slot)).get_child(0).count(Data.inventory.get(name)[slot].Count)
	return true
	
func remove(slot: int, item: Dictionary) -> bool:
	if !Data.inventory.get(name)[slot].has("Type"):
		return false
	
	if (Data.inventory.get(name)[slot].Type != item.Type ||
		item.Count && Data.inventory.get(name)[slot].Count < item.Count):
			return false

	if Data.inventory.get(name)[slot].Count == item.Count:
		Data.inventory.get(name)[slot] = {}
		get_node(str(slot)).get_child(0).call_deferred("queue_free")
		return true
	
	Data.inventory.get(name)[slot].Count -= item.Count
	get_node(str(slot)).get_child(0).count(Data.inventory.get(name)[slot].Count)
	return true


func add_item_node(slot:int ,item: Dictionary):
	var iteminstance = itemscene.instantiate()
	iteminstance.name = Data.join(item.Type)
	iteminstance.item = item
	iteminstance.texture = Data.textures.get(item.attribute+item.name)
	iteminstance.self_modulate = Color(item.hex)
	iteminstance.count(item.Count)
	iteminstance.tooltip_text = Data.join(item.Type)
	get_node(str(slot)).add_child(iteminstance)
	
func _initialize_inventory() -> void:
	var scaleslot = 1
	if name == "Item":
		scaleslot = 2
	if name == "Alchemy":
		inventorySize = 9
	for i in range(1, int(round(float(inventorySize) / scaleslot / scaleslot)) + 1):
		if name != "Alchemy":
			var slotinstance = slotscene.instantiate()
			slotinstance.name = str(i)
			slotinstance.scale = Vector2(scaleslot,scaleslot)
			add_child(slotinstance)
	for item in Data.db.select_rows(name,"",["*"]):
		add_item_node(item.id,item)
