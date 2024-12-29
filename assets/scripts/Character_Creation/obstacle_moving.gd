extends Node2D


var move_speed = 600
var lifespan = 10

func _physics_process(delta):
	position.x -= move_speed * delta
	lifespan -= delta


func _on_timer_timeout():
	queue_free()