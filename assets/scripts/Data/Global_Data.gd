extends Node
var G_Manga_Name = ""


#Stats
var G_Balance = 500
var G_Reputation = 0
var G_Chap_Wrote = 0
var G_N_Critics = 0

var G_FinalScore = 0

#Opinions
var G_good_opinions = [
	"I loved it!", "A masterpiece.", "Incredibly creative.",
	"Absolutely fantastic.", "Brilliant work!", "Highly enjoyable.",
	"Exceeded expectations.", "Very impressive.", "Stunning effort.",
	"Truly remarkable.", "Couldn't stop smiling!", "Top-notch quality.",
	"Beautifully executed.", "Pure genius!", "Heartwarming and fun.",
	"Engaging from start to finish.", "Perfectly crafted.", 
	"A delightful experience.", "Simply unforgettable.", 
	"Full of charm and wit.", "A true gem.", 
	"Left me wanting more.", "Fantastic storytelling."
];

var G_bad_opinions = [
	"Not my cup of tea.", "It lacks something.", "Too simplistic.",
	"Could use improvement.", "Not engaging enough.", "Fell flat for me.",
	"Didn't meet expectations.", "A bit underwhelming.", "Missed the mark.",
	"Needs more depth.", "Not what I expected.", "Disappointing overall.",
	"Uninspired execution.", "Lacked originality.", "Felt rushed.",
	"Hard to follow.", "Too predictable.", "Lacking emotional impact.",
	"Overhyped and underdelivered.", "Failed to connect with me.",
	"Needed more polish.", "Dull and unmemorable.", 
	"Didn't capture my interest.", "A complete disaster.", 
	"Painfully boring.", "Borderline unwatchable.", "Offensively bad.",
	"Embarrassingly amateurish.", "A trainwreck from start to finish.",
	"Utterly soulless.", "Makes no sense whatsoever.",
	"Cringeworthy at every turn.", "A waste of time and effort.",
	"Horribly executed.", "Unbearably tedious.", 
	"As enjoyable as watching paint dry.", "Infuriatingly bad.",
	"Left me questioning my life choices.", "Insulting to the audience.",
	"A masterclass in how not to do it.", "An absolute mess.",
	"Worse than I could have imagined."
];


var G_random_names = [
	"Alex", "Jordan", "Taylor", "Morgan", "Casey", "Riley",
	"Cameron", "Harper", "Quinn", "Drew", "Peyton", "Skyler",
	"Blake", "Sawyer", "Rowan", "Logan", "Reese", "Avery",
	"Emerson", "Charlie", "Finley", "Dakota", "Hayden", "Tatum",
	"Elliot", "Lennox", "Jesse", "Micah", "Sage", "Phoenix","Noodle Dev"
];

