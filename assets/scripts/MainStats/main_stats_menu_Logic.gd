extends Node2D

# Status text
@onready var balance = $UI/Manga_Bg/Status/Balance
@onready var reputation = $UI/Manga_Bg/Status/Reputation
@onready var chapters_wrote = $UI/Manga_Bg/Status/Chapters_Wrote
@onready var virality_status = $UI/Manga_Bg/Status/Virality_Status

# Animations
@onready var transitions_panels = $Transitions_Panels

# Panels
@onready var ChapterMakerPanel = $Chapter_Maker

# Objects
@onready var critics_holder = $UI/Manga_Bg/Virality/Critics_Holder
@export var criticObject: PackedScene = preload("res://assets/prefabs/Entity_Critic_UI.tscn")

# Probabilidad de ocurrencia de una crítica
@export var criticism_probability = 0.1  # 10% de probabilidad por frame

func _process(delta):
	# Actualiza el puntaje mostrado
	balance.text = str(GlobalData.G_FinalScore)
	
	# Genera críticas de manera aleatoria
	if randf() < criticism_probability:
		generate_criticism()

func generate_criticism():
	# Verifica que criticObject sea válido
	if criticObject and criticObject is PackedScene:
		# Instancia un nuevo objeto de crítica
		var new_critic = criticObject.instantiate()
		
		# Configura las preferencias del crítico
		var random_threshold = randi() % 101  # Umbral aleatorio entre 0 y 100
		var likes_higher = randf() < 0.5  # 50% de probabilidad de que prefiera puntajes más altos
		
		# Establece los datos del crítico
		new_critic.set_critic_data(GlobalData.G_FinalScore, random_threshold, likes_higher)
		
		# Añade el objeto al contenedor de críticas
		critics_holder.add_child(new_critic)
		
		# Mensaje de consola para verificar
		print("Crítico generado con preferencias.")
	else:
		print("Error: criticObject no es un PackedScene válido.")

# Función para manejar el botón de creación de capítulos
func _on_create_chapter_button_pressed():
	transitions_panels.play("CH_Maker_Enter")
	# Espera a que termine la animación y luego inicializa el creador de capítulos
	ChapterMakerPanel.initialize_quiz()

# Función para manejar el botón de creación de personajes
func _on_create_character_button_pressed():
	print("Botón de creación de personajes presionado.")
	# Aquí puedes añadir lógica para manejar la creación de personajes
