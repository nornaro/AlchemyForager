extends Button

var party_count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for party in Data.hired.keys():
		if party == "Reserve":
			continue
		print(party)
		%Parties.get_node(party).show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	var cost = pow(100,party_count)
	party_count += 1
	if party_count == 6:
		hide()
	if Data.Zeny >= cost:
		Data.Zeny -= cost
		Data.hired["Party"+str(party_count)] = []
		get_node("../Party"+str(party_count)).show()
		tooltip_text = "Cost: " + str(pow(100,party_count)) + "z"


func _on_button_3_pressed() -> void:
	$Sprite2D.visible = !$Sprite2D.visible
	pass # Replace with function body.


func _on_button_4_pressed() -> void:
	$Sprite2D.visible = !$Sprite2D.visible
	pass # Replace with function body.
