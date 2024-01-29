extends Node


var menu_scene = preload("res://scenes/menu/menu.tscn");
var game_scene = preload("res://scenes/game/game.tscn");

func _ready():
	add_child(self.menu_scene.instance());
	var f = File.new();
	f.open("user://test.txt", File.WRITE);
	f.store_string("H");
	f.close();
