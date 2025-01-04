extends Node2D

var names_Obj = preload("res://assets/prefabs/Chapter_Creation/chapter_name_created.tscn")
@onready var names_list = $Control/TextureRect/VBoxContainer
@onready var chapter_namer = $Control/Chapter_NameCreation/TextureRect3/Chapter_Namer

func _on_create_chap_pressed():
	# Mostrar el panel de creación de capítulos
	$Control/Chapter_NameCreation.visible = true

func _on_appear_panel_quest_pressed():
	# Instanciar la escena que contiene el Label
	var new_name_instance = names_Obj.instantiate()
	
	# Acceder al Label llamado "Chapter_Name_Created" en la instancia
	var label_node = new_name_instance.get_node("Chapter_Name_Created")
	
	# Actualizar el texto del Label con el contenido de chapter_namer
	if label_node:
		label_node.text = chapter_namer.text
	else:
		$"../Transitions_Panels".play("CH_Maker_Enter")
		$"../Chapter_Maker".initialize_quiz()
		self.visible = false
		print("Error: No se encontró el nodo 'Chapter_Name_Created' en la instancia.")
	
	# Añadir la instancia al contenedor de la lista
	names_list.add_child(new_name_instance)
