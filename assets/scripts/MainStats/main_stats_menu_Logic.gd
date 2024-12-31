extends Node2D

# Status text
@onready var balance = $UI/Manga_Bg/Status/Balance
@onready var reputation = $UI/Manga_Bg/Status/Reputation
@onready var chapters_wrote = $UI/Manga_Bg/Status/Chapters_Wrote
@onready var virality_status = $UI/virality_statusBLE

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

# Variables de reputación y viralidad
var good_critiques = 0
var bad_critiques = 0

func _ready():
	# Configurar el temporizador al inicio
	transitions_panels.play("RESET")
	reset_criticism_timer()
	update_status()

func _process(delta):
	update_status(
	)
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
			GlobalData.G_N_Critics = GlobalData.G_N_Critics + 1
			
			# Determinar si la crítica es positiva o negativa
			if likes_higher and GlobalData.G_FinalScore >= random_threshold:
				good_critiques += 1
			elif not likes_higher and GlobalData.G_FinalScore <= random_threshold:
				good_critiques += 1
			else:
				bad_critiques += 1
			
			# Limitar la cantidad de críticas a 5
			if critics_holder.get_child_count() > 5:
				critics_holder.get_child(0).queue_free()
			
			$UI/NCritics.text = "Critics: " + str(GlobalData.G_N_Critics)
			update_status()
			print("Crítico generado y añadido al contenedor de críticas.")
		else:
			print("Error: 'critics_holder' no está configurado o no es válido.")
	else:
		print("Error: 'criticObject' no es un PackedScene válido.")

func update_status():
	# Calcular reputación basada en buenas críticas
	var total_critiques = good_critiques + bad_critiques
	var reputation_text = ""
	if total_critiques > 0:
		var reputation_percent = (good_critiques / float(total_critiques)) * 100
		reputation_text = "Reputation: " + str(int(reputation_percent)) + "%"
	else:
		reputation_text = "Reputation: 0%"

	# Actualizar texto de reputación
	if reputation and reputation is RichTextLabel:
		reputation.text = reputation_text
	else:
		print("Error: 'reputation' no está asignado o no es un RichTextLabel.")

	# Determinar viralidad basada en el puntaje final
	var virality_text = calculate_virality()
	if virality_status and virality_status is RichTextLabel:
		virality_status.text = virality_text
	else:
		print("Error: 'virality_status' no está asignado o no es un RichTextLabel.")

# Calcula el nivel de viralidad basado en el puntaje total
func calculate_virality() -> String:
	var score = GlobalData.G_FinalScore
	if score > 80:
		return "Virality: [shake rate=50.0 level=5 connected=1]{Extremely High}[/shake]"
	elif score > 60:
		return "Virality: [shake rate=40.0 level=5 connected=1]{High}[/shake]"
	elif score > 40:
		return "Virality: [shake rate=30.0 level=5 connected=1]{Moderate}[/shake]"
	elif score > 20:
		return "Virality: [shake rate=20.0 level=5 connected=1]{Low}[/shake]"
	else:
		return "Virality: [shake rate=10.0 level=5 connected=1]{None}[/shake]"

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
