extends Node2D

@onready var timer = $Timer
@onready var end_screen = load("res://scenes/focus_face_effect.tscn")
@onready var end_timer = $end_timer

@export var audience_state = 0
var laughing = false
var level_completed = 0

# characters
@onready var orc_1 = $audience_orc_1
@onready var orc_2 = $audience_orc_2
@onready var wolf_1 = $audience_wolf_1
@onready var wolf_2 = $audience_wolf_2
@onready var devil_1 = $audience_devil_1
@onready var devil_2 = $audience_devil_2
@onready var viking_1 = $audience_viking_1
@onready var viking_2 = $audience_viking_2

@onready var audience = [
	orc_1, orc_2,
	wolf_1, wolf_2, 
	devil_1, devil_2,
	viking_1, viking_2,
	]
	
@onready var howling_audience = [

]

func _ready():
	pass

func set_audience_to_laughing(duration):
	level_completed = level_completed + 1
	update_audience()
	
	for character in audience:
		character.state = "laugh"
		
	for character in howling_audience:
		character.state = "howl"
	
	laughing = true
	
	timer.start(duration)
	
func update_audience():
	if level_completed >= 4:
		if audience[0] != null:
			audience.shuffle()
			howling_audience.insert(0, audience[0])
			audience.remove_at(0)
	
func set_audience_to_howling(duration):
	for character in howling_audience:
		character.state = "howl"
		
	for character in audience:
		character.state = "howl"
	
	laughing = true
	
	timer.start(duration)
		
func set_audience_to_idle():
	for character in audience:
		character.state = "idle"
		
	for character in howling_audience:
		character.state = "idle"
		
	laughing = false
	
func set_audience_to_attack():
	for character in audience:
		character.state = "attack"
		
	end_timer.start(1.0)

func change_audience_state():
	pass

func _on_timer_timeout():
	if laughing:
		set_audience_to_idle()

func _on_end_timer_timeout():
	var end_screen = end_screen.instantiate()
	add_child(end_screen)
	end_screen.position = Vector2(970,500)
