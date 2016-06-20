extends Node2D

func _ready():
	var boss_node = get_node("boss_node")
	var boss_scn = load("res://boss/boss.scn").instance()
	boss_scn.get_node("boss").set_boss_locations([
		get_node("/root/base/boss_locations/location1").get_pos(),
		get_node("/root/base/boss_locations/location2").get_pos(),
		get_node("/root/base/boss_locations/location3").get_pos()
	])
	boss_scn.get_node("boss").set_boss_initial_location(get_node("boss_locations/location3").get_pos())
	boss_node.add_child(boss_scn)

	var player_scn = load("res://player/player.scn").instance()
	get_node("player_node").add_child(player_scn)


