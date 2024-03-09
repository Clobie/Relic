extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var jump_force: float = 300.0
var can_jump: bool = true

var double_jump_force: float = 250.0
var can_double_jump: bool = true

var run_speed: float = 11000.0
var can_run: bool = true

var look_right: bool = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	pass

func move_axis():
	var axis = Input.get_axis("a", "d")
	if axis != 0:
		anim.scale.x = anim.scale.y * axis
	return axis

func jump() -> bool:
	return can_jump and is_on_floor() and Input.is_action_just_pressed("space")

func double_jump() -> bool:
	return can_double_jump and Input.is_action_just_pressed("space")

func apply_gravity(delta):
	velocity.y += gravity * delta

func apply_friction(delta):
	velocity.move_toward(Vector2(0,0), 1.0)
