class_name StateMachine
extends Node

@export var state: State
@export var default_state: String = "default"

var states: Dictionary

@export var unit: CharacterBody2D

func _ready() -> void:
	set_state(default_state)
	for child in get_children():
		if child is State:
			states[child.name] = child

func _process(delta: float) -> void:
	state.loop_process(delta)

func _physics_process(delta: float) -> void:
	state.loop_physics_process(delta)
	state.unit.move_and_slide()

func set_state(new_state: String):
	if states.has(new_state):
		state.exit_state()
		state = states[new_state]
		state.enter_state()

func get_state():
	return state.name
