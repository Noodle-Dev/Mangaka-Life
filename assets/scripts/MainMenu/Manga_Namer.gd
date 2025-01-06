extends Control

@onready var MangaNamer = $ColorRect/LineEdit

func _on_texture_button_pressed():
	GlobalData.G_Manga_Name = MangaNamer.text
	print("Manga llamao: " + GlobalData.G_Manga_Name)
	self.queue_free()
