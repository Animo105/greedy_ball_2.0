@abstract extends Paddle
class_name RightPaddle

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("paddle_right"):
		action_pressed()
	elif event.is_action_released("paddle_right"):
		action_released()
