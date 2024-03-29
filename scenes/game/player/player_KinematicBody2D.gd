extends KinematicBody2D

onready var GS = get_node("/root/GameState");

func _physics_process(delta):
	var velocity = get_parent().direction.normalized() * get_parent().speed;
	var collision = move_and_collide(velocity * delta);
	var game_node = get_node('/root/main/master_parent/game');
	var dist_traveled = Vector2(0, 0).distance_to(self.get_position());
	if collision:
		stop_move();
		get_node('/root/main/master_parent/game').reset_player(true);
	elif dist_traveled > GS.PLAYER_MAX_DIST:
		stop_move();
		get_node('/root/main/master_parent/game').reset_player(false);

func stop_move():
	get_parent().speed = 0;
	get_parent().direction = Vector2();
