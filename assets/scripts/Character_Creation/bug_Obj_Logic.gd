extends Node2D
var destroyed = false

func _on_button_button_down():
	$BugAnim.play("Kill")
	#$AudioStreamPlayer2D.play()
	GlobalData.G_Reputation = GlobalData.G_Reputation + 25
	get_tree().call_group("Menu_grub", "add_orgasm_points")
	mark_as_destroyed()
	await $BugAnim.animation_finished
	queue_free()
	
func mark_as_destroyed():
	destroyed = true
