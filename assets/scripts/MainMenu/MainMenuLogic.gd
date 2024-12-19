extends Node2D

func _on_texture_button_pressed():
	$GO.play("Transition")
	await $GO.animation_finished
	get_tree().change_scene_to_file("res://assets/scenes/Menus/MainStats_Menu.tscn")
