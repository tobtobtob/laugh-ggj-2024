extends Node2D

enum {CAKE, DRUM, FROG, SOCK, REST}

var test_level = [REST, REST, REST, REST, REST, DRUM, REST, DRUM,
REST, DRUM, REST, DRUM, REST, DRUM, DRUM, DRUM,
REST, DRUM, REST, DRUM, REST, DRUM, DRUM,
DRUM, REST, DRUM, REST, DRUM, REST, DRUM,
REST, REST]

var note_scene = load("res://Scenes/Note.tscn")
var hit_effect = load("res://scenes/success_effect.tscn")

const QUEUE_LENGTH = 8
const QUEUE_X_OFFSET_PX = 200

var current_note = REST

var notes = Array()

var success = 0
var failures = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for n in QUEUE_LENGTH:
		var note = create_note(test_level.pop_front())
		note.position = position
		note.position.x = (QUEUE_LENGTH -1 -n) * QUEUE_X_OFFSET_PX
		note.target_position = note.position
		notes.append(note)

func create_note(type):
	var note = note_scene.instantiate()
	note.type = type
	add_child(note)
	return note

#this sets target positions to make notes move smoothly
func update_queue_positions():
	for i in notes.size():
		notes[i].target_position = position
		notes[i].target_position.x = (QUEUE_LENGTH -1 -i) * QUEUE_X_OFFSET_PX
		

func move_queue():
	var destroy_node = notes.pop_front()
	remove_child(destroy_node)
	if test_level.size() > 0:
		notes.append(create_note(test_level.pop_front()))
	update_queue_positions()

func validate_input(action):
	if action == current_note:
		success += 1
		$SuccessLabel.text = str(success)
		
		#effect; this needs proper position
		var hit_effect = hit_effect.instantiate()
		add_child(hit_effect)
		hit_effect.position = Vector2(960, 100)
	else:
		failures += 1
		$FailureLabel.text = str(failures)

func _process(delta):
	if Input.is_action_just_pressed("KEY_CAKE"):
		validate_input(CAKE)
	elif Input.is_action_just_pressed("KEY_SOCK"):
		validate_input(SOCK)
	elif Input.is_action_just_pressed("KEY_DRUM"):
		$Drum.play()
		validate_input(DRUM)
	elif Input.is_action_just_pressed("KEY_FROG"):
		validate_input(FROG)



func _on_conductor_beat(position):
	if position == 0:
		move_queue()

func set_current_note(type):
	current_note = type
	print(current_note)
