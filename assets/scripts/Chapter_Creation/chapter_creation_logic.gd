extends Control

# Constants
const CHARACTERS_PER_PAGE = 100
const TOTAL_PAGES = 10
const PERFECT_CHANCE = 0.1 # 10% chance for "perfect"
const MISTYPED_CHANCE = 0.05 # 5% chance for "mistyped"

# Nodes
@onready var text_input: TextEdit = $TextInput  # TextEdit for input
@onready var display_output: RichTextLabel = $DisplayOutput  # RichTextLabel for displaying text with formatting
@onready var character_counter: Label = $CountersContainer/Label_CharacterCounter
@onready var page_counter: Label = $CountersContainer/Label_PageCounter
@onready var chapter_status: Label = $Label_ChapterStatus
@onready var page_progress: ProgressBar = $ProgressBar_PageProgress

# Variables
var typed_characters: int = 0
var current_page: int = 0
var quality_scores: Array = []  # Stores "perfect", "mistyped", or "normal" for each character
var bbcode_content: String = ""  # Stores the entire BBCode content for the RichTextLabel
var chapter_created: bool = false

# Called when text is typed in the TextEdit
func _on_text_input_text_changed():
	if chapter_created:
		return # Stop processing if the chapter is already created

	var current_text = text_input.text
	var new_characters = current_text.substr(typed_characters)  # Detect newly added text

	# Process each new character
	for char in new_characters:
		var quality = calculate_quality()
		quality_scores.append(quality)
		add_highlighted_character(char, quality)

	# Update the text counter
	typed_characters = current_text.length()
	current_page = typed_characters / CHARACTERS_PER_PAGE

	# Update the UI
	update_ui()

	# Check if the chapter is complete
	if current_page >= TOTAL_PAGES:
		complete_chapter()

# Calculates the quality of a character
func calculate_quality() -> String:
	var roll = randf()
	if roll < PERFECT_CHANCE:
		return "perfect"
	elif roll < PERFECT_CHANCE + MISTYPED_CHANCE:
		return "mistyped"
	return "normal"

# Adds a highlighted character to the BBCode content
func add_highlighted_character(char: String, quality: String) -> void:
	var escaped_char = escape_bbcode(char)
	if quality == "perfect":
		bbcode_content += "[color=green]" + escaped_char + "[/color]"
	elif quality == "mistyped":
		bbcode_content += "[color=red]" + escaped_char + "[/color]"
	else:
		bbcode_content += escaped_char
	display_output.bbcode_text = bbcode_content

# Manually escapes special characters for BBCode usage
func escape_bbcode(input: String) -> String:
	return input.replace("<", "&lt;").replace(">", "&gt;").replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&apos;")

# Updates the UI components
func update_ui() -> void:
	character_counter.text = "Characters: %d" % typed_characters
	page_counter.text = "Pages: %d/%d" % [current_page, TOTAL_PAGES]
	page_progress.value = float(typed_characters % CHARACTERS_PER_PAGE) / CHARACTERS_PER_PAGE * 100

# Completes the chapter
func complete_chapter() -> void:
	chapter_created = true
	chapter_status.text = "Chapter Created!"
	chapter_status.visible = true
	var perfect_count = quality_scores.count("perfect")
	var mistyped_count = quality_scores.count("mistyped")
	var normal_count = quality_scores.count("normal")
	print("Chapter completed!")
	print("Perfect characters: %d" % perfect_count)
	print("Mistyped characters: %d" % mistyped_count)
	print("Normal characters: %d" % normal_count)

# Initialization
func _ready() -> void:
	# Ensure the initial state of the chapter status
	chapter_status.visible = false
	text_input.clear()  # Start with an empty TextEdit
	display_output.bbcode_text = ""  # Clear the output initially
