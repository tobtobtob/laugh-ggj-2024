extends Node2D

enum {CAKE, DRUM, FROG, SOCK, REST}

var test_level = [REST, REST, REST, REST, REST, DRUM, REST, DRUM,
REST, DRUM, REST, DRUM, REST, DRUM, DRUM, DRUM,
REST, DRUM, REST, DRUM, REST, DRUM, DRUM,
DRUM, REST, DRUM, REST, DRUM, REST, DRUM,
REST, REST]

var hit_effect = load("res://scenes/success_effect.tscn")
var note_scene = load("res://scenes/Note.tscn")

const QUEUE_LENGTH = 8
const QUEUE_X_OFFSET_PX = 200

var current_note = null

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
	
func lose_hp():
	$HitPoints.lose_hp()

func validate_input(action):
	if current_note and action == current_note.type:
		var hit_effect = hit_effect.instantiate()
		current_note.add_child(hit_effect)
		current_note.fading=true
		current_note.note_hit=true
		current_note = null
	else:
		lose_hp()

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

func set_current_note(note):
	current_note = note
