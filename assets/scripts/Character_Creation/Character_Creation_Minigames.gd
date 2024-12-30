extends Node2D

@export var microgameScenes: Array[PackedScene]  # Escenas exportables de minijuegos asignables desde el inspector
#@onready var microGameAnim: AnimationPlayer = $Mostrador/MicroGame  # Controlador de animaciones
@onready var microgameTimer: Timer = $MicroTimer  # Temporizador para los minijuegos
@onready var micro_game_holder: Node = $UI/MicroGameHolder  # Contenedor de los minijuegos

var currentMicrogame: Node = null  # Referencia al minijuego actual

func _ready():
	"""
	Función ejecutada al inicio de la escena.
	Inicializa la lógica de los minijuegos.
	"""
	initialize_minigames()

func initialize_minigames():
	"""
	Inicializa los minijuegos, verificando que las escenas estén configuradas correctamente.
	"""
	if microgameScenes.size() == 0:
		print("[ERROR] No hay minijuegos asignados. Por favor, añade minijuegos en el inspector.")
		return

	print("[INFO] Minijuegos inicializados correctamente.")

func spawnRandomMicrogame():
	"""
	Selecciona un minijuego aleatorio de la lista y lo instancia en la escena.
	"""
	if microgameScenes.size() == 0:
		print("[ERROR] No hay minijuegos disponibles para instanciar.")
		return

	# Selecciona un minijuego aleatorio
	var randomIndex = randi() % microgameScenes.size()
	var selectedMicrogameScene: PackedScene = microgameScenes[randomIndex]

	# Instancia el minijuego
	currentMicrogame = selectedMicrogameScene.instantiate()
	
	# Verifica que el contenedor exista antes de agregar el minijuego
	if micro_game_holder:
		micro_game_holder.add_child(currentMicrogame)
		print("[INFO] Minijuego instanciado correctamente en MicroGameHolder.")
	else:
		print("[ERROR] 'micro_game_holder' no está configurado o no es válido.")

	# Inicia el temporizador si está configurado
	if microgameTimer:
		microgameTimer.start()
		print("[INFO] Temporizador del minijuego iniciado.")

func endMicrogame():
	"""
	Finaliza y elimina el minijuego actual.
	"""
	if currentMicrogame != null:
		if micro_game_holder and currentMicrogame.get_parent() == micro_game_holder:
			micro_game_holder.remove_child(currentMicrogame)  # Elimina del contenedor
		currentMicrogame.queue_free()  # Libera la memoria
		currentMicrogame = null
		print("[INFO] Minijuego finalizado y eliminado.")
	else:
		print("[WARN] No hay un minijuego activo para finalizar.")
