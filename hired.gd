extends ItemList

var idx: int
var adventurer_name: String
@export var pixel:CompressedTexture2D = preload("res://pixel.png")

# Called when the node enters the scene tree for the first time.
func _ready(_dummy:bool = true) -> void:
	clear()
	var data:Array = Data.db.select_rows("Adventurer","party != 'free'",["name","party"])
	for hire in data:
		match hire["party"]:
			"Dead":
				if %DeadCB.button_pressed:
					add(hire.name,Color.DARK_RED)
				continue
			"Reserve":
				if %ReserveVB.button_pressed:
					add(hire.name,Color.DARK_GREEN)
				continue
		if %PartyCB.button_pressed:
			add(hire.name,Color.YELLOW)
			
func add(n:String,c:Color) -> void:
		var i:int = add_item(n)
		set_item_icon(i,pixel)
		set_item_icon_modulate(i,c)


func _on_item_selected(index: int) -> void:
	idx = index
	adventurer_name = get_item_text(index)
	get_tree().call_group("Gear","hire",adventurer_name)


func _on_add_pressed() -> void:
	if !Data.party:
		return
	
	for item in get_selected_items():
		var adventurer = get_item_text(item)
		if Data.db.select_rows("Adventurer","party ='"+Data.party+"'",["id"]).size() >= 5:
			return
		remove_item(item)
		if !Data.db.select_rows("Adventurer","name ='"+adventurer+"'",[""]).is_empty():
			return
		Data.db.update_rows("Adventurer","name = '"+adventurer+"'",{"party": Data.party})
		add_member(adventurer)


func _on_fire_pressed() -> void:
	for item in get_selected_items():
		var adventurer = get_item_text(item)
		remove_item(item)
		Data.db.update_rows("Adventurer","name ='"+adventurer+"'",{"party":"free"})
		%Hires.add_item(adventurer)
	

func add_member(hirename) -> void:
	var scene = load("res://Scenes/member.tscn")
	var instance = scene.instantiate()
	instance.name = hirename
	instance.tooltip_text = hirename
	instance.icon = load("res://"+Data.db.select_rows("Adventurer","name ='"+hirename+"'",["class"])[0].class+".png")
	%Members.get_node(str(Data.party)).add_child(instance)
