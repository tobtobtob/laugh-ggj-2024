extends Node2D

enum {CAKE, DRUM, FROG, SOCK, REST}

var levels = [
	[REST, REST, REST, REST, REST, DRUM, REST, DRUM,
	REST, DRUM, REST, DRUM, REST, DRUM, DRUM, DRUM,
	REST, DRUM, REST, DRUM, REST, DRUM, DRUM, DRUM,
	REST, DRUM, REST, DRUM, REST, DRUM, REST, REST]
	,
	[REST, REST, REST, REST, REST, DRUM, FROG, DRUM,
	REST, DRUM, REST, DRUM, REST, DRUM, FROG, FROG,
	REST, DRUM, FROG, FROG, DRUM, REST, DRUM, DRUM,
	REST, FROG, REST, FROG, REST, DRUM, REST, REST]
]

const LEVEL_CHANGE_TIME = 3

enum STATES {LEVEL_COMPLETED, FAILED, RUNNING, GAME_WON, GAME_OVER}

var state = STATES.RUNNING

var current_level = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	start_level()

func game_won():
	pass

func game_over():
	$Conductor.stop()
	$audience_scene.set_audience_to_attack()

func level_completed():
	print('level_completed')
	$Conductor.stop()
	current_level += 1
	if current_level >= levels.size():
		game_won()
		return
	$audience_scene.set_audience_to_laughing(LEVEL_CHANGE_TIME)
	$LevelChangeTimer.one_shot = true
	$LevelChangeTimer.start(LEVEL_CHANGE_TIME)

func start_level():
	print('start level')
	$Controller.level = levels[current_level]
	$Controller.init_queue()
	$Conductor.play_from_beat(0, 1)


func trigger_animation(type):
	match type:
		CAKE:
			$main_character.anim_cake()
		DRUM:
			$main_character.anim_drum()
		FROG:
			$main_character.anim_frog()
		SOCK:
			$main_character.anim_sock()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_change_timer_timeout():
	start_level()
