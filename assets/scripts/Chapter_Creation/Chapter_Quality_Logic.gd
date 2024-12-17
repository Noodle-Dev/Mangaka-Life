extends Control

# Quality Settings
const PERFECT_CHANCE = 0.1 # 10% chance
const MISTYPED_CHANCE = 0.05 # 5% chance

# Variables
var quality_scores: Array = [] # Store quality of each keypress
var page_quality: float = 0.0

# Called when text is typed in the TextEdit
func _on_text_edit_text_changed(new_text: String) -> void:
	var new_characters = new_text.substr(typed_characters)
	for char in new_characters:
		# Calculate quality for each new character
		var quality: String = calculate_quality()
		quality_scores.append(quality)

		# Highlight text based on quality
		if quality == "perfect":
			# Use RichTextLabel or modify TextEdit color
			highlight_character(new_text.length() - 1, "green")
		elif quality == "mistyped":
			highlight_character(new_text.length() - 1, "red")

	# Update overall quality score
	page_quality = calculate_page_quality()

# Calculate quality of a single keypress
func calculate_quality() -> String:
	var roll = randf()
	if roll < PERFECT_CHANCE:
		return "perfect"
	elif roll < PERFECT_CHANCE + MISTYPED_CHANCE:
		return "mistyped"
	return "normal"

# Highlight a specific character
func highlight_character(index: int, color: String) -> void:
	$TextEdit.add_color_override("font_color", Color.named(color))
	# You may need to work with RichTextLabel for finer control

# Calculate overall quality score
func calculate_page_quality() -> float:
	var perfect_count = quality_scores.count("perfect")
	var mistyped_count = quality_scores.count("mistyped")
	return float(perfect_count - mistyped_count) / typed_characters
