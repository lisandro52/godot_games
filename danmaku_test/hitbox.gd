
extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	if(is_colliding()):
		print("COLLIDING")


