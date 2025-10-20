extends ItemList

var partyButton = preload("res://PartyButton.png")
var addParty = preload("res://AddParty.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_item_tooltip(1,"First level is free")
	var active:Array = Data.db.select_rows("Party","active = 1", ["id"])
	for item:Dictionary in active:
		_on_item_clicked(item["id"])
		
func _on_item_selected(index: int) -> void:
	%Members.show_party("Party"+str(index))


func _on_item_clicked(index: int, _at_position: Vector2 = Vector2.ZERO, _mouse_button_index: int = 0) -> void:
	if !is_item_selectable(index):
		set_item_disabled(index+1,false)
		set_item_icon(index,partyButton)
		set_item_icon(index+1,addParty)
		set_item_selectable(index,true)
		set_item_tooltip(index+1,"Next level: "+str(Data.db.select_rows("Party","id ="+str(index+1),["price"])[0].price)+"z")
		
