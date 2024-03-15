extends Node2D

var spring_scene = load("res://scenes/objects/water/spring.tscn")

@onready var rect = $ColorRect
@onready var polygon2d = $Polygon2D
@onready var line2d = $Line2D

@export_range (1, 1000) var num_points: int = 20
@export_range (0.001, 0.1) var k: float = 0.015
@export_range(0.001, 0.1) var d: float = 0.03
@export_range (0.01, 1.0) var spread: float = 0.1
@export_range (1, 20) var passes: int = 1
@export_range (2, 32) var min_spring_space: int = 8

var depth = 0
var width = 0
var spring = []

func _ready() -> void:
	rect.visible = false
	depth = rect.size.y
	width = rect.size.x
	var spring_dist = width / num_points
	for i in range(num_points + 1):
		var x = spring_dist * i
		var child = spring_scene.instantiate()
		add_child(child)
		spring.append(child)
		child.initialize(Vector2(x, 0), i, spring_dist, depth)
		child.connect("splash", splash)


func _physics_process(delta: float) -> void:
	for s in spring:
		s.update(k, d)

	var left_delta = []
	var right_delta = []
	for s in spring:
		left_delta.append(0)
		right_delta.append(0)

	for i in range(passes):
		for j in range(spring.size()):
			if j > 0:
				left_delta[j] = spread * (spring[j].position.y - spring[j-1].position.y)
				spring[j-1].vel += left_delta[j]
			if j < spring.size() - 1:
				right_delta[j] = spread * (spring[j].position.y - spring[j+1].position.y)
				spring[j+1].vel += right_delta[j]

	var points = []
	for i in range(spring.size()):
		points.append(spring[i].position)

	var first_index = 0
	var last_index = points.size() - 1
	var water_polygon_points = points
	var water_line_points = points
	line2d.points = water_line_points
	water_polygon_points.append(Vector2(points[last_index].x, depth))
	water_polygon_points.append(Vector2(points[first_index].x, depth))
	water_polygon_points = PackedVector2Array(water_polygon_points)
	water_line_points = PackedVector2Array(water_line_points)
	polygon2d.set_polygon(water_polygon_points)

func splash(index, speed):
	if index >= 0 and index < spring.size():
		spring[index].vel += speed
