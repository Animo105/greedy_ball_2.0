extends LeftPaddle

@onready var area_2d: Area2D = $Area2D
@onready var paddle: Node2D = $Paddle
@onready var paddle_collider: CollisionPolygon2D = $Paddle/StaticBody2D/CollisionShape2D


@export var launch_power : int = 500

var tween : Tween

func action_pressed():
	if tween:
		tween.kill()
	tween = create_tween()
	
	tween.tween_property(paddle, "rotation_degrees", -30, 0.1)
	for body in area_2d.get_overlapping_bodies():
		if body is Ball:
			var mult_dist = 1 + global_position.distance_to(body.global_position)/ 100
			print(mult_dist)
			body.apply_impulse(Vector2(0, -launch_power * mult_dist))

func action_released():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(paddle, "rotation_degrees", 30, 0.1)
