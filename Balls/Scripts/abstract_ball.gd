@abstract extends RigidBody2D
class_name Ball

func _init() -> void:
	max_contacts_reported = 10
	contact_monitor = true
	body_entered.connect(_collision_on_module)

func _collision_on_module(body : Node):
	if body is Module:
		body.collision(self)

func reset():
	angular_velocity = 0
	linear_velocity = Vector2.ZERO

@export var value : int = 0
@export var speed : float = 1.0
