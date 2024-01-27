extends Node2D

@export var audience_state = 2

# characters
@onready var test_orc = $test_orc_1
@onready var orcs = [test_orc]

func _ready():
	$Timer.start(2.0)

func level_completed_reaction():
	pass

func change_audience_state():
	pass
	
func orcs_laugh():
	for orc in orcs:
		if orc.state == 0:
			orc.state = 1
		else:
			orc.state = 0
	
func _on_timer_timeout():
	orcs_laugh()
	$Timer.start(2.0)
