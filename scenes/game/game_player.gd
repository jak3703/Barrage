extends Control

var direction = Vector2();
var speed = 0;

func reset_player_position():
	var child = self.get_node("KinematicBody2D");
	child.set_position(Vector2(0, 0));


