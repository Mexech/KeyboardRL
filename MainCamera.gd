extends Camera2D

func _ready():
	pass # Replace with function body.


func _process(delta):
	global_position.x = get_parent().global_position.x
	global_position.y = get_parent().global_position.y
