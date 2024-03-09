extends State

# unit: CharacterBody2D
# statemachine: StateMachine
# anim: AnimatedSprite2D
# anim_name: String

func _ready():
	super()
	anim_name = ""

func enter_state():
	anim.play(anim_name)

func exit_state():
	pass

func loop_physics_process(delta):
	pass

func loop_process(delta):
	pass
