extends Button


	#"Sickle": {
		#"type": "Item",
		#"hex": "#FFFFFF",
		#"use": "Indestructible, legendary weapons and armor"
	#},

func _on_pressed() -> void:
	%Inventory.get_node("Item").auto_add({"Type":["","Sickle",""],"Count":null,"Modifiers":[]})
	pass # Replace with function body.
