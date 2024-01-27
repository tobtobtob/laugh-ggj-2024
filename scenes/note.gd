extends Node2D

enum {CAKE, DRUM, FROG, SOCK, REST}
var type

var target_position
const SPEED = 800

const FADE_SPEED = 3
var fading = false

signal entered(type)
signal exited(type)

var note_hit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	target_position = position
	match type:
		CAKE:
			$action.frame = 0
			$key.frame = 0
		DRUM:
			$action.frame = 1
			$key.frame = 1
		FROG:
			$action.frame = 2
			$key.frame = 2
		SOCK:
			$action.frame = 3
			$key.frame = 3
		REST:
			$action.frame = 4
			$key.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position.move_toward(target_position, delta * SPEED)
	if fading:
		modulate.a = max(0, modulate.a - FADE_SPEED*delta)

func _on_hitbox_body_entered(body):
	get_parent().set_current_note(body)


func _on_hitbox_body_exited(body):
	if(!body.note_hit and body.type != REST):
		print(body.note_hit)
		print(body.type)
		get_parent().lose_hp()
	body.fading = true