#Questions
var G_question_types = {
	"manga_beginning": [
		{
			"text": "How does the protagonist's journey begin, and why is it significant?",
			"options": {
				"Life-changing event": 2,
				"Facing an unexpected threat": 1,
				"Solving a mysterious puzzle": 1,
				"Stuck in a mundane routine": -1
			}
		},
		{
			"text": "What tone does the opening scene establish?",
			"options": {
				"Dark and suspenseful": 2,
				"Hopeful and serene": 1,
				"Unconventional and unique": 1,
				"Generic or clichéd": -2
			}
		},
		{
			"text": "What is the protagonist's emotional state when the story begins?",
			"options": {
				"Burning curiosity": 2,
				"Urgent need to escape": 1,
				"Paralyzing fear": 0,
				"Apathetic indifference": -1
			}
		},
		{
			"text": "What marks the first major challenge in the story?",
			"options": {
				"Overcoming internal fears": 2,
				"Helping someone in need": 1,
				"Experiencing a personal failure": 0,
				"Facing a minor inconvenience": -2
			}
		},
		{
			"text": "What is the protagonist's initial motivation for their actions?",
			"options": {
				"Seeking revenge for a loss": 1,
				"Yearning for discovery": 2,
				"Struggling for survival": 1,
				"Drifting without purpose": -1
			}
		},
		{
			"text": "What aspect of the protagonist is revealed early on?",
			"options": {
				"A hidden strength": 2,
				"A deep vulnerability": 1,
				"A moral conflict": 2,
				"Nothing significant": -2
			}
		}
	],
	"manga_climax": [
		{
			"text": "What defines the main conflict during the climax?",
			"options": {
				"An epic showdown": 2,
				"A profound moral dilemma": 3,
				"A life-altering revelation": 1,
				"A predictable sequence": -2
			}
		},
		{
			"text": "How does the protagonist overcome their greatest challenge?",
			"options": {
				"Skills honed through hardship": 2,
				"The support of loyal allies": 1,
				"Executing a brilliant strategy": 3,
				"Relying on sheer luck": 0
			}
		},
		{
			"text": "What role does the antagonist play in shaping the climax?",
			"options": {
				"Reveals a hidden weakness": 1,
				"Forces the hero to confront truth": 2,
				"Tests the hero's limits": 3,
				"Becomes a predictable obstacle": -1
			}
		},
		{
			"text": "What lasting impact does the climax leave on the story?",
			"options": {
				"Unveils hidden truths": 3,
				"Redefines key relationships": 2,
				"Changes little about the status quo": 0,
				"Feels inconsequential": -3
			}
		},
		{
			"text": "What makes the environment of the climax stand out?",
			"options": {
				"Unique and unforgettable": 3,
				"Intense and full of danger": 2,
				"Ordinary yet functional": 0,
				"Forgettable or generic": -2
			}
		},
		{
			"text": "What unexpected event shapes the climax?",
			"options": {
				"Revelation of a secret": 3,
				"A betrayal": 2,
				"An unforeseen ally": 1,
				"No surprises": -1
			}
		}
	],
	"manga_theme": [
		{
			"text": "What is the central theme of the story?",
			"options": {
				"Friendship and loyalty": 2,
				"Resilience and perseverance": 3,
				"The cost of ambition": 1,
				"Undefined or unclear": -2
			}
		},
		{
			"text": "How is the central theme explored throughout the story?",
			"options": {
				"Through evolving character dynamics": 2,
				"Embedded in the world's tone": 3,
				"Interwoven in the conflicts": 1,
				"Rarely addressed explicitly": -1
			}
		},
		{
			"text": "What emotions does the story aim to evoke in its audience?",
			"options": {
				"Hope amidst adversity": 3,
				"Empathy for the characters": 2,
				"Inspiration to take action": 1,
				"Ambiguity or confusion": -2
			}
		},
		{
			"text": "Are there any secondary themes, and how are they handled?",
			"options": {
				"Integrated seamlessly": 3,
				"Occasionally touched upon": 2,
				"Underdeveloped": 0,
				"Contradictory to the main theme": -2
			}
		},
		{
			"text": "How complex is the thematic exploration in the story?",
			"options": {
				"Rich and multi-layered": 3,
				"Clear yet profound": 2,
				"Simple but effective": 1,
				"Overly simplistic or shallow": -1
			}
		},
		{
			"text": "What values does the story challenge or affirm?",
			"options": {
				"Traditional beliefs": 2,
				"Modern ideals": 2,
				"Character morality": 1,
				"Fails to address values": -2
			}
		}
	]
};

func update_balance(balance_node: RichTextLabel):
	if balance_node and balance_node is RichTextLabel:
		balance_node.text = "Balance: " + str(GlobalData.G_Balance) + "$"
#Save chapters from global scope
"""
USED FOR TESTING PURPOSES 

func save_chapters_to_config_file(names_list: Node, file_path: String) -> void:
	var config_file = ConfigFile.new()
	var chapter_names: Array[String] = []
	for child in names_list.get_children():
		if child is Label:
			chapter_names.append(child.text)
	config_file.set_value("Chapters", "List", chapter_names)
	var error = config_file.save(file_path)
	if error == OK:
		print("Capítulos guardados exitosamente en:", file_path)
	else:
		print("Error al guardar los capítulos:", error)

#Load chapter names from global scope
func load_chapters_from_config_file(names_list: Node, names_Obj: PackedScene, file_path: String) -> void:
	var config_file = ConfigFile.new()
	var error = config_file.load(file_path)
	if error != OK:
		print("Error al cargar el archivo de configuración:", error)
		return
	var chapter_names = config_file.get_value("Chapters", "List", [])
	for child in names_list.get_children():
		child.queue_free()
	for name in chapter_names:
		var new_name_instance = names_Obj.instantiate()
		new_name_instance.text = name
		names_list.add_child(new_name_instance)	
	print("Capítulos cargados exitosamente desde:", file_path)
"""
