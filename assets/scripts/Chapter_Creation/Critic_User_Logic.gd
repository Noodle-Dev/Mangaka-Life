extends Control

@onready var user_name = $User/UserName
@onready var user_opinion = $User/UserOpiniion
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

	# Verificar la estructura de nodos
	if user_name == null or user_opinion == null or user_pic == null:
		print("Error: Los nodos 'user_name', 'user_opinion' o 'user_pic' no están configurados.")
		print_tree()  # Imprime la estructura de nodos para depuración
		return

	# Llamar a la función para inicializar datos del crítico
	set_critic_data()

func set_critic_data(global_score: int = 0):
	"""
	Asigna datos únicos al crítico, como nombre, opinión y avatar.
	El parámetro `global_score` determina la calidad del contenido (por ejemplo, `GlobalData.G_FinalScore`).
	"""
	if user_name == null or user_opinion == null or user_pic == null:
		print("Error: Los nodos 'user_name', 'user_opinion' o 'user_pic' no están configurados.")
		return

	# Asigna un nombre aleatorio
	user_name.text = random_names[randi() % random_names.size()]

	# Determina la opinión del crítico comparando su umbral único con el puntaje global
	var is_good = global_score >= unique_threshold
	user_opinion.text = good_opinions[randi() % good_opinions.size()] if is_good else bad_opinions[randi() % bad_opinions.size()]

	# Modifica la reputación global dependiendo de la opinión del crítico
	if is_good:
		GlobalData.G_Reputation += randi_range(3, 10)  # Incrementa ligeramente la reputación
	else:
		GlobalData.G_Reputation -= randi_range(3, 10)  # Reduce ligeramente la reputación

	# Asigna una imagen aleatoria al crítico
	set_random_user_pic()

	# Depuración: Imprime la información del crítico
	print("Crítico:", user_name.text, "Umbral:", unique_threshold, "Opinión:", user_opinion.text, "GlobalScore:", global_score)

func set_random_user_pic():
	"""
	Selecciona una imagen aleatoria del directorio especificado y la asigna al nodo `user_pic`.
	"""
	# Genera la lista de nombres de imágenes en formato `ico_X`
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

	# Escoge una imagen aleatoria y la asigna al TextureRect
	var random_image = image_files[randi() % image_files.size()]
	var texture = load(random_image)
	if texture != null:
		user_pic.texture = texture
	else:
		print("Error: No se pudo cargar la imagen", random_image)
