extends Node2D

var vel = 0
var force = 0
var height = 0
var target_height = 0

var index = 0
var motion_factor = 0.0025
signal splash

@onready var collider = $Area2D/CollisionShape2D

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func water_update(spring_constant, dampening):
	height = position.y
	var x = height - target_height
	var loss = -dampening * vel
	force = -spring_constant * x + loss
	vel += force
	position.y += vel

func initialize(pos_x, id):
	height = position.y
	target_height = position.y
	vel = 0
	position.x = pos_x
	index = id

func set_collision_width(value: float) -> void:
	collider.shape.size.x = value
	collider.shape.size.y = 1


func _on_area_2d_body_entered(body: Node2D) -> void:
	var speed = body.velocity.y * motion_factor
	emit_signal("splash", index, speed)
