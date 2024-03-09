extends State

# unit: CharacterBody2D
# statemachine: StateMachine
# anim: AnimatedSprite2D
# anim_name: String

func _ready():
	super()
	anim_name = "air_roll"

func enter_state():
	anim.play(anim_name)
	unit.velocity.y = -unit.double_jump_force
	unit.can_double_jump = false

func exit_state():
	pass

func loop_physics_process(delta):
	if unit.is_on_floor():
		unit.can_double_jump = true
		statemachine.set_state("idle")
	if unit.velocity.y > 0:
		statemachine.set_state("fall")
	unit.apply_gravity(delta)
	unit.velocity.x = clamp(
		unit.velocity.x + unit.move_axis() * unit.run_speed * delta * 0.1,
		-unit.run_speed * delta,
		unit.run_speed * delta
	)
	if unit.is_on_floor():
		unit.can_jump = true
		unit.can_double_jump = true

func loop_process(delta):
	pass
