extends Node2D

@export var microgameScenes: Array[PackedScene]  # Variable exportable para los minijuegos
@onready var microGameAnim = $Mostrador/MicroGame
@onready var microgameTimer = $MicroTimer
@onready var micro_game_holder = $UI/MicroGameHolder  # Referencia al contenedor de los microjuegos

var currentMicrogame: Node = null

func _ready():
	spawnRandomMicrogame()

func startMicrogame():
	if microGameAnim:
		microGameAnim.play("Start_mini")  # Inicia la animación de inicio del minijuego
		await microGameAnim.animation_finished  # Espera hasta que termine la animación
	spawnRandomMicrogame()

func spawnRandomMicrogame():
	if microgameScenes.size() == 0:
		print("No microgames assigned!")
		return

	var randomIndex = randi() % microgameScenes.size()  # Selecciona un minijuego aleatorio
	var selectedMicrogameScene = microgameScenes[randomIndex]
	currentMicrogame = selectedMicrogameScene.instantiate()  # Instancia el minijuego seleccionado
	
	# Agrega el minijuego como hijo de micro_game_holder
	micro_game_holder.add_child(currentMicrogame)
	
	if microgameTimer:
		microgameTimer.start()  # Inicia el temporizador del minijuego

func _on_micro_timer_timeout():
	endMicrogame()

func endMicrogame():
	if currentMicrogame != null:
		micro_game_holder.remove_child(currentMicrogame)  # Elimina el minijuego de micro_game_holder
		currentMicrogame.queue_free()  # Libera la memoria del minijuego
		currentMicrogame = null
