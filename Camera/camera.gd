extends Camera2D

var max_shake: float = 10
var shake_fade: float = 10

var _shake_strenght: float = 0

func _init():
	add_to_group("camera")

func screen_shake() -> void:
	_shake_strenght = max_shake

func _process(delta: float) -> void:
	if _shake_strenght > 0:
		_shake_strenght = lerp(_shake_strenght, 0.0, shake_fade * delta)
		offset = Vector2(randf_range(-_shake_strenght, _shake_strenght),randf_range(-_shake_strenght, _shake_strenght))
