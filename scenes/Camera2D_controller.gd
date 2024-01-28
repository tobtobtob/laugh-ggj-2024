extends Camera2D

@onready var animation_tree = $AnimationTree

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree.active = true

func zoom_in():
	animation_tree["parameters/conditions/zoom_in"] = true
	animation_tree["parameters/conditions/game_camera"] = false
	
func game_camera():
	animation_tree["parameters/conditions/zoom_in"] = false
	animation_tree["parameters/conditions/game_camera"] = true
