extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var queue = get_parent()
	position = queue.position
	position.x += (queue.QUEUE_LENGTH -1 ) * queue.QUEUE_X_OFFSET_PX


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
