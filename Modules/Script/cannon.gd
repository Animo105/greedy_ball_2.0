extends Module

@warning_ignore("unused_parameter")
func collision(ball : Ball):
	pass


func _on_body_entered(body : Node2D):
	if body is Ball:
		body.reset()
		body.apply_impulse(Vector2(0,-1000))
