extends Node2D
#Personajes
var names_Obj = preload("res://assets/prefabs/Chapter_Creation/chapter_name_created.tscn")
@onready var names_list = $Control/TextureRect/VBoxContainer
@onready var chapter_namer = $Control/Chapter_NameCreation/TextureRect3/Chapter_Namer

func _physics_process(delta):
	$"Control/TextureRect2/Manga Name".text = GlobalData.G_Manga_Name
	
func _on_create_chap_pressed():
	$Control/Chapter_NameCreation.visible = true
	
func _on_appear_panel_quest_pressed():
	var new_name_instance = names_Obj.instantiate()
	new_name_instance.text = chapter_namer.text
	names_list.add_child(new_name_instance)
	print("New chapter added: ", chapter_namer.text)
	$"../Transitions_Panels".play("CHAP_Maker_Enter")
	$"../Character_Maker_Scene".start_microgame()
	await $"../Transitions_Panels".animation_finished
	
	
	$Control/Chapter_NameCreation.visible = false
	self.visible = false
