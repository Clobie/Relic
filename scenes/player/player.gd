extends CharacterBody2D

@onready var sprite = $Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = 200

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	var direction = Input.get_axis("a", "d")
	velocity.y += gravity * delta
	velocity.x = direction * speed
	move_and_slide()
