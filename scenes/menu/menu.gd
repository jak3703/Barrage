extends Node


func format_score(raw_score):
	var score_toks = raw_score.split(" ");
	return "{hits} in {time}s".format({"hits": score_toks[0], "time": score_toks[1]});
