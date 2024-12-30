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

# Minijuegos
@onready var minigames_node = $Character_Maker_Scene  # Ruta al nodo de los minijuegos

# Objects
@onready var critics_holder = $UI/Manga_Bg/Virality/Critics_Holder
@export var criticObject: PackedScene = preload("res://assets/prefabs/Entity_Critic_UI.tscn")

# Temporizador para críticas
@onready var criticism_timer = $CriticismTimer
@onready var NCritik = 0

# Rango de tiempo para críticas (en segundos)
@export var min_criticism_interval = 3
@export var max_criticism_interval = 10

func _ready():
	# Configurar el temporizador al inicio
	transitions_panels.play("RESET")
	reset_criticism_timer()
	update_status()

# Resetea y configura el temporizador con un intervalo aleatorio
func reset_criticism_timer():
	if criticism_timer:
		criticism_timer.wait_time = randf_range(min_criticism_interval, max_criticism_interval)
		criticism_timer.start()

func _on_criticism_timer_timeout():
	# Verifica si hay al menos un capítulo escrito
	if GlobalData.G_Chap_Wrote >= 1:
		generate_criticism()
	else:
		print("No hay capítulos escritos. No se generarán críticas.")

	# Reinicia el temporizador con un nuevo intervalo
	reset_criticism_timer()

func generate_criticism():
	if criticObject and criticObject is PackedScene:
		var new_critic = criticObject.instantiate()
		
		# Configura las preferencias del crítico
		var random_threshold = randi() % 101  # Umbral aleatorio entre 0 y 100
		var likes_higher = randf() < 0.5  # 50% de probabilidad de que prefiera puntajes más altos
		
		# Establece los datos del crítico
		if new_critic.has_method("set_critic_data"):
			new_critic.set_critic_data(GlobalData.G_FinalScore, random_threshold, likes_higher)
		else:
			print("Advertencia: El objeto crítico no tiene el método 'set_critic_data'. Datos no configurados.")

		# Añade el objeto al contenedor de críticas (critics_holder)
		if critics_holder:
			critics_holder.add_child(new_critic)
			GlobalData.G_N_Critics =  GlobalData.G_N_Critics + 1
			$UI/NCritics.text = "Critics: " + str(GlobalData.G_N_Critics)
			update_status()
			print("Crítico generado y añadido al contenedor de críticas.")
		else:
			print("Error: 'critics_holder' no está configurado o no es válido.")
	else:
		print("Error: 'criticObject' no es un PackedScene válido.")

func update_status():
	# Actualizar reputación basada en G_FinalScore
	var score = GlobalData.G_FinalScore
	var rep = 0
	
	if score < 20:
		rep = 0
	elif score < 40:
		rep = 1
	elif score < 60:
		rep = 2
	elif score < 80:
		rep = 3
	elif score < 90:
		rep = 4
	else:
		rep = 5
	
	# Actualizar el texto de reputación
	if reputation and reputation is RichTextLabel:
		reputation.text = "Reputation: " + str(rep)
	else:
		print("Error: 'reputation' no está asignado o no es un RichTextLabel.")
	
	# Determinar el nivel de virality
	var virality_text = ""
	if rep == 0:
		virality_text = "[b]Virality:[/b] None"
	elif rep == 1:
		virality_text = "[b]Virality:[/b] Some"
	elif rep == 2:
		virality_text = "[b]Virality:[/b] Kind of"
	elif rep == 3:
		virality_text = "[b]Virality:[/b] A lot"
	elif rep == 4:
		virality_text = "[b]Virality:[/b] Recognized"
	elif rep == 5:
		virality_text = "[b]Virality:[/b] Famous"
	else:
		virality_text = "[b]Virality:[/b] None"
	
	if virality_status and virality_status is RichTextLabel:
		virality_status.text = virality_text
	else:
		print("Error: 'virality_status' no está asignado o no es un RichTextLabel.")


func adjust_balance(amount: int):
	"""
	Ajusta el balance global.
	"""
	GlobalData.G_Balance += amount
	balance.text = "Balance: " + str(GlobalData.G_Balance) + "$"

# Función para manejar el botón de creación de capítulos
func _on_create_chapter_button_pressed():
	if GlobalData.G_Balance >= 250:
		adjust_balance(-250)
		GlobalData.G_Chap_Wrote += 1
		chapters_wrote.text = "Chapters wrote: " + str(GlobalData.G_Chap_Wrote)
		transitions_panels.play("CH_Maker_Enter")
		ChapterMakerPanel.initialize_quiz()
	else:
		transitions_panels.play("Money_Flash")
		print("No tienes suficiente balance para crear un capítulo.")

func _on_create_character_button_pressed():
	if GlobalData.G_Balance >= 150:
		adjust_balance(-150)
		transitions_panels.play("CHAP_Maker_Enter")
		$Character_Maker_Scene.start_microgame()
		
		# Inicializa los minijuegos
		if minigames_node and minigames_node.has_method("initialize_minigames"):
			minigames_node.initialize_minigames()
		else:
			print("Error: Nodo de minijuegos no encontrado o no tiene el método 'initialize_minigames'.")
	else:
		transitions_panels.play("Money_Flash")
		print("No tienes suficiente balance para crear un personaje.")
