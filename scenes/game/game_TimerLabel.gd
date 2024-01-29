extends Label


func _process(_delta):
	var timer = get_node("../Timer");
	if timer:
		self.text = str(int(timer.time_left));

