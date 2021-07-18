extends KinematicBody2D

export (int) var speed = 200
var velocity = Vector2()

func get_inputs():
	velocity = Vector2()
	for slot in get_tree().get_nodes_in_group("slots"):
		match slot.action:
			"move_up":
				velocity.y -= int(Input.is_key_pressed(slot.scancode))
			"move_down":
				velocity.y += int(Input.is_key_pressed(slot.scancode))
			"move_left":
				velocity.x -= int(Input.is_key_pressed(slot.scancode))
			"move_right":
				velocity.x += int(Input.is_key_pressed(slot.scancode))
	velocity = velocity.normalized() * speed


func _physics_process(delta):
	get_inputs()
	velocity = move_and_slide(velocity)


func _on_Area2D_area_entered(area):
	var key = area.owner
	if $"/root/World".has_node(key.name):
		var keyPos = key.get_child(0).global_position
		var rest_nodes = get_tree().get_nodes_in_group("free_slots")
		var nearest_rest_node = rest_nodes[0]
		var nearest_pos = nearest_rest_node.get_child(0).global_position
		for rest in rest_nodes:
			var pos = rest.get_child(0).global_position
			if keyPos.distance_to(pos) <= keyPos.distance_to(nearest_pos):
				nearest_rest_node = rest
		nearest_rest_node.remove_from_group("free_slots")
		$"/root/World".remove_child(key)
		nearest_rest_node.add_child(key)
