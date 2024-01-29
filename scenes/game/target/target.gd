extends Node


func get_target_radius():
	return int(ceil(self.get_node("StaticBody2D/Sprite").texture.get_width() / 2));
