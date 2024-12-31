extends Sprite2D

# References to patrol point nodes
@export var patrol_point_a_node: Node2D
@export var patrol_point_b_node: Node2D
var current_target: Vector2

# Movement speed
var min_speed = 600
var max_speed = 1000
var speed = randf_range(min_speed, max_speed)
var dash_speed = 300
var dash_duration = 0.5 # Duration of the dash in seconds
var stop_y = 951 # Y-coordinate to stop at during dashing

# Direction indicator
var moving_to_a = true

# Dash state
var is_dashing = false
var dash_timer = 0
var is_winnin : bool
var has_played_angry_animation = false

func _ready():
	speed = randf_range(min_speed, max_speed)
	current_target = patrol_point_a_node.position

func _input(event):
	if event.is_action_pressed("move_ball"):
		start_dashing()
	
func _process(delta):
	if is_dashing:
		dash_timer -= delta
		dash_down()
		if dash_timer <= 0:
			#is_dashing = false
			dash_timer = 0
			check_loss_condition()
	else:
		patrol(delta)

func patrol(delta):
	if position.distance_to(current_target) < 10:
		moving_to_a = !moving_to_a
		current_target = patrol_point_a_node.position if moving_to_a else patrol_point_b_node.position

	position = position.move_toward(current_target, speed * delta)

func dash_down():
	# Move quickly downwards, but stop at the specified Y-coordinate
	if position.y + dash_speed > stop_y:
		position.y = stop_y
	else:
		pass
		position.y = stop_y#+= dash_speed

func start_dashing():
	is_dashing = true
	dash_timer = dash_duration
	print("webss")
	
func check_loss_condition():
	# Play Angry animation if player loses and it hasn't been played
	if not is_winnin and not has_played_angry_animation:
		print("Insult")
		get_tree().call_group("charMaker", "degradate_character")
		#$"../Lose/lose".play("Angry")
		#$"../Lose2".play()
		has_played_angry_animation = true

func _on_area_2d_area_entered(pen):
	if pen.is_in_group("goal"):
		is_winnin = true
		#get_tree().call_group("Menu_grub", "add_orgasm_points", 2)
		print("win")
		#$"../Lose/lose".play("Yei")
		get_tree().call_group("charMaker", "end_microgame")
		GlobalData.G_Reputation = GlobalData.G_Reputation + 10
		#get_tree().call_group("charMaker", "generate_character")
		#$"../Vamo".play() end_microgame
	else:
		get_tree().call_group("charMaker", "end_microgame")
		GlobalData.G_Reputation = GlobalData.G_Reputation - 30
		print("asshole")
		#get_tree().call_group("Menu_grub", "quit_orgasm_points", 10)

func _on_pureya_timeout():
	start_dashing()

func _on_p_lay_btn_button_down():
	start_dashing()
