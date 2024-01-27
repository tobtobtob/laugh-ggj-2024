extends Node2D

@onready var animation_tree : AnimationTree = $AnimationTree
@export var state = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree.active = true
	
func _process(delta):
	update_animation_state()

func update_animation_state():
	if state == 0:
		animation_tree["parameters/conditions/happy"] = true
		animation_tree["parameters/conditions/laughing"] = false
	elif state == 1:
		animation_tree["parameters/conditions/laughing"] = true
		animation_tree["parameters/conditions/happy"] = false
