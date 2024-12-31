extends Node2D

@export var microgame_scenes: Array[PackedScene]  # Escenas exportables de minijuegos asignables desde el inspector
@onready var microgame_timer: Timer = $MicroTimer  # Temporizador para los minijuegos
@onready var micro_game_anim = $AnimationPlayer
@onready var micro_game_holder: Control = $UI/MicroGameHolder  # Contenedor de los minijuegos

@onready var character_state = $UI/charStat
@export var state_textures: Array[Texture2D]

var microgame_instance: Node = null  # Referencia al minijuego actual
var current_state_index: int = 0  # Índice para controlar la textura actual

func _ready():
	if microgame_instance == null:
		pass

func spawn_random_microgame():
	var random_index = randi() % microgame_scenes.size()
	var selected_microgame_scene = microgame_scenes[random_index]
	microgame_instance = selected_microgame_scene.instantiate()
	add_child(microgame_instance)
	
	if microgame_instance:
		microgame_instance.position = $UI/MicroGameHolder.position
	
	if microgame_timer:
		microgame_timer.start()

func start_microgame():
	if micro_game_anim:
		micro_game_anim.play("Start_mini")  # Replace "Start_mini" with your specific animation name.
		await micro_game_anim.animation_finished
	spawn_random_microgame()

func _on_micro_timer_timeout():
	end_microgame()

func end_microgame():
	if microgame_instance != null:
		remove_child(microgame_instance)
		microgame_instance.queue_free()
		microgame_instance = null
		$"../Transitions_Panels".play_backwards("CHAP_Maker_Enter")

# Función para degradar el personaje
func degradate_character():
	# Verifica si el índice actual está dentro del rango de texturas
	if current_state_index < state_textures.size():
		# Cambia la textura del estado del personaje
		character_state.texture = state_textures[current_state_index]
		# Aumenta el índice para cambiar a la siguiente textura en la siguiente llamada
		current_state_index += 1
		# Si el índice excede el tamaño del array, lo reinicia
		if current_state_index >= state_textures.size():
			current_state_index = 0
