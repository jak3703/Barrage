extends LineEdit


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _ready():
	self.text = self.get_node("/root/GameState").currentTime;


func _on_LineEdit_text_changed(new_text):
	var cursorPos = self.caret_position;
	var regex = RegEx.new();
	regex.compile("\\D");
	if regex.search(new_text):
		new_text.erase(cursorPos-1, 1);
		self.text = new_text;
	self.get_node("/root/GameState").currentTime = self.text;
