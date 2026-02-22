extends Module

func collision(ball : Ball):
	ball.apply_impulse((self.global_position - ball.global_position).normalized() * -force_value)
