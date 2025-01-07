extends Node2D

var names_Obj = preload("res://assets/prefabs/Chapter_Creation/chapter_name_created.tscn")
@onready var names_list = $Control/TextureRect/VBoxContainer
@onready var chapter_namer = $Control/Chapter_NameCreation/TextureRect3/Chapter_Namer

func _physics_process(delta):
	$"Control/TextureRect2/Manga Name".text = GlobalData.G_Manga_Name
func _on_create_chap_pressed():
	# LOAD FROM CONFIG FILE UNCOMMENT WHEN RELEASE
	#GlobalData.load_chapters_from_config_file(names_list, names_Obj, "user://chapters.cfg")
	$Control/Chapter_NameCreation.visible = true

func _on_appear_panel_quest_pressed():
	var new_name_instance = names_Obj.instantiate()
	new_name_instance.text = chapter_namer.text
	names_list.add_child(new_name_instance)
	print("New chapter added: ", chapter_namer.text)
	$"../Transitions_Panels".play("CH_Maker_Enter")
	$"../Chapter_Maker".initialize_quiz()
	await $"../Transitions_Panels".animation_finished
	
	$Control/Chapter_NameCreation.visible = false
	self.visible = false
	# SAVE TO CONFIG FILE UNCOMMENT WHEN RELEASE
	#GlobalData.save_chapters_to_config_file(names_list, "user://chapters.cfg")
	print("Ruta del archivo:", ProjectSettings.globalize_path("user://chapters.cfg"))
