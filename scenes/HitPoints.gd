extends Node2D

var Heart = load("res://scenes/heart.tscn")

const START_HP = 3
const HEART_X_OFFSET_PX = 100

var current_hp = START_HP
var hearts = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	init_hearts()

func init_hearts():
	hearts = Array()
	for n in current_hp:
		var new_heart = Heart.instantiate()
		new_heart.position.x += n*HEART_X_OFFSET_PX
		hearts.append(new_heart)
		add_child(new_heart)

func reset_hp():
	current_hp = START_HP
	for heart in hearts:
		heart.refresh_heart()

func get_hp():
	return current_hp

func lose_hp():
	current_hp -= 1
	if (current_hp >= 0):
		hearts[current_hp].break_heart()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
