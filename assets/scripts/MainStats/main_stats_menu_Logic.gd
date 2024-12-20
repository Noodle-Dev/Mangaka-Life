extends Node2D
#Status text
@onready var balance = $UI/Manga_Bg/Status/Balance
@onready var reputation = $UI/Manga_Bg/Status/Reputation
@onready var chapters_wrote = $UI/Manga_Bg/Status/Chapters_Wrote
@onready var virality_status = $UI/Manga_Bg/Status/virality_status

#Animations
@onready var transitions_panels = $Transitions_Panels

#Panels
@onready var ChapterMakerPanel = $Chapter_Maker

func _process(delta):
	pass
	
	#Test
	#balance.text = GlobalData.G_FinalScore.ToString()

func _on_create_chapter_button_pressed():
	transitions_panels.play("CH_Maker_Enter")
	#await transitions_panels.animation_finished
	ChapterMakerPanel.initialize_quiz()
	
func _on_create_character_button_pressed():
	pass # Replace with function body.
