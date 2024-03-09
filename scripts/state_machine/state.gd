class_name State
extends Node

@onready var statemachine = get_parent()
@onready var unit = statemachine.get_parent()
@onready var animatedsprite = unit.find_child("AnimatedSprite2D")

func _ready():
	if !statemachine is StateMachine:
		print("Oops! Not a StateMachine")
	if !unit is CharacterBody2D:
		print("Oops! Not a CharacterBody2D")
	if !animatedsprite is AnimatedSprite2D:
		print("Oops! Not a AnimatedSprite2D")

func enter_state():
	pass

func exit_state():
	pass

func loop_physics_process(delta):
	pass

func loop_process(delta):
	pass
