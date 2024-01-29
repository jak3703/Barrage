extends KinematicBody2D

onready var GS = get_node("/root/GameState");
var direction = Vector2();
var speed = 0

func _physics_process(delta):
	var velocity = direction.normalized() * speed;
	#print(str(direction.x) + " " + str(direction.y));
	#print(speed);
	var collision = move_and_collide(velocity * delta);
	if collision:
		stop_move();
		get_parent().reset_player(true);
	elif GS.PLAYER_START_POS.distance_to(self.get_position()) > GS.PLAYER_MAX_DIST:
		stop_move();
		get_parent().reset_player(false);

func stop_move():
	speed = 0;
	direction = Vector2();
