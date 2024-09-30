extends ItemList

var partyButton = preload("res://PartyButton.png")
var addParty = preload("res://AddParty.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_item_tooltip(1,"First level is free")
	#self.item
	pass # Repl ace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_item_selected(index: int) -> void:
	%Members.show_party("Party"+str(index))


func _on_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if !is_item_selectable(index):
		set_item_disabled(index+1,false)
		set_item_icon(index,partyButton)
		set_item_icon(index+1,addParty)
		set_item_selectable(index,true)
		set_item_tooltip(index+1,"Next level: "+str(Data.db.select_rows("Party","id ="+str(index+1),["price"])[0].price)+"z")
		
