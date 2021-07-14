extends Camera2D

onready var player = get_node('../Player')

func _ready():
	pass # Replace with function body.


func _process(delta):
	position.x = player.position.x
