@abstract extends Paddle
class_name LeftPaddle

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("paddle_left"):
		action_pressed()
	elif event.is_action_released("paddle_left"):
		action_released()
