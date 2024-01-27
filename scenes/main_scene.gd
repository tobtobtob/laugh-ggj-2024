extends Node2D

enum {CAKE, DRUM, FROG, SOCK, REST}

var levels = [
	[REST, REST, REST, REST, REST, DRUM, REST, DRUM,
	REST, DRUM, REST, DRUM, REST, DRUM, DRUM, DRUM,
	REST, DRUM, REST, DRUM, REST, DRUM, DRUM, DRUM,
	REST, DRUM, REST, DRUM, REST, DRUM, REST, REST]
	,
	[REST, REST, REST, REST, REST, DRUM, REST, DRUM,
	REST, DRUM, REST, DRUM, REST, DRUM, DRUM, DRUM,
	REST, DRUM, REST, DRUM, REST, DRUM, DRUM, DRUM,
	REST, DRUM, REST, DRUM, REST, DRUM, REST, REST]
]


enum STATES {LEVEL_COMPLETED, FAILED, RUNNING, GAME_WON}

var state
var level = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Conductor.play_from_beat(0, 1)

func level_completed():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
