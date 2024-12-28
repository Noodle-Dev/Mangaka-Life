extends Node2D

const OBSTACLE_SCENE = preload("res://assets/prefabs/Character_Creation_Prefabs/obstacle_prefab.tscn")
var spawn_points = []
var spawn_interval = 1.0 # Adjust this value to control the frequency of spawning
var time_since_last_spawn = 0.0

func _ready():
	# Initialize random number generator
	randomize()
	# Get the spawn points from the scene
	spawn_points.append($Obs_1)
	spawn_points.append($Obs_2)
	spawn_points.append($Obs_3)
	# Add more spawn points if needed to further increase difficulty
	# spawn_points.append($Obs_4)
	# spawn_points.append($Obs_5)

func _physics_process(delta):
	time_since_last_spawn += delta
	if time_since_last_spawn >= spawn_interval:
		time_since_last_spawn = 0
		spawn_obstacle()

func spawn_obstacle():
	var num_obstacles = randi() % 2 + 1  # Randomly decide to spawn 1 or 2 obstacles
	var used_indices = []  # To track spawn points already used in this spawn cycle
	
	for i in num_obstacles:
		var index = randi() % spawn_points.size()
		
		# Ensure we don't reuse a spawn point
		while index in used_indices:
			index = randi() % spawn_points.size()
		
		used_indices.append(index)
		var spawn_position = spawn_points[index].position
		
		var obstacle_instance = OBSTACLE_SCENE.instantiate()
		obstacle_instance.position = spawn_position
		add_child(obstacle_instance)
