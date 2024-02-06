extends Node

onready var GS = get_node("/root/GameState");
var hits = 0;
var current_target = null;
var TARGET_NODE = preload("res://scenes/game/target/target.tscn");
var PLAYER_RADIUS = 75;
onready var PLAYER_START_POS: Vector2 = get_node('player').rect_position;

# Called when the node enters the scene tree for the first time.
func _ready():
	_game_init();

func spawn_target():
	var new_target = TARGET_NODE.instance();
	var target_radius = new_target.get_target_radius();
	var x = randi() % (1080 - 2*target_radius) + target_radius;
	var y = randi() % (1200 - 2*target_radius) + target_radius;
	var new_target_pos = Vector2(x, y);
	new_target.get_node("StaticBody2D").set_position(new_target_pos);
	self.add_child(new_target);
	current_target = new_target;

func _game_init():
	# reset the current score
	GS.currentScore = "0 " + GS.currentTime;
	
	var player = self.get_node('player');
	#player.set_position(GS.PLAYER_START_POS);
	PLAYER_RADIUS = int(ceil(player.get_node("KinematicBody2D/Sprite").texture.get_width() / 2));
	
	spawn_target();
	
	var timer = self.get_node("./Timer");
	timer.one_shot = true;
	timer.wait_time = int(GS.currentTime);
	timer.start();

# the game ends when the timer is up
func _on_Timer_timeout():
	_game_over();

func _game_over():
	# set the score to show the player in menu
	GS.currentScore = str(hits) + " " + GS.currentTime;
	
	var master_parent = self.get_node("/root/main/master_parent");
	master_parent.add_child(master_parent.menu_scene.instance());
	self.queue_free();
	

func get_drag_data(position: Vector2):
	var inXBounds: bool = position.x >= PLAYER_START_POS.x - PLAYER_RADIUS and position.x <= PLAYER_START_POS.x + PLAYER_RADIUS;
	var inYBounds: bool = position.y >= PLAYER_START_POS.y - PLAYER_RADIUS and position.y <= PLAYER_START_POS.y + PLAYER_RADIUS;
	if inXBounds and inYBounds:
		var canLaunch = true;
		# can_drop_data is only called if get_drag_data returns a data value for it. 
		# so we can stop the drag in its tracks if it doesn't start in the sprite node.
		return canLaunch;

func can_drop_data(_position: Vector2, _data):
	return true;

func drop_data(position: Vector2, _data):
	# commence launch
	var dist_from_ball_X = position.x - PLAYER_START_POS.x;
	var dist_from_ball_Y = position.y - PLAYER_START_POS.y;
	var ball_vector = Vector2(dist_from_ball_X, dist_from_ball_Y);
	var drag_dist = ball_vector.distance_to(Vector2(0, 0));
	var launch_power = compute_launch_power(drag_dist, GS.optimalDragDistance);
	#print(str(ball_vector.x) + " " + str(ball_vector.y));
	#print(drag_dist);
	#print(launch_power);
	if launch_power == 0:
		return;
	var player_node = get_node("./player");
	player_node.speed = launch_power;
	player_node.direction = ball_vector;
	
	

func compute_launch_power(drag_dist, optimal_dist):
	var power = -0.011536*pow(optimal_dist - drag_dist, 2) + 1800;
	if power <= 0:
		return 0;
	return power;

func reset_player(isHit: bool):
	if isHit:
		hits += 1;
		current_target.queue_free();
		spawn_target();
	get_node("./player").set_position(PLAYER_START_POS);
