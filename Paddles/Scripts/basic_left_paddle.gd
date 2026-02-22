extends LeftPaddle

@onready var area_2d: Area2D = $Area2D
@onready var paddle: Node2D = $Paddle

var tween : Tween

func action_pressed():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(paddle, "rotation_degrees", -30, 0.1)
	for body in area_2d.get_overlapping_bodies():
		if body is Ball:
			body.apply_impulse(Vector2(0, -800))

func action_released():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(paddle, "rotation_degrees", 30, 0.1)
