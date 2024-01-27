extends Node2D

enum {CAKE, DRUM, FROG, SOCK, REST}

var test_level = [REST, REST, FROG, DRUM, SOCK, REST, SOCK,
REST, REST, FROG, DRUM, CAKE, REST, SOCK,
REST, REST, FROG, DRUM, SOCK, REST, SOCK,
REST, CAKE, FROG, DRUM, SOCK, REST, SOCK,
REST, CAKE, FROG, DRUM, SOCK, REST, SOCK]

var note_scene = load("res://Scenes/Note.tscn")

const QUEUE_LENGTH = 4
const QUEUE_X_OFFSET_PX = 250


var notes = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	for n in QUEUE_LENGTH:
		notes.append(create_note(test_level.pop_front()))
	update_queue_positions()

func create_note(type):
	var note = note_scene.instantiate()
	note.type = type
	add_child(note)
	return note

func update_queue_positions():
	for i in notes.size():
		notes[i].position = position
		notes[i].position.x = (QUEUE_LENGTH -1 -i) * QUEUE_X_OFFSET_PX
		

func move_queue():
	var destroy_node = notes.pop_front()
	remove_child(destroy_node)
	notes.append(create_note(test_level.pop_front()))
	update_queue_positions()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
