extends Label


func _ready():
	var GS = get_node("/root/GameState");
	if GS.currentScore == "null":
		self.visible = false;
	else:
		self.visible = true;
		get_node("./LastScore").text = get_node('/root/main/master_parent/menu').format_score(str(GS.currentScore));
