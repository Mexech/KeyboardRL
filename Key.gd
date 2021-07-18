extends Node2D

export var scancode: int
export var slot_candidate_path: NodePath
export var selected: bool

var rest_nodes = []
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	scancode = rng.randi_range(65, 90)
	$Panel/Label.text = OS.get_scancode_string(scancode)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true

func _physics_process(delta):
	if get_parent().name.match("Slot*"):
		if selected:
			position = lerp(position, get_parent().get_local_mouse_position(), 25 * delta)
		else:
			position = lerp(position, $"../Position2D".position, 10 * delta)

func _input(event):
	if event is InputEventMouseButton:
		print(get_parent().name)
		if event.button_index == BUTTON_LEFT and not event.pressed and slot_candidate_path:
			selected = false
			var slot_candidate = get_node(slot_candidate_path)
			var slot_pos = slot_candidate.get_child(0)
			if global_position.distance_to(slot_pos.global_position) < 100:
				var parent = get_parent()
				if slot_candidate in get_tree().get_nodes_in_group("free_slots"):
					parent.add_to_group("free_slots")
					parent.scancode = 0
					parent.remove_child(self)
					slot_candidate.remove_from_group("free_slots")
					slot_candidate.add_child(self)
					slot_candidate.key_path = get_path()
					position = to_local(global_position) + slot_pos.position
				else:
					var other_key = get_node(slot_candidate.key_path)
					parent.remove_child(self)
					slot_candidate.remove_child(other_key)
					parent.add_child(other_key)
					slot_candidate.add_child(self)
				
#			rest_nodes = get_tree().get_nodes_in_group("slot")
#			var nearest_rest_node = rest_nodes[0]
#			for rest in rest_nodes:
#				var pos = rest.get_child(0)
#				if global_position.distance_to(pos.global_position) <= global_position.distance_to(nearest_rest_node.get_child(0).global_position):
#					nearest_rest_node = rest
#			rest_node = nearest_rest_node
#			nearest_rest_node.get_child(0).select()
##			var shortest_dist = 75
##			for child in rest_nodes:
##				var pos = child.get_child(0)
##				var dist = global_position.distance_to(pos.global_position)
##				if dist < shortest_dist:
##					pos.select()
##					rest_node.get_child(0).global_position = pos.global_position
##					shortest_dist = dist
