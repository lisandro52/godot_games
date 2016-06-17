extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var bullet_scene = preload("res://bullet.scn")
var big_bullet = preload("res://big_bullet.scn")
var boss_locations
var curr_location = 0
var boss_movement_speed = 1

var shooter

func _ready():
	boss_locations = [
		get_node("/root/base/boss_locations/location1").get_pos(),
		get_node("/root/base/boss_locations/location2").get_pos(),
		get_node("/root/base/boss_locations/location3").get_pos()
	]
	shooter = load("res://shooter.scn").instance()
	var shooter_dic = {
		"origin_node_path": "/root/base/bulletInstancing",
		"boss_node_path": "/root/base/boss",
		"bullet_scn_path": "res://bullet.scn",
		"bullet_quantity": 8,
		"rotation_speed": 20,
		"bullet_speed": 1.5,
		"shooting_interval_in_secs": 0.5,
		"enabled": true
	}
	shooter.initialize_shooter_with_dict(shooter_dic)
	self.add_child(shooter)
	set_fixed_process(true)

func _fixed_process(delta):
	move_boss()

func move_boss():
	if (self.get_pos().distance_to(boss_locations[curr_location%3]) < 10):
		shooter.toggle_enabled()
		curr_location += 1

	#var new_pos = get_transform().translated(Vector2(0, 0.8))
	var target_pos = boss_locations[curr_location%3]
	var curr_pos = self.get_pos()
	var new_pos = (target_pos - curr_pos).normalized()
	global_translate(new_pos * boss_movement_speed)

