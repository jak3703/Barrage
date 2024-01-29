extends Node


# scores are always in format: "{hits} {time}"
# the higher the hit / time ratio, the better the score
var currentScore = "null";

# length of timer for game. stored as string for ease of use with LineEdit
var currentTime = "60";

# if the player's drag is exactly this distance from the center of the ball,
# the velocity is maximized. also nice.
var optimalDragDistance = 420

var PLAYER_START_POS = Vector2(545, 1900);

var PLAYER_MAX_DIST = 3000;
