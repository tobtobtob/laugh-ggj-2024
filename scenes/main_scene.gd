extends Node2D

enum {CAKE, DRUM, FROG, SOCK, REST, EMPTY}

var first_theme = load("res://sounds/first_theme.wav")
var second_theme = load("res://sounds/second_theme.wav")

var first_tempo = 100
var second_tempo = 120
const THEME_CHANGE_LEVEL = 9

var current_level = 0

var levels = [
	#level 0: learn drum
	[EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY,
	DRUM, REST, DRUM, REST, DRUM, DRUM, DRUM, REST,
	DRUM, REST, DRUM, REST, REST, DRUM, DRUM, REST,
	DRUM, REST, DRUM, REST, DRUM, REST, REST, DRUM,
	DRUM, DRUM, REST, DRUM, DRUM, REST, REST, REST],
	#level 1: learn frog
	[EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY,
	DRUM, REST, DRUM, REST, REST, FROG, FROG, REST,
	FROG, DRUM, DRUM, FROG, FROG, DRUM, FROG, REST,
	FROG, REST, FROG, REST, FROG, REST, REST, REST,
	DRUM, FROG, DRUM, REST, DRUM, FROG, FROG, REST],
	#LEVEL 2: learn sock
	[EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY,
	SOCK, SOCK, SOCK, SOCK, REST, REST, SOCK, DRUM,
	REST, SOCK, DRUM, REST, SOCK, DRUM, REST, SOCK,
	SOCK, SOCK, SOCK, REST, REST, SOCK, DRUM, DRUM,
	DRUM, DRUM, DRUM, SOCK, DRUM, DRUM, DRUM, SOCK],
	#level 3: three instruments
	[EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY,
	SOCK, SOCK, DRUM, FROG, REST, DRUM, FROG, REST,
	SOCK, SOCK, DRUM, FROG, REST, DRUM, FROG, REST,
	SOCK, SOCK, DRUM, DRUM, REST, SOCK, SOCK, REST,
	SOCK, SOCK, DRUM, DRUM, REST, REST, FROG, FROG],
	#level 4: learn cake
	[EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY,
	CAKE, REST, CAKE, REST, CAKE, REST, FROG, REST,
	CAKE, REST, CAKE, REST, CAKE, REST, FROG, REST,
	CAKE, CAKE, FROG, FROG, REST, REST, CAKE, CAKE,
	FROG, FROG, REST, CAKE, CAKE, CAKE, CAKE, FROG],
	#level 6: socks and frog and surprise cake
	[EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY,
	SOCK, FROG, SOCK, FROG, REST, FROG, FROG, REST,
	SOCK, FROG, SOCK, FROG, REST, SOCK, SOCK, REST,
	FROG, FROG, SOCK, SOCK, FROG, SOCK, FROG, SOCK,
	FROG, SOCK, REST, SOCK, FROG, REST, FROG, CAKE],
	#level 7: three instruments
	[EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY,
	SOCK, CAKE, FROG, REST, REST, REST, REST, REST,
	SOCK, CAKE, FROG, REST, REST, REST, REST, REST,
	SOCK, CAKE, FROG, REST, REST, REST, REST, REST,
	SOCK, CAKE, FROG, REST, SOCK, CAKE, FROG, REST],
	#level 8: all instruments
	[EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY,
	DRUM, DRUM, FROG, FROG, REST, REST, CAKE, REST,
	SOCK, SOCK, FROG, FROG, REST, REST, CAKE, REST,
	DRUM, DRUM, FROG, FROG, REST, REST, CAKE, REST,
	SOCK, SOCK, REST, REST, SOCK, FROG, CAKE, DRUM],
	#FIRST ACTUAL LEVEL
	[EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY,
	CAKE, REST, CAKE, REST, DRUM, DRUM, REST, REST,
	CAKE, REST, CAKE, REST, DRUM, DRUM, REST, REST,
	DRUM, CAKE, CAKE, DRUM, REST, DRUM, DRUM, REST,
	CAKE, REST, REST, REST, CAKE, REST, CAKE, REST,
	DRUM, CAKE, CAKE, DRUM, REST, DRUM, DRUM, REST,
	CAKE, REST, REST, REST, CAKE, REST, CAKE, REST,
	DRUM, CAKE, CAKE, DRUM, REST, DRUM, DRUM, REST,
	CAKE, REST, REST, REST, CAKE, REST, CAKE, REST],
	#asd and das
	[EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY,
	CAKE, SOCK, DRUM, REST, CAKE, SOCK, DRUM, REST,
	CAKE, SOCK, DRUM, REST, DRUM, SOCK, CAKE, REST,
	CAKE, CAKE, SOCK, DRUM, DRUM, SOCK, CAKE, CAKE,
	REST, CAKE, SOCK, DRUM, REST, CAKE, SOCK, DRUM,
	REST, CAKE, DRUM, DRUM, CAKE, SOCK, REST, CAKE,
	CAKE, CAKE, CAKE, REST, REST, SOCK, SOCK, SOCK,
	REST, REST, DRUM, DRUM, DRUM, REST, DRUM, CAKE,
	REST, CAKE, REST, REST, CAKE, REST, DRUM, DRUM],
	#LAST LEVEL VERY HARD
	[EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY,
	FROG, CAKE, DRUM, SOCK, REST, REST, FROG, CAKE,
	DRUM, SOCK, REST, REST, FROG, CAKE, REST, DRUM,
	SOCK, REST, FROG, CAKE, DRUM, SOCK, REST, REST,
	FROG, DRUM, SOCK, CAKE, REST, CAKE, SOCK, REST,
	DRUM, FROG, REST, FROG, CAKE, REST, DRUM, SOCK,
	REST, FROG, CAKE, DRUM, SOCK, REST, REST, REST,
	DRUM, DRUM, DRUM, DRUM, CAKE, FROG, SOCK, REST,
	DRUM, DRUM, DRUM, DRUM, CAKE, FROG, REST, FROG],
]

const LEVEL_CHANGE_TIME = 3

var running = true
var init_screen = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func game_won():
	running = false
	start_ending()
	print('game won')

func game_over():
	running = false
	print('game over')
	$SoundEffects.stop_ambience()
	$SoundEffects.play_murina()
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
	$SoundEffects.stop_ambience()
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
	$SoundEffects.play_ambience()
	
@onready var end_character_timer = $end_timer_character_mark	

func start_ending():
	$audience_scene.set_audience_to_howling(12.0)
	$Camera2D.start_end_zoom()
	$SoundEffects.play_howl()
	end_character_timer.start(12.0)

#ending timer
func _on_end_timer_character_mark_timeout():
	$SoundEffects.play_balloons_pop()
	$main_character.anim_end()
	$ending.start_logo_reveal()

func start_final_theme():
	$SoundEffects.play_final_theme()

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
	if init_screen and $tutorial.tutorial_started and Input.is_action_just_pressed("KEY_DRUM"):
		$Camera2D.game_starts()
		$tutorial.complete()
		init_screen = false
		start_level()

func _on_level_change_timer_timeout():
	start_level()

#reload level after dying
func _on_game_over_timer_timeout():
	get_tree().reload_current_scene()
