extends Node2D

enum {CAKE, DRUM, FROG, SOCK, REST, EMPTY}

var first_theme = load("res://sounds/first_theme.wav")
var second_theme = load("res://sounds/second_theme.wav")

var first_tempo = 100
var second_tempo = 120
const THEME_CHANGE_LEVEL = 2

var levels = [
	
	[EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY,
	DRUM, REST, DRUM, REST, DRUM, DRUM, DRUM, REST,
	DRUM, REST, DRUM, REST, REST, DRUM, DRUM, REST,
	DRUM, REST, DRUM, REST, DRUM, REST, REST, DRUM,
	DRUM, DRUM, REST, DRUM, DRUM, REST, REST, REST]
	,
	[EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY,
	DRUM, REST, DRUM, REST, REST, FROG, FROG, REST,
	FROG, DRUM, DRUM, FROG, FROG, DRUM, FROG, REST,
	FROG, REST, FROG, REST, FROG, REST, REST, REST,
	DRUM, FROG, DRUM, REST, DRUM, FROG, FROG, REST],

	[EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY,
	CAKE, REST, CAKE, REST, DRUM, DRUM, REST, REST,
	CAKE, REST, CAKE, REST, DRUM, DRUM, REST, REST,
	DRUM, CAKE, CAKE, DRUM, REST, DRUM, DRUM, REST,
	CAKE, REST, REST, REST, CAKE, REST, CAKE, REST,
	DRUM, CAKE, CAKE, DRUM, REST, DRUM, DRUM, REST,
	CAKE, REST, REST, REST, CAKE, REST, CAKE, REST,
	DRUM, CAKE, CAKE, DRUM, REST, DRUM, DRUM, REST,
	CAKE, REST, REST, REST, CAKE, REST, CAKE, REST]
]

const LEVEL_CHANGE_TIME = 3

var running = true
var init_screen = true

var current_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func game_won():
	running = false
	print('game won')

func game_over():
	running = false
	print('game over')
	$Conductor.stop()
	$audience_scene.set_audience_to_attack()
	$Camera2D.zoom_in()
	$game_over_timer.start(7.0)

func level_completed():
	running = false
	print('level completed')
	$Conductor.stop()
	current_level += 1
	if current_level >= levels.size():
		game_won()
		return
	$audience_scene.set_audience_to_laughing(LEVEL_CHANGE_TIME)
	$SoundEffects.play_laugh()
	
	$Controller/HitPoints.reset_hp()
	$LevelChangeTimer.one_shot = true
	$LevelChangeTimer.start(LEVEL_CHANGE_TIME)

func start_level():
	print('start level')
	running = true
	$Controller.level = levels[current_level]
	$Controller.init_level()
	
	if current_level < THEME_CHANGE_LEVEL:
		$Conductor.init(first_theme, 100)
	elif current_level >= THEME_CHANGE_LEVEL:
		$Conductor.init(second_theme, 120)
	$Conductor.play_from_beat(0, 1)


func trigger_effect(type):
	match type:
		CAKE:
			$main_character.anim_cake()
			$SoundEffects.play_cake()
		DRUM:
			$main_character.anim_drum()
			$SoundEffects.play_drum()
		FROG:
			$main_character.anim_frog()
			$SoundEffects.play_frog()
		SOCK:
			$main_character.anim_sock()
			$SoundEffects.play_sock()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if init_screen and Input.is_action_just_pressed("KEY_DRUM"):
		init_screen = false
		start_level()

func _on_level_change_timer_timeout():
	start_level()

#reload level after dying
func _on_game_over_timer_timeout():
	get_tree().reload_current_scene()
