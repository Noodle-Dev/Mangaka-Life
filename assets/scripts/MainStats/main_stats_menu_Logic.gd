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

#Objects
@onready var critics_holder = $UI/Manga_Bg/Virality/Critics_Holder
@export var criticObject = preload("res://assets/prefabs/Entity_Critic_UI.tscn")

func _process(delta):
	pass

	balance.text = str(GlobalData.G_FinalScore)

func _on_create_chapter_button_pressed():
	transitions_panels.play("CH_Maker_Enter")
	#await transitions_panels.animation_finished
	ChapterMakerPanel.initialize_quiz()
	
func _on_create_character_button_pressed():
	pass # Replace with function body.
