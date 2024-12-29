extends Control

# Asignación de nodos
@onready var user_name = $User/UserName  # Label
@onready var user_opinion = $User/UserOpinion  # RichTextLabel
@onready var user_pic = $User/UserPic  # TextureRect

# Variables exportadas
@export var good_opinions = ["¡Me encantó!", "Una obra maestra.", "Increíblemente creativo."]
@export var bad_opinions = ["No es de mi agrado.", "Le falta algo.", "Demasiado simple."]
@export var random_names = ["Alex", "Jordan", "Taylor", "Morgan", "Casey", "Riley"]
@export var user_pic_folder = "res://assets/sprites/User pfps/"  # Ruta de la carpeta de imágenes

# Umbral único del crítico
var unique_threshold: int = 0

func _ready():
	# Depuración para verificar nodos
	print_tree()  # Imprime la estructura completa del árbol para confirmar las rutas
	if user_name == null:
		print("Error: 'user_name' es null. Verifica la ruta o el nodo.")
	if user_opinion == null:
		print("Error: 'user_opinion' es null. Verifica la ruta o el nodo.")
	if user_pic == null:
		print("Error: 'user_pic' es null. Verifica la ruta o el nodo.")

	# Generar un umbral único aleatorio
	unique_threshold = randi() % 101

func set_critic_data(global_score: int, threshold: int, likes_higher: bool):
	unique_threshold = threshold

	# Asignar nombre
	if user_name != null:
		user_name.text = random_names[randi() % random_names.size()]
	else:
		print("Error: 'user_name' es null. No se pudo asignar un nombre.")

	# Asignar opinión
	if user_opinion != null:
		var is_good = (global_score >= unique_threshold) if likes_higher else (global_score <= unique_threshold)
		user_opinion.clear()
		user_opinion.add_text(
			good_opinions[randi() % good_opinions.size()] if is_good else bad_opinions[randi() % bad_opinions.size()]
		)

		# Modificar el balance global en función de la opinión
		if is_good:
			get_tree().call_group("Menu_grub", "adjust_balance", 300)
		else:
			get_tree().call_group("Menu_grub", "adjust_balance", -100)
	else:
		print("Error: 'user_opinion' es null. No se pudo asignar una opinión.")

	# Asignar imagen
	set_random_user_pic()

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
		print("Error: No se encontraron imágenes en la carpeta:", user_pic_folder)
		return

	var random_image = image_files[randi() % image_files.size()]
	var texture = load(random_image)
	if texture != null and user_pic != null:
		user_pic.texture = texture
		print("Imagen asignada:", random_image)
	else:
		print("Error: No se pudo asignar la imagen o 'user_pic' es null.")
