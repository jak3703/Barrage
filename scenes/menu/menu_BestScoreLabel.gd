extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	_load_best_score();

func _load_best_score():
	var save_game = File.new();
	var GS = get_node("/root/GameState");
	if not save_game.file_exists("user://savegame.txt"):
		self.visible = false;
		# we need this separate open because READ_WRITE won't create a file
		save_game.open("user://savegame.txt", File.WRITE);
		save_game.store_string("null");
		return
	
	# it's amazing. not only does File.READ_WRITE mode not create a new file
	# if one doesn't exist, but for some reason, all of File's built-in functions
	# to write content to a file APPEND by default, not overwrite. The word overwrite
	# doesn't even appear in File's documentation. So we do this shit instead where we
	# load and unload the score file in different modes. if i were writing more than
	# two words at a time, i'd be pissed.
	save_game.open("user://savegame.txt", File.READ);
	var best_score = save_game.get_line();
	save_game.close();
	if GS.currentScore != "null" and (best_score == "null" or calc_score(GS.currentScore) > calc_score(best_score)):
		Directory.new().remove("user://savegame.txt");
		save_game.open("user://savegame.txt", File.WRITE);
		save_game.store_string(GS.currentScore);
		get_node("./BestScore").text = get_parent().format_score(GS.currentScore);
		save_game.close();
	elif best_score != "null":
		get_node("./BestScore").text = get_parent().format_score(best_score);
	
	

func calc_score(score):
	var toks = score.split(" ");
	return float(toks[0]) / float(toks[1]);
