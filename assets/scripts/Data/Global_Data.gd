extends Node
var G_Balance = 500
var G_Reputation = 0
var G_Chap_Wrote = 0

var G_FinalScore = 0

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
		}
	]
}
