extends Control

@onready var user_name = $User/UserName
@onready var user_opinion = $User/UserOpinion  # Corregido error tipográfico
@onready var user_pic = $User/UserPic

# Export variables
@export var good_opinions = ["¡Me encantó!", "Una obra maestra.", "Increíblemente creativo."]
@export var bad_opinions = ["No es de mi agrado.", "Le falta algo.", "Demasiado simple."]
@export var random_names = ["Alex", "Jordan", "Taylor", "Morgan", "Casey", "Riley"]
@export var user_pic_folder = "res://assets/sprites/User pfps/"  # Ruta de la carpeta de imágenes

# Umbral de crítica único para cada crítico (exigencia)
var unique_threshold: int = 0

func _ready():
	# Asigna un umbral único de exigencia al inicializar el crítico
	unique_threshold = randi() % 101  # Entre 0 y 100
	print("El umbral de exigencia del crítico es:", unique_threshold)

	# Verificar que los nodos están correctamente configurados
	if user_name == null or user_opinion == null or user_pic == null:
		print("Error: Algún nodo está mal configurado.")
		print_tree()  # Muestra la estructura del árbol para depuración
		return

func set_critic_data(global_score: int, threshold: int, likes_higher: bool):
	"""
	Configura los datos únicos del crítico, incluyendo su nombre, opinión y avatar.
	"""
	unique_threshold = threshold

	if user_name != null:
		user_name.text = random_names[randi() % random_names.size()]
	else:
		print("Error: 'user_name' es null.")

	if user_opinion != null:
		var is_good = (global_score >= unique_threshold) if likes_higher else (global_score <= unique_threshold)
		user_opinion.text = good_opinions[randi() % good_opinions.size()] if is_good else bad_opinions[randi() % bad_opinions.size()]

		# Modifica la reputación global dependiendo de la opinión del crítico
		if is_good:
			GlobalData.G_Reputation += randi_range(3, 10)  # Incrementa ligeramente la reputación
		else:
			GlobalData.G_Reputation -= randi_range(3, 10)  # Reduce ligeramente la reputación
	else:
		print("Error: 'user_opinion' es null.")

	set_random_user_pic()

	print("Crítico:", user_name.text if user_name != null else "N/A", 
		  "Umbral:", unique_threshold, 
		  "Opinión:", user_opinion.text if user_opinion != null else "N/A", 
		  "GlobalScore:", global_score, 
		  "LikesHigher:", likes_higher)

func set_random_user_pic():
	"""
	Selecciona una imagen aleatoria del directorio especificado y la asigna al nodo `user_pic`.
	"""
	var image_files = []
	var index = 1
	while true:
		var image_path = "%sico_%d.png" % [user_pic_folder, index]
		if not FileAccess.file_exists(image_path):
			break
		image_files.append(image_path)
		index += 1

	if image_files.size() == 0:
		print("Error: No se encontraron imágenes en la carpeta", user_pic_folder)
		return

	var random_image = image_files[randi() % image_files.size()]
	var texture = load(random_image)
	if texture != null and user_pic != null:
		user_pic.texture = texture
	else:
		print("Error: No se pudo cargar la imagen o 'user_pic' es null.")
