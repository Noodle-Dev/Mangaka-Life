extends Control

# Asignación de nodos
@onready var user_name = $User/UserName  # Label
@onready var user_opinion = $User/UserOpinion  # RichTextLabel
@onready var user_pic = $User/UserPic  # TextureRect

# Variables exportadas
@onready var good_opinions = GlobalData.G_good_opinions
@onready var bad_opinions = GlobalData.G_bad_opinions
@onready var random_names = GlobalData.G_random_names 
@export var user_pic_folder = "res://assets/sprites/User pfps/"  # Ruta de la carpeta de imágenes

# Umbral único del crítico
var unique_threshold: int = 0

func _ready():
	get_tree().call_group("menu_grub", "update_status")
	# Depuración para verificar nodos
	print_tree()  # Imprime la estructura completa del árbol para confirmar las rutas
	if user_name == null:
		print("Error: 'user_name' es null. Verifica la ruta o el nodo.")
	if user_opinion == null:
		print("Error: 'user_opinion' es null. Verifica la ruta o el nodo.")
	if user_pic == null:
		print("Error: 'user_pic' es null. Verifica la ruta o el nodo.")

	# Asignar un nombre aleatorio
	assign_random_user_name()

	# Asignar una imagen de perfil aleatoria
	set_random_user_pic()

	# Asignar una opinión inicial aleatoria (buena o mala)
	assign_random_opinion()

	# Generar un umbral único aleatorio
	unique_threshold = randi() % 101

func assign_random_user_name():
	"""
	Asigna un nombre aleatorio al usuario.
	"""
	if user_name != null:
		user_name.text = random_names[randi() % random_names.size()]
		print("Nombre asignado:", user_name.text)
	else:
		print("Error: 'user_name' es null. No se pudo asignar un nombre.")

func assign_random_opinion():
	"""
	Asigna una opinión inicial aleatoria (buena o mala) al usuario.
	Si la opinión es buena, añade un número aleatorio entre 50 y 100 al balance global con una probabilidad del 50%.
	"""
	if user_opinion != null:
		var is_good = randf() < 0.5  # 50% de probabilidad de ser buena o mala
		user_opinion.clear()
		var opinion_text = ""
		
		# Asignar la opinión dependiendo si es buena o mala
		if is_good:
			opinion_text = good_opinions[randi() % good_opinions.size()]
		else:
			GlobalData.G_FinalScore -= randi() % 101 + 100
			opinion_text = bad_opinions[randi() % bad_opinions.size()]

		user_opinion.add_text(opinion_text)
		print("Opinión asignada:", user_opinion.text)

		# Si la opinión es buena, con un 50% de probabilidad, añadimos un valor aleatorio entre 50 y 100 al balance
		if is_good and randf() < 0.5:  # 50% de probabilidad
			var bonus = randi() % 101 + 100  # Número aleatorio entre 50 y 100
			GlobalData.G_Balance += bonus
			GlobalData.G_FinalScore += bonus
			print("Se ha añadido ", bonus, " al balance global. Nuevo balance: ", GlobalData.G_Balance)
	else:
		print("Error: 'user_opinion' es null. No se pudo asignar una opinión.")

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
