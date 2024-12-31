extends Node2D

# Array to hold the flag points
@export var flag_points: Array[Node2D]

func _ready():
	if flag_points.size() > 0:
		var random_index = randi() % flag_points.size()
		var random_flag_point = flag_points[random_index]
		position = random_flag_point.position
