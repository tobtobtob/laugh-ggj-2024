extends Node2D

@onready var animation_tree : AnimationTree = $AnimationTree
@export var state = "idle"

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree.active = true

func _process(delta):
	update_animation_state()

func update_animation_state():
	if state == "idle":
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/laugh"] = false
	elif state == "laugh":
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/laugh"] = true
