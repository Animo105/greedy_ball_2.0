@abstract extends RigidBody2D
class_name Ball

func _init() -> void:
	collision_mask = 1
	collision_layer = 2
	max_contacts_reported = 10
	contact_monitor = true
	var physic_material : PhysicsMaterial = PhysicsMaterial.new()
	physic_material.bounce = 0.3
	physics_material_override = physic_material
	body_entered.connect(_collision_on_module)

func _collision_on_module(body : Node):
	if body is Module:
		body.collision(self)
		collided_with(body)
		#c'est ici que je kill la balle mais genre vas falloir mieux
		if ball_health == 0:
			queue_free()

func reset():
	angular_velocity = 0
	linear_velocity = Vector2.ZERO



@export var ball_health: int = 3
@export var ball_damage: int = 1

@abstract func collided_with(module : Module)
