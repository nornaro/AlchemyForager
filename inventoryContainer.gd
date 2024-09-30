extends TabContainer


# Called when the node enters the scene tree for the first time.
func shownode(nodename: String) -> void:
	if get_node_or_null(nodename):
		get_node_or_null(nodename).show()
	
