extends Node2D

var hit_effect = load("res://scenes/success_effect.tscn")
@onready var start_timer = $Timer

var tutorial_started = false

func _ready():
	$press.hide()
	$drum.hide()
	start_timer.start(3.0)
	
func show_tutorial():
	$press.show()
	$drum.show()

func complete():
	var hit_effect = hit_effect.instantiate()
	add_child(hit_effect)
	$press.hide()
	hit_effect.scale = Vector2(0.8, 0.8)
	hit_effect.position = Vector2(28, -153)
	$drum.hide()

func _on_timer_timeout():
	show_tutorial()
	tutorial_started = true
