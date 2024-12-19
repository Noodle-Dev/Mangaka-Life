extends Node2D

# Variables para almacenar las preguntas y valores
var questions = [
	{
		"text": "Question 1?",
		"options": {
			"Option A": 1,
			"Option B": 2,
			"Option C": 3,
			"Option D": 4
		}
	},
	{
		"text": "Question 2?",
		"options": {
			"Option A": 2,
			"Option B": 1,
			"Option C": 4,
			"Option D": 3
		}
	}
]
var current_question = 0
var total_score = 0

# Referencias a los nodos de la escena
@onready var question_label = $UI/Manga_Bg/Question_Label
@onready var button_choice_one = $UI/Manga_Bg/Question_holder/button_choice_one
@onready var button_choice_two = $UI/Manga_Bg/Question_holder/button_choice_two
@onready var button_choice_three = $UI/Manga_Bg/Question_holder/button_choice_three
@onready var button_choice_four = $UI/Manga_Bg/Question_holder/button_choice_four
@onready var result_label = $UI/Manga_Bg/Result

func _ready():
	# Si las preguntas fueron cargadas correctamente, mostramos la primera
	if questions.size() > 0:
		load_question()
	else:
		question_label.text = "No se encontraron preguntas."

# Carga la pregunta actual
func load_question():
	if current_question < questions.size():
		# Carga el texto de la pregunta
		question_label.text = questions[current_question]["text"]
		
		# Obtiene las opciones actuales
		var options = questions[current_question]["options"].keys()
		var buttons = [button_choice_one, button_choice_two, button_choice_three, button_choice_four]
		
		# Actualiza los textos de los botones con las opciones
		for i in range(buttons.size()):
			if i < options.size():
				# Accede al Label hijo dentro de cada TextureButton y asigna el texto
				var button_label = buttons[i].get_node("Label")  # Asegúrate de que "Label" sea el nombre correcto del nodo Label
				button_label.text = options[i]  # Asigna el texto de la opción al Label
				buttons[i].visible = true  # Hacemos visible el botón
				buttons[i].set_meta("option_text", options[i])  # Almacena la opción en el botón
			else:
				buttons[i].visible = false  # Oculta botones no utilizados
	else:
		show_result()

# Función genérica para manejar la selección
func _on_button_selected(button):
	var option_text = button.get_meta("option_text")
	var score = questions[current_question]["options"][option_text]
	total_score += score
	current_question += 1
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

# Muestra el resultado final
func show_result():
	question_label.text = "¡Cuestionario finalizado!"
	button_choice_one.visible = false
	button_choice_two.visible = false
	button_choice_three.visible = false
	button_choice_four.visible = false
	result_label.text = "Tu puntuación total es: %d" % total_score
