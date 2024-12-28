extends Node2D

# Variables para almacenar las preguntas clasificadas por tipos
var question_types = GlobalData.G_question_types


var questions = []
var current_question = 0
var total_score = 0

# Referencias a los nodos de la escena
@onready var question_label = $UI/Manga_Bg/Question_Label
@onready var button_choice_one = $UI/Manga_Bg/Question_holder/button_choice_one
@onready var button_choice_two = $UI/Manga_Bg/Question_holder/button_choice_two
@onready var button_choice_three = $UI/Manga_Bg/Question_holder/button_choice_three
@onready var button_choice_four = $UI/Manga_Bg/Question_holder/button_choice_four
@onready var result_label = $UI/Manga_Bg/Result
@onready var transition_animation = $UI/Manga_Bg/Questions_Transitions

func _ready():
	# Llama a la función de inicialización del cuestionario
	pass
	#initialize_quiz()

# Inicializa el cuestionario
func initialize_quiz():
	current_question = 0
	total_score = 0
	questions.clear()
	# Selecciona una pregunta aleatoria de cada tipo
	for type in question_types.keys():
		questions.append(question_types[type][randi() % question_types[type].size()])
	questions.shuffle()
	# Carga la primera pregunta
	if questions.size() > 0:
		load_question()
	else:
		question_label.text = "No se encontraron preguntas."

# Carga la pregunta actual
func load_question():
	if current_question < questions.size():
		# Carga el texto de la pregunta
		question_label.text = questions[current_question]["text"]
		transition_animation.play("Enter")
		
		# Obtiene las opciones actuales
		var options = questions[current_question]["options"].keys()
		var buttons = [button_choice_one, button_choice_two, button_choice_three, button_choice_four]
		
		# Actualiza los textos de los botones con las opciones
		for i in range(buttons.size()):
			if i < options.size():
				var button_label = buttons[i].get_node("Label")
				button_label.text = options[i]
				buttons[i].visible = true
				buttons[i].set_meta("option_text", options[i])
			else:
				buttons[i].visible = false
	else:
		finalize_quiz()

# Maneja la selección de una opción
func _on_button_selected(button):
	var option_text = button.get_meta("option_text")
	var score = questions[current_question]["options"][option_text]
	total_score += score
	current_question += 1
	transition_animation.play("Go")
	await transition_animation.animation_finished
	load_question()

# Maneja los botones conectados
func _on_button_choice_one_pressed():
	_on_button_selected(button_choice_one)

func _on_button_choice_two_pressed():
	_on_button_selected(button_choice_two)

func _on_button_choice_three_pressed():
	_on_button_selected(button_choice_three)

func _on_button_choice_four_pressed():
	_on_button_selected(button_choice_four)

# Finaliza el cuestionario
func finalize_quiz():
	question_label.text = "Chapter created!"
	button_choice_one.visible = false
	button_choice_two.visible = false
	button_choice_three.visible = false
	button_choice_four.visible = false
	result_label.text = "Tu puntuación total es: %d" % total_score
	GlobalData.G_FinalScore = GlobalData.G_FinalScore + total_score
	transition_animation.play("Finish")


func _on_finish_manga_btn_pressed():
	$"../Transitions_Panels".play_backwards("CH_Maker_Enter")
	GlobalData.G_Chap_Wrote = GlobalData.G_Chap_Wrote  + 1
	transition_animation.play_backwards("Finish")
