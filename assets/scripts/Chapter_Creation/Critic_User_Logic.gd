extends Control

@onready var user_name = $User/UserName
@onready var user_opinion = $User/UserOpinion
@onready var user_pic = $User/UserPic

# Export variables
@export var good_opinions = ["¡Me encantó!", "Una obra maestra.", "Increíblemente creativo."]
@export var bad_opinions = ["No es de mi agrado.", "Le falta algo.", "Demasiado simple."]
@export var random_names = ["Alex", "Jordan", "Taylor", "Morgan", "Casey", "Riley"]
@export var user_pic_folder = "res://assets/sprites/User pfps/"  # Ruta de la carpeta de imágenes

func set_critic_data(global_score: int, threshold: int, likes_higher: bool):
	"""
	Configura los datos del crítico: nombre, opinión y avatar.
	"""
	# Asignar un nombre aleatorio
	if user_name != null:
		user_name.text = random_names[randi() % random_names.size()]
	else:
		print("Error: Nodo 'user_name' no encontrado.")

	# Determinar la opinión del crítico
	if user_opinion != null:
		var is_good = (global_score >= threshold) if likes_higher else (global_score <= threshold)
		user_opinion.text = good_opinions[randi() % good_opinions.size()] if is_good else bad_opinions[randi() % bad_opinions.size()]
	else:
		print("Error: Nodo 'user_opinion' no encontrado.")

	# Asignar una imagen aleatoria
	set_random_user_pic()

func set_random_user_pic():
	"""
	Selecciona una imagen aleatoria con el formato 'ico_#.png' y la asigna al nodo `user_pic`.
	"""
	var image_files = []
	var index = 1

	# Buscar todas las imágenes siguiendo el formato en el directorio especificado
	while true:
		var image_path = "%sico_%d.png" % [user_pic_folder, index]
		if not FileAccess.file_exists(image_path):
			break
		image_files.append(image_path)
		index += 1

	# Validar que haya imágenes disponibles
	if image_files.size() == 0:
		print("Error: No se encontraron imágenes en la carpeta:", user_pic_folder)
		return

	# Cargar una imagen aleatoria
	var random_image = image_files[randi() % image_files.size()]
	var texture = load(random_image)
	if texture != null and user_pic != null:
		user_pic.texture = texture
	else:
		print("Error: No se pudo asignar la imagen o 'user_pic' es null.")
