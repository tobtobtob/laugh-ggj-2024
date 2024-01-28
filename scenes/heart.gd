extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$sprite.frame = 0

func break_heart():
	$sprite.frame = 1

func refresh_heart():
	$sprite.frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
