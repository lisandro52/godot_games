extends Node2D

var orig_player_speed = 3
var slowdown_rate = 0.4 #between 0 and 1
onready var hitbox_node = get_node("hitbox_node")
onready var player_sprite = get_node("player_sprite")

func _ready():
	set_process(true)
	hitbox_node.connect("body_enter",self, "_collision_enter")


func _collision_enter(body):
	print("Colliding with ", body)


func _process(delta):
	var player_speed = self.orig_player_speed

	if(Input.is_key_pressed(KEY_SHIFT)):
		player_sprite.set_opacity(0.6)
		hitbox_node.show()
		player_speed *= self.slowdown_rate
	else:
		player_sprite.set_opacity(1)
		hitbox_node.hide()

	if(Input.is_action_pressed("ui_right")):
		set_pos(get_pos() + Vector2(player_speed, 0))

	if(Input.is_action_pressed("ui_left")):
		set_pos(get_pos() + Vector2(-player_speed, 0))

	if(Input.is_action_pressed("ui_up")):
		set_pos(get_pos() + Vector2(0, -player_speed))

	if(Input.is_action_pressed("ui_down")):
		set_pos(get_pos() + Vector2(0, player_speed))


