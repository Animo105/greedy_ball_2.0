extends Ball

func _ready() -> void:
	gravity_scale = 0.5

func collided_with(module : Module):
	ScoreManager.ScoreManager.increment_score(int(module.point_value/2.0))
	ScoreManager.money += 1
