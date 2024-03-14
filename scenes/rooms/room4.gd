extends Node2D

@onready var global_light = $DirectionalLight2D

func _ready() -> void:
	global_light.visible = true


func _process(delta: float) -> void:
	pass
