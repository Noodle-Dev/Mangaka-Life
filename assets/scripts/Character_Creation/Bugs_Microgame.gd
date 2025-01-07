extends Node2D

@export var object_scenes: Array[PackedScene]  # Asigna tus escenas de objetos en el editor
@export var spawn_point_nodes: Array[Node2D]  # Asigna tus nodos de puntos de generación en el editor
var spawned_objects: Array[Node2D] = []

func _ready():
	randomize()
	spawn_objects()

func _physics_process(delta):
	check_objects_destroyed()

func spawn_objects():
	var object_count = 5  # ojects to spanw
	for i in range(object_count):
		var random_index = randi() % object_scenes.size()
		var selected_scene = object_scenes[random_index]
		var instance = selected_scene.instantiate() as Node2D
		add_child(instance)

		var spawn_point_index = randi() % spawn_point_nodes.size()
		var spawn_point_node = spawn_point_nodes[spawn_point_index]
		instance.position = spawn_point_node.position
		spawned_objects.append(instance)

func check_objects_destroyed():
	for instance in spawned_objects:
		if instance is Node2D and instance.has_method("mark_as_destroyed"):
			if instance.destroyed:  # Verifica si la propiedad "destroyed" es verdadera
				print("A object was destroyed:", instance.name)
				spawned_objects.erase(instance)

	# Verify if obkects where destroyed
	if spawned_objects.size() == 0:
		print("All obj destroyed.")
		get_tree().call_group("charMaker", "end_microgame")
		GlobalData.G_Reputation += 10
		GlobalData.G_FinalScore += 10
		GlobalData.G_Balance += 10
		on_all_objects_destroyed()

func on_all_objects_destroyed():
	pass
