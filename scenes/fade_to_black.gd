extends Node2D

@onready var animation_tree = $AnimationTree

func _ready():
	animation_tree.active = true
	fade_to_none()

func fade_to_black():
	animation_tree["parameters/conditions/fade_to_black"] = true
	animation_tree["parameters/conditions/fade_to_none"] = false
	
func fade_to_none():
	animation_tree["parameters/conditions/fade_to_none"] = false
	animation_tree["parameters/conditions/fade_to_none"] = true
