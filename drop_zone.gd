extends Position2D

func select():
	for child in get_tree().get_nodes_in_group("zone"):
		child.deselect()
	modulate = Color.webmaroon

func deselect():
	modulate = Color.white
