extends ColorRect

export var action: String
export var scancode: int
export var key_path: NodePath

func _ready():
	add_to_group("slots")
	add_to_group("free_slots")

func _on_Area2D_area_entered(area):
	var key = area.owner
	key.slot_candidate_path = get_path()
	if key.get_parent() == self:
		scancode = key.scancode
