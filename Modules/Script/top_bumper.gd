extends Module

func collision(ball : Ball):
	if ball.position.y <= self.position.y:
		ball.apply_impulse((self.global_position - ball.global_position).normalized() * -force_value)
