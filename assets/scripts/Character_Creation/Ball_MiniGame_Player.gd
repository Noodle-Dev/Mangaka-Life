extends CharacterBody2D

# Se asume que estos son los nodos de posición hijos del nodo `Move_Points`
var move_points = []
var current_index = 0
var forward = true

func _ready():
	# Guarda las posiciones en una lista al cargar la escena
	move_points.append($"../Pos_1".position)
	move_points.append($"../Pos_2".position)
	move_points.append($"../Pos_3".position)
	position = move_points[current_index]
	update_position_index()

func _input(event):
	if event.is_action_pressed("move_ball"):
		# Cambia la posición del jugador a la siguiente en la secuencia
		position = move_points[current_index]
		update_position_index()

func update_position_index():
	if forward:
		current_index += 1
		if current_index >= move_points.size():
			current_index = move_points.size() - 2
			forward = false
	else:
		current_index -= 1
		if current_index < 0:
			current_index = 1
			forward = true


func _on_area_2d_area_entered(area):
	if area.is_in_group("obs"):
		#get_tree().call_group("Menu_grub", "call_lose_minigame", 25)
		#get_tree().call_group("Menu_grub", "losing_animation")
		print("alv")


func _on_button_button_down():
	position = move_points[current_index]
	update_position_index()
