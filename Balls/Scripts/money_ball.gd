extends Ball

const MAX_VELOCITY : int = 1000

func _ready() -> void:
	gravity_scale = 0.5

func collided_with(module : Module):
	ScoreManager.ScoreManager.increment_score(int(module.point_value/2.0))
	ScoreManager.money += 1

func _physics_process(_delta: float) -> void:
	if linear_velocity.length() > MAX_VELOCITY:
		linear_velocity = linear_velocity.normalized() * MAX_VELOCITY
