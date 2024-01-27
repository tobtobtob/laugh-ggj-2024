#extends Node2D
#
#var hit_effect = load("res://scenes/success_effect.tscn")
#var screen_width = ProjectSettings.get("display/window/size/viewport_width")
#var screen_height = ProjectSettings.get("display/window/size/viewport_height")
#
#func _on_test_timer_timeout():
	#var hit_effect = hit_effect.instantiate()
	#add_child(hit_effect)
	#hit_effect.position = Vector2(screen_width / 2, 150)
	#pass
