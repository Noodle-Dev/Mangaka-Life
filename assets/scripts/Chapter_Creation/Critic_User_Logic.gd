extends Control

@onready var user_name = $User/UserName
@onready var user_opinion = $User/UserOpiniion  # Nombre corregido

@export var good_opinions = ["¡Me encantó!", "Una obra maestra.", "Increíblemente creativo."]
@export var bad_opinions = ["No es de mi agrado.", "Le falta algo.", "Demasiado simple."]
@export var random_names = ["Alex", "Jordan", "Taylor", "Morgan", "Casey", "Riley"]

func _ready():
	# Verificar si los nodos existen
	if user_name == null or user_opinion == null:
		print("Error: Los nodos 'user_name' o 'user_opinion' no están configurados en esta instancia.")
		print_tree()  # Imprime la estructura de nodos para depuración
		return

	# Llamar a la función para establecer datos de prueba al cargar la escena
	set_critic_data()

func set_critic_data():
	# Verificar si los nodos existen antes de asignar datos
	if user_name == null or user_opinion == null:
		print("Error: Los nodos 'user_name' o 'user_opinion' no están configurados.")
		return

	# Asigna un nombre aleatorio
	user_name.text = random_names[randi() % random_names.size()]

	# Genera un puntaje aleatorio para el crítico
	var critic_score = randi() % 101  # Puntaje aleatorio entre 0 y 100

	# Determina si la opinión será buena o mala
	var is_good = critic_score >= GlobalData.G_FinalScore
	user_opinion.text = good_opinions[randi() % good_opinions.size()] if is_good else bad_opinions[randi() % bad_opinions.size()]

	# Depuración: Imprime el puntaje del crítico y su opinión
	print("Crítico:", user_name.text, "Puntaje:", critic_score, "Opinión:", user_opinion.text)
