extends Position2D

#export var selected := false

func select():
	for child in get_tree().get_nodes_in_group("free_slots"):
		child.get_child(0).deselect()
#	selected = true

func deselect():
	pass
#	selected = false
