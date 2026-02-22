@abstract extends RigidBody2D
class_name Ball

func _init() -> void:
	body_entered.connect(_collision_on_module)

func _collision_on_module(body : Node):
	if body is Module:
		body.collision(self)

@export var value : int = 0
@export var speed : float = 1.0
