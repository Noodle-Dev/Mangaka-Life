extends Node2D

@export var microgame_scenes: Array[PackedScene] 
@onready var microgame_timer: Timer = $MicroTimer  
@onready var micro_game_anim = $AnimationPlayer
@onready var micro_game_holder: Control = $UI/MicroGameHolder  

@onready var character_state = $UI/charStat
@export var state_textures: Array[Texture2D]

var microgame_instance: Node = null  
var current_state_index: int = 0  

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

func degradate_character():
	if current_state_index < state_textures.size():
		character_state.texture = state_textures[current_state_index]
		current_state_index += 1
		$AnimationPlayer.play("Lose")
		if current_state_index >= state_textures.size():
			current_state_index = 0
func generate_character():
	$AnimationPlayer.play("Win")
