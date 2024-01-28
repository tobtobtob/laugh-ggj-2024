extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_frog():
	$Frog.play()

func play_drum():
	$Drum.play()

func play_cake():
	$Cake.play()

func play_sock():
	$Sock.play()

func play_laugh():
	$Laugh.play()

func play_final_theme():
	$FinalTheme.play()

func play_balloons_pop():
	$BalloonsPop.play()

func play_howl():
	$Howl.play()

func play_murina():
	$Murina.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
