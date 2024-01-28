extends Node2D

@onready var jokes_timer = $jokes_timer
@onready var on_timer = $on_timer
@onready var you_timer = $you_timer
@onready var credits_timer = $credits_timer

func _ready():
	$jokes.hide()
	$on.hide()
	$you.hide()
	$credits.hide()
	
func start_logo_reveal():
	jokes_timer.start(2.0)
	on_timer.start(3.0)
	you_timer.start(4.0)
	credits_timer.start(6.0)

func reveal_jokes():
	$jokes.show()
	
func reveal_on():
	$on.show()
	
func reveal_you():
	$you.show()
	
func reveal_credits():
	$credits.show()

#jokes
func _on_jokes_timer_timeout():
	reveal_jokes()

#on
func _on_on_timer_timeout():
	reveal_on()

#you
func _on_you_timer_timeout():
	reveal_you()
	
#credits
func _on_credits_timer_timeout():
	reveal_credits()
