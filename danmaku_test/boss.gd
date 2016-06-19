extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var bullet_scene = preload("res://bullet.scn")
var big_bullet = preload("res://big_bullet.scn")
var boss_locations = []
var curr_location = 0
var boss_movement_speed = 1

var shooter

func _ready():
	self.add_simple_shooter()
	self.add_other_shooter()
	#self.add_another_shooter()
	set_process(true)

func _process(delta):
	move_boss()


func set_boss_locations(boss_locations):
	self.boss_locations = boss_locations


func set_boss_initial_location(pos):
	set_pos(pos)


func move_boss():
	if (self.get_pos().distance_to(boss_locations[curr_location%3]) < 10):
		#shooter.toggle_enabled()
		curr_location += 1

	#var new_pos = get_transform().translated(Vector2(0, 0.8))
	var target_pos = boss_locations[curr_location%3]
	var curr_pos = self.get_pos()
	var new_pos = (target_pos - curr_pos).normalized()
	global_translate(new_pos * boss_movement_speed)


func add_simple_shooter():
	shooter = load("res://shooter.scn").instance()
	var shooter_dic = {
		"origin_node": get_parent().get_node("bulletInstancing"),
		"boss_node": get_parent().get_node("boss"),
		"bullet_scn_path": "res://big_bullet.scn",
		"bullet_quantity": 12,
		"rotation_speed": 15,
		"bullet_speed": 2,
		"shooting_interval_in_secs": 0.2,
		"enabled": true
	}
	shooter.initialize_shooter_with_dict(shooter_dic)
	self.add_child(shooter)


func add_other_shooter():
	shooter = load("res://shooter.scn").instance()
	var shooter_dic = {
		"origin_node": get_parent().get_node("bulletInstancing"),
		"boss_node": get_parent().get_node("boss"),
		"bullet_scn_path": "res://bullet.scn",
		"bullet_quantity": 6,
		"rotation_speed": 35,
		"bullet_speed": 1,
		"shooting_interval_in_secs": 0.05,
		"enabled": true
	}
	shooter.initialize_shooter_with_dict(shooter_dic)
	self.add_child(shooter)
