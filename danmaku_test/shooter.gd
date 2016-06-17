extends Node2D

var bullet_quant = 15
var rotation_speed = 10
var bullet_speed = 1
var time_interval = 1
var enabled = true

var _orig_node
var _orig_node_path
var _boss_node
var _boss_node_path
var _bullet
var _bullet_scn_path = "res://bullet.scn"

var _elapsed_time = 0
var _next_time = 0


func _ready():
	self._orig_node = get_node(self._orig_node_path)
	self._boss_node = get_node(self._boss_node_path)
	self._bullet = load(_bullet_scn_path)
	set_fixed_process(true)


func _fixed_process(delta):
	self._elapsed_time += delta
	shoot_pattern()


func enabled():
	self.enabled = true


func disabled():
	self.enabled = false


func toggle_enabled():
	self.enabled = !self.enabled


func initialize_shooter(origin_node_path, boss_node_path, bullet_scn_path, bullet_quantity = 15, rotation_speed = 10, bullet_speed = 1, shooting_interval_in_secs = 1, enabled = true):
	var shooter_dic = {
		"origin_node_path": origin_node_path,
		"boss_node_path": boss_node_path,
		"bullet_scn_path": bullet_scn_path,
		"bullet_quantity": bullet_quantity,
		"rotation_speed": rotation_speed,
		"bullet_speed": bullet_speed,
		"shooting_interval_in_secs": shooting_interval_in_secs,
		"enabled": enabled
	}
	self.initialize_shooter_with_dict(shooter_dic)


func initialize_shooter_with_dict(dic):
	self._orig_node_path = dic["origin_node_path"]
	self._boss_node_path = dic["boss_node_path"]
	self._bullet_scn_path = dic["bullet_scn_path"]

	if dic.has("bullet_quantity"):
		self.bullet_quant = dic["bullet_quantity"]

	if dic.has("rotation_speed"):
		self.rotation_speed = dic["rotation_speed"]

	if dic.has("bullet_speed"):
		self.bullet_speed = dic["bullet_speed"]

	if dic.has("shooting_interval_in_secs"):
		self.time_interval = dic["shooting_interval_in_secs"]
	
	if dic.has("enabled"):
		self.enabled = dic["enabled"]	


func shoot_pattern():
	if(self._elapsed_time > self._next_time && self.enabled):
		for i in range(0, self.bullet_quant):
			var shot = self._bullet.instance()
			self._orig_node.add_child(shot)
			shot.set_pos(self._boss_node.get_pos())
			var angle = i * (360/self.bullet_quant)
			shot.set_rot(deg2rad(angle + (self.rotation_speed * self._elapsed_time)))
			shot.set_bullet_speed(self.bullet_speed)
		self._next_time = self._elapsed_time + self.time_interval
