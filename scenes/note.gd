extends Node2D

enum {CAKE, DRUM, FROG, SOCK, REST}
var type

# Called when the node enters the scene tree for the first time.
func _ready():
	print(type)
	match type:
		CAKE:
			$action.frame = 0
			$key.frame = 0
		DRUM:
			$action.frame = 1
			$key.frame = 1
		FROG:
			$action.frame = 2
			$key.frame = 2
		SOCK:
			$action.frame = 3
			$key.frame = 3
		REST:
			$action.frame = 4
			$key.visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
