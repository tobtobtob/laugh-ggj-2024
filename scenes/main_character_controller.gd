extends Node2D

@onready var animation_tree = $AnimationTree
@onready var return_idle = $Timer

var active = true

func _ready():
	animation_tree.active = true

func anim_cake():
	if active:
		animation_tree["parameters/conditions/cake"] = true
		return_idle.start(0.1)
	
func anim_frog():
	if active:
		animation_tree["parameters/conditions/frog"] = true
		return_idle.start(0.1)
	
func anim_drum():
	if active: 
		animation_tree["parameters/conditions/drum"] = true
		return_idle.start(0.1)
	
func anim_sock():
	if active:
		animation_tree["parameters/conditions/sock"] = true
		return_idle.start(0.1)
	
func anim_end():
	active = false
	animation_tree["parameters/conditions/end"] = true

func _on_timer_timeout():
	animation_tree["parameters/conditions/cake"] = false
	animation_tree["parameters/conditions/sock"] = false
	animation_tree["parameters/conditions/frog"] = false
	animation_tree["parameters/conditions/drum"] = false
