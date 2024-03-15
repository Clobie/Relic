extends Node2D

@onready var collider = $Area2D/CollisionShape2D
@onready var particles = $GPUParticles2D

@export_range(0.001, 0.1) var collision_force_factor: float = 0.01

var vel: float = 0
var force: float = 0
var width: float = 0
var index: int = 0
var fixed_position: Vector2 = Vector2.ZERO
var height: float = 0

signal splash

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func initialize(pos: Vector2, id: int, width: float, depth: float) -> void:
	index = id
	position = pos
	fixed_position = pos
	collider.shape.size.x = width
	collider.shape.size.y = width
	collider.position = Vector2(0, pos.y + width / 2)

func update(k_const: float, d_damp: float) -> void:
	var y = position.y
	var ydiff = y - fixed_position.y
	var loss = -d_damp * vel
	var force = -k_const * y + loss
	vel += force
	position.y += vel
	height = fixed_position.y + position.y

func _on_area_2d_body_entered(body: Node2D) -> void:
	var speed = (body.velocity.y + -abs(body.velocity.x / 5))
	if abs(speed) > 100:
		particles.emitting = true
	speed = clamp(speed * collision_force_factor, -5, 5)
	emit_signal("splash", index, speed)
