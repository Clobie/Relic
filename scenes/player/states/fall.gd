extends State

# unit: CharacterBody2D
# statemachine: StateMachine
# anim: AnimatedSprite2D
# anim_name: String

@onready var dir_speed_change: float = 0.075

@onready var jump_mid_threshhold: float = 200.0

func _ready():
	super()
	if unit.velocity.y < jump_mid_threshhold:
		anim_name = "jump_start"
	elif unit.velocity.y > jump_mid_threshhold:
		anim_name = "jump_fall"
	else:
		anim_name = "jump_mid"

func enter_state():
	anim.play(anim_name)

func exit_state():
	pass

func loop_physics_process(delta):
	if unit.velocity.y < jump_mid_threshhold:
		anim_name = "jump_start"
	elif unit.velocity.y > jump_mid_threshhold:
		anim_name = "jump_fall"
	else:
		anim_name = "jump_mid"
	anim.play(anim_name)

	if unit.is_on_floor():
		unit.can_jump = true
		unit.can_double_jump = true
		unit.velocity.y = 0
		statemachine.set_state("idle")

	if unit.double_jump() and unit.can_double_jump:
		statemachine.set_state("double_jump")

	unit.apply_gravity(delta)
	unit.velocity.x = clamp(
		unit.velocity.x + unit.move_axis() * unit.run_speed * delta * dir_speed_change,
		-unit.run_speed * delta,
		unit.run_speed * delta
	)

func loop_process(delta):
	pass