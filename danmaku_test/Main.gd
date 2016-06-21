extends Node2D

onready var boss_node = get_node("boss_node")
onready var player_node = get_node("player_node")
var player_sprite_node

func _ready():
	initialize_scene()


func initialize_scene():
	add_new_boss()
	var player_scn = load("res://player/player.scn").instance()
	player_scn.get_node("player").add_main_scene(get_node("."))
	player_sprite_node = player_scn.get_node("player")
	player_node.add_child(player_scn)


func add_new_boss():
	var boss_scn = load("res://boss/boss.scn").instance()
	boss_scn.get_node("boss").set_boss_locations([
		get_node("/root/base/boss_locations/location1").get_pos(),
		get_node("/root/base/boss_locations/location2").get_pos(),
		get_node("/root/base/boss_locations/location3").get_pos()
	])
	boss_scn.get_node("boss").set_boss_initial_location(get_node("boss_locations/location3").get_pos())
	boss_node.add_child(boss_scn)


func restart_scene():
	remove_boss_object()
	add_new_boss()
	reset_player_pos()


func remove_boss_object():
	boss_node.remove_child(boss_node.get_child(0))


func reset_player_pos():
	player_sprite_node.set_pos(Vector2(0,0))


