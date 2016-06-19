extends Node2D

var speed = 1
onready var screen_rect = get_viewport_rect()

func _ready():
	set_process(true)

func _process(delta):
	set_transform(get_transform().translated(Vector2(self.speed, 0)))
	if(!self.screen_rect.has_point(self.get_pos())):
		self.queue_free()


func set_bullet_speed(speed):
	self.speed = speed

