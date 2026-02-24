extends Ball
class_name BasicBall

func collided_with(module : Module):
	ScoreManager.score_value += module.point_value
	ScoreManager.increment_combo()
