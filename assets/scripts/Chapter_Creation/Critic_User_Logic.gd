extends Control

@onready var user_name = $User/UserName
@onready var user_opinion = $User/UserOpiniion  # Nombre corregido
@onready var user_pic = $User/UserPic
@onready var uniqueOpinion

@export var good_opinions = ["¡Me encantó!", "Una obra maestra.", "Increíblemente creativo."]
@export var bad_opinions = ["No es de mi agrado.", "Le falta algo.", "Demasiado simple."]
@export var random_names = ["Alex", "Jordan", "Taylor", "Morgan", "Casey", "Riley"]
@export var user_pic_folder = "res://assets/sprites/User pfps/"  # Ruta de la carpeta de imágenes

func _ready():
	uniqueOpinion = randi_range(0, 100)
	print("my opinion is ", uniqueOpinion)
	# Verificar si los nodos existen
	if user_name == null or user_opinion == null or user_pic == null:
		print("Error: Los nodos 'user_name', 'user_opinion' o 'user_pic' no están configurados en esta instancia.")
		print_tree()  # Imprime la estructura de nodos para depuración
		return

	# Llamar a la función para establecer datos de prueba al cargar la escena
	set_critic_data()

func set_critic_data():
	# Verificar si los nodos existen antes de asignar datos
	if user_name == null or user_opinion == null or user_pic == null:
		print("Error: Los nodos 'user_name', 'user_opinion' o 'user_pic' no están configurados.")
		return

	# Asigna un nombre aleatorio
	user_name.text = random_names[randi() % random_names.size()]

	# Genera un puntaje aleatorio para el crítico
	var critic_score = randi() % 101  # Puntaje aleatorio entre 0 y 100

	# Determina si la opinión será buena o mala
	var is_good = critic_score >= GlobalData.G_FinalScore
	user_opinion.text = good_opinions[randi() % good_opinions.size()] if is_good else bad_opinions[randi() % bad_opinions.size()]
	if is_good:
		GlobalData.G_Reputation + randi_range(3, 100)
	else:
		GlobalData.G_Reputation - randi_range(3, 100)
	# Asigna una imagen aleatoria
	set_random_user_pic()
	print(GlobalData.G_Reputation)

	# Depuración: Imprime el puntaje del crítico y su opinión
	print("Crítico:", user_name.text, "Puntaje:", critic_score, "Opinión:", user_opinion.text)

func set_random_user_pic():
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
