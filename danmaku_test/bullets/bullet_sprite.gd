extends Sprite


func _ready():
	pass


func change_sprite_rect(x, y, width, height):
	set_region_rect(Rect2(x, y, width, height))