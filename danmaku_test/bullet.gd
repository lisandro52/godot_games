extends Node2D

var speed = 1

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	set_transform(get_transform().translated(Vector2(self.speed, 0)))

func set_bullet_speed(speed):
	self.speed = speed




