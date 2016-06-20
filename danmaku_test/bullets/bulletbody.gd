
extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var speed = 1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)

func _fixed_process(delta):
	move(Vector2(0, speed))

