extends TextureButton

# SCENE CHANGE!
func _on_PlayButton_button_up():
	var GS = get_node("/root/GameState");
	if int(GS.currentTime) > 0:
		var master_parent = self.get_node("/root/main/master_parent");
		master_parent.add_child(master_parent.game_scene.instance());
		self.get_parent().queue_free();
	
