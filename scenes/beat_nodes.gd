extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_conductor_beat(position):
	#move only on half beats
	if position == 0:
		$Queue.move_queue()