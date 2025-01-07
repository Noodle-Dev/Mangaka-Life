extends Control

@onready var user_name = $User/UserName  # Label
@onready var user_opinion = $User/UserOpinion  # RichTextLabel
@onready var user_pic = $User/UserPic  # TextureRect

@onready var good_opinions = GlobalData.G_good_opinions
@onready var bad_opinions = GlobalData.G_bad_opinions
@onready var random_names = GlobalData.G_random_names 
@export var user_pic_folder = "res://assets/sprites/User pfps/"  # IMG SRC

var unique_threshold: int = 0

func _ready():
	get_tree().call_group("menu_grub", "update_status")
	print_tree()  # Vrify nodes
	if user_name == null:
		print("Error: 'user_name' es null. Verifica la ruta o el nodo.")
	if user_opinion == null:
		print("Error: 'user_opinion' es null. Verifica la ruta o el nodo.")
	if user_pic == null:
		print("Error: 'user_pic' es null. Verifica la ruta o el nodo.")

	assign_random_user_name()
	set_random_user_pic()
	assign_random_opinion()
	unique_threshold = randi() % 101

#assign a random name
func assign_random_user_name():
	if user_name != null:
		user_name.text = random_names[randi() % random_names.size()]
		print("Name assigned:", user_name.text)
	else:
		print("Error: node is null, cant assign.")

func assign_random_opinion():
	#assigns to user a opinion
	if user_opinion != null:
		var is_good = randf() < 0.5  # 50% ti be good or bad opinion
		user_opinion.clear()
		var opinion_text = ""
		
		# Asig opinion
		if is_good:
			opinion_text = good_opinions[randi() % good_opinions.size()]
		else:
			GlobalData.G_FinalScore -= randi() % 101 + 100
			opinion_text = bad_opinions[randi() % bad_opinions.size()]

		user_opinion.add_text(opinion_text)
		print("Opinion assigne:", user_opinion.text)

		# If its good give it 50% chances of getting balance
		if is_good and randf() < 0.5:  # 50%
			var bonus = randi() % 101 + 100  # random between 50 and 100
			GlobalData.G_Balance += bonus
			GlobalData.G_FinalScore += bonus
			print("Added ", bonus, " to global balance. New balance: ", GlobalData.G_Balance)
	else:
		print("Error: 'user_opinion' iss null.")

func set_random_user_pic():
	#random pic from src
	var image_files = []
	var index = 1

	while true:
		var image_path = "%sico_%d.png" % [user_pic_folder, index]
		if not FileAccess.file_exists(image_path):
			break
		image_files.append(image_path)
		index += 1

	if image_files.size() == 0:
		print("Error: cant find imgs in src", user_pic_folder)
		return

	var random_image = image_files[randi() % image_files.size()]
	var texture = load(random_image)
	if texture != null and user_pic != null:
		user_pic.texture = texture
		print("Image assigned:", random_image)
	else:
		print("Error: 'user_pic' is null.")
