extends Label

var elapsed_time = 0
var next_time = 0
var interval = 1
var times_checked = 1
var min_nodes = 9999
var max_nodes = -1
var avg_nodes = 0
var sum_nodes = 0
onready var bullet_origin = get_parent().get_node("bulletInstancing")

func _ready():
	set_process(true)


func _process(delta):
	elapsed_time += delta

	if (elapsed_time > next_time):
		var current_nodes = bullet_origin.get_child_count()
		sum_nodes += current_nodes
		times_checked += 1
		avg_nodes = sum_nodes / times_checked
		if (current_nodes < min_nodes):
			min_nodes = current_nodes
		if (current_nodes > max_nodes):
			max_nodes = current_nodes

		var text = ""
		text += "Max nodes: "+var2str(max_nodes)+"\n"
		text += "Min nodes: "+var2str(min_nodes)+"\n"
		text += "Avg nodes: "+var2str(avg_nodes)+"\n"
		text += "Curr nodes: "+var2str(current_nodes)
		self.set_text(text)
		next_time = elapsed_time + interval



