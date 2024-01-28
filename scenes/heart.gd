extends Node2D

@onready var animation_tree = $sprite/AnimationTree

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree.active = true

func break_heart():
	animation_tree["parameters/conditions/alive"] = false
	animation_tree["parameters/conditions/break"] = true

func refresh_heart():
	animation_tree["parameters/conditions/alive"] = true
	animation_tree["parameters/conditions/break"] = false
