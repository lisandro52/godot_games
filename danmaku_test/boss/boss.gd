extends Node2D

var boss_locations = []
var curr_location = 0
var target_location
var boss_movement_speed = 3
var max_distance_to_target = 10

var seconds_to_shoot = 2
var elapsed_time = 0
var stop_shooting_at = 0

var shooting = false

var shooters = []

func _ready():
	self.add_simple_shooter()
	self.add_other_shooter()
	self.target_location = boss_locations[curr_location]
	set_process(true)


func _process(delta):
	elapsed_time += delta
	if(shooting):
		shoot()
	else:
		move_boss()


func shoot():
	if (elapsed_time > stop_shooting_at):
		stop_shooting()

func move_boss():
	var new_pos = (target_location - self.get_pos()).normalized()
	global_translate(new_pos * boss_movement_speed)

	if (self.get_pos().distance_to(self.target_location) < self.max_distance_to_target):
		start_shooting()
		load_next_location()


func load_next_location():
	curr_location += 1
	self.target_location = boss_locations[curr_location%3]


func stop_shooting():
	self.shooting = false
	self._toggle_shooters()


func start_shooting():
	self.shooting = true
	self._toggle_shooters()
	self.stop_shooting_at = self.elapsed_time + self.seconds_to_shoot


func add_simple_shooter():
	var shooter = load("res://shooters/shooter.scn").instance()
	var shooter_dic = {
		"origin_node": get_parent().get_node("bulletInstancing"),
		"boss_node": get_parent().get_node("boss"),
		"bullet_scn_path": "res://bullets/big_bullet.scn",
		"bullet_quantity": 12,
		"rotation_speed": 15,
		"bullet_speed": 2,
		"shooting_interval_in_secs": 0.5,
		"enabled": false
	}
	shooter.initialize_shooter_with_dict(shooter_dic)
	self.shooters.append(shooter)
	self.add_child(shooter)


func add_other_shooter():
	var shooter = load("res://shooters/shooter.scn").instance()
	var shooter_dic = {
		"origin_node": get_parent().get_node("bulletInstancing"),
		"boss_node": get_parent().get_node("boss"),
		"bullet_scn_path": "res://bullets/bullet.scn",
		"bullet_quantity": 6,
		"rotation_speed": 35,
		"bullet_speed": 1,
		"shooting_interval_in_secs": 0.2,
		"enabled": false
	}
	shooter.initialize_shooter_with_dict(shooter_dic)
	self.shooters.append(shooter)
	self.add_child(shooter)


func _toggle_shooters():
	for s in self.shooters:
		s.toggle_enabled()


func set_boss_locations(boss_locations):
	self.boss_locations = boss_locations


func set_boss_initial_location(pos):
	set_pos(pos)