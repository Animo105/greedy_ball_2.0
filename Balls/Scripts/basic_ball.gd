extends Ball
class_name BasicBall

func collided_with(module : Module):
	ScoreManager.increment_score(module.point_value)
	ScoreManager.increment_combo()
