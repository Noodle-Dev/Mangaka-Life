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
			"text": "How does the journey begin?",
			"options": {
				"Life-changing event": 2,
				"Facing a threat": 1,
				"Solving a mystery": 1,
				"Wandering aimlessly": -1
			}
		},
		{
			"text": "Opening scene setting?",
			"options": {
				"Dark city": 2,
				"Peaceful village": 1,
				"Unique place": 1,
				"Generic background": -2
			}
		},
		{
			"text": "Protagonist's first emotion?",
			"options": {
				"Curiosity": 2,
				"Escape": 1,
				"Fear": 0,
				"Apathy": -1
			}
		},
		{
			"text": "First challenge faced?",
			"options": {
				"Overcoming fear": 2,
				"Helping someone": 1,
				"Personal failure": 0,
				"Nothing significant": -2
			}
		},
		{
			"text": "What drives the protagonist?",
			"options": {
				"Revenge": 1,
				"Discovery": 2,
				"Survival": 1,
				"Lack of purpose": -1
			}
		}
	],
	"manga_climax": [
		{
			"text": "Main conflict in climax?",
			"options": {
				"Epic battle": 2,
				"Moral dilemma": 3,
				"Big revelation": 1,
				"Predictable event": -2
			}
		},
		{
			"text": "How does the hero win?",
			"options": {
				"Skills learned": 2,
				"Allies' help": 1,
				"Clever strategy": 3,
				"Sheer luck": 0
			}
		},
		{
			"text": "Antagonist's role?",
			"options": {
				"Shows weakness": 1,
				"Reveals truth": 2,
				"Challenges hero": 3,
				"Easy to defeat": -1
			}
		},
		{
			"text": "Impact of climax on story?",
			"options": {
				"Reveals hidden truths": 3,
				"Alters relationships": 2,
				"Changes little": 0,
				"Feels pointless": -3
			}
		},
		{
			"text": "Climax environment?",
			"options": {
				"Unique and memorable": 3,
				"Dangerous and tense": 2,
				"Common setting": 0,
				"Forgettable location": -2
			}
		}
	],
	"manga_theme": [
		{
			"text": "Main theme?",
			"options": {
				"Friendship": 2,
				"Perseverance": 3,
				"Ambition's cost": 1,
				"No clear theme": -2
			}
		},
		{
			"text": "How is the theme shown?",
			"options": {
				"Character bonds": 2,
				"World's tone": 3,
				"Conflict arcs": 1,
				"Rarely explored": -1
			}
		},
		{
			"text": "What should readers feel?",
			"options": {
				"Hope": 3,
				"Empathy": 2,
				"Inspiration": 1,
				"Confusion": -2
			}
		},
		{
			"text": "Secondary themes?",
			"options": {
				"Well-integrated": 3,
				"Occasionally present": 2,
				"Not explored enough": 0,
				"Contradict the story": -2
			}
		},
		{
			"text": "Theme complexity?",
			"options": {
				"Multi-layered": 3,
				"Clear and focused": 2,
				"Simple but effective": 1,
				"Overly simplistic": -1
			}
		}
	],
	"manga_message": [
		{
			"text": "Message for readers?",
			"options": {
				"People can grow": 3,
				"Hope in darkness": 2,
				"Actions matter": 1,
				"No real message": -3
			}
		},
		{
			"text": "Ending delivers message?",
			"options": {
				"Strong resolution": 3,
				"Consequences seen": 2,
				"Reflection moment": 1,
				"Message unclear": -2
			}
		},
		{
			"text": "Readers' impression?",
			"options": {
				"Fulfilled": 3,
				"Reflective": 2,
				"Inspired": 1,
				"Disappointed": -3
			}
		},
		{
			"text": "How does the story inspire?",
			"options": {
				"Through the hero's growth": 3,
				"Overcoming challenges": 2,
				"Subtle hints": 1,
				"Lacks inspiration": -2
			}
		},
		{
			"text": "Does the message last?",
			"options": {
				"Profoundly impactful": 3,
				"Memorable": 2,
				"Briefly felt": 1,
				"Easily forgotten": -3
			}
		}
	],
	"manga_structure": [
		{
			"text": "How are chapters built?",
			"options": {
				"Great narrative": 3,
				"Consistent flow": 2,
				"Meaningful arcs": 1,
				"Disconnected": -2
			}
		},
		{
			"text": "Story pacing?",
			"options": {
				"Balanced": 2,
				"Quick-slow mix": 3,
				"Deliberate slow": 1,
				"Inconsistent": -3
			}
		},
		{
			"text": "Flashbacks used?",
			"options": {
				"Naturally placed": 2,
				"Sparingly": 3,
				"Key moments": 1,
				"Overused": -1
			}
		},
		{
			"text": "Narrative twists?",
			"options": {
				"Unpredictable and clever": 3,
				"Well-timed": 2,
				"Occasional": 1,
				"Nonexistent": -2
			}
		},
		{
			"text": "Chapter transitions?",
			"options": {
				"Seamless": 3,
				"Effective": 2,
				"Adequate": 1,
				"Jarring": -2
			}
		}
	]
};
