extends Module

var damage: int = 1
@onready var camera: Camera2D = get_tree().get_first_node_in_group("camera")

func collision(ball : Ball):
	ball.apply_impulse((self.global_position - ball.global_position).normalized() * -force_value)
	camera.screen_shake()
	ball.ball_health -= damage
