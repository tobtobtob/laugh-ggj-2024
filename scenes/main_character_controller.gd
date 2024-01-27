extends Node2D

@onready var animation_tree = $AnimationTree
@onready var return_idle = $Timer

func _ready():
	animation_tree.active = true

func anim_cake():
	animation_tree["parameters/conditions/cake"] = true
	return_idle.play(0.1)
	
func anim_frog():
	animation_tree["parameters/conditions/frog"] = true
	return_idle.play(0.1)
	
func anim_drum():
	animation_tree["parameters/conditions/drum"] = true
	return_idle.play(0.1)
	
func anim_sock():
	animation_tree["parameters/conditions/sock"] = true
	return_idle.play(0.1)

func _on_timer_timeout():
	animation_tree["parameters/conditions/cake"] = false
	animation_tree["parameters/conditions/sock"] = false
	animation_tree["parameters/conditions/frog"] = false
	animation_tree["parameters/conditions/drum"] = false
