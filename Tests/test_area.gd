extends Node2D

const BASIC_BALL = preload("uid://cfp62q8rk0trm")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.is_pressed():
		var ball : BasicBall = BASIC_BALL.instantiate()
		add_child(ball)
		ball.global_position = get_global_mouse_position()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Ball:
		body.queue_free()
