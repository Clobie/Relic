extends Node2D

var water_spring = load("res://scenes/objects/water/water_spring.tscn")

@export var k = 0.015
@export var d = 0.03
@export var spread = 0.0002
@export var passes = 20
@export var spring_dist = 8
@export var spring_count = 50
@export var depth = 100
var springs = []
var target_height = global_position.y
var bottom_position = target_height + depth

@onready var water_polygon = $"Water Polygon"

func _ready() -> void:
	for x in range(spring_count):
		var pos_x = spring_dist * x
		var w = water_spring.instantiate()
		add_child(w)
		springs.append(w)
		w.initialize(pos_x, x)
		w.set_collision_width(spring_dist)
		w.connect("splash", splash)
	splash(25, 1)

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	for spring in springs:
		spring.water_update(k, d)
	var left_delta = []
	var right_delta = []
	for spring in springs:
		left_delta.append(0)
		right_delta.append(0)

	for i in range(passes):
		for x in range(springs.size()):
			if x > 0:
				left_delta[x] = spread * (springs[x].height - springs[x-1].height)
				springs[x-1].vel += left_delta[x]
			if x < springs.size() - 1:
				right_delta[x] = spread * (springs[x].height - springs[x+1].height)
				springs[x+1].vel += right_delta[x]
	draw_water_body()

func splash(index, speed):
	if index >= 0 and index < springs.size():
		springs[index].vel += speed

func draw_water_body():
	var points = []
	for i in range(springs.size()):
		points.append(springs[i].position)
	var first_index = 0
	var last_index = points.size() - 1
	var water_polygon_points = points
	water_polygon_points.append(Vector2(points[last_index].x, bottom_position))
	water_polygon_points.append(Vector2(points[first_index].x, bottom_position))
	water_polygon_points = PackedVector2Array(water_polygon_points)
	water_polygon.set_polygon(water_polygon_points)












