extends State

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func enter_state():
	animatedsprite.play("idle")

func exit_state():
	pass

func loop_physics_process(delta):
	if !unit.is_on_floor():
		unit.velocity.y += gravity * delta

func loop_process(delta):
	pass
